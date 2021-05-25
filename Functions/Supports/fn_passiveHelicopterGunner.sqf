#include "..\..\Headers\descriptionEXT\supportDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_passiveHelicopterGunner

Description:
	Spawns a helicopter that will partol a given area for a period of time.

Parameters:
	0: _centerPosition : <ARRAY(AGL), OBJECT> - The position around which the helicopter will patrol
	1: _radius : <NUMBER> - The size of the radius to patrol around
	2: _aircraftType : <STRING> - The class of the helicopter to spawn
	3: _timeOnStation : <NUMBER> - How long will the aircraft be supporting
	4: _supportSpeedLimit : <NUMBER> - The max speed the aircraft can fly while in the support radius
	5: _flyinHeight : <NUMBER> - The altittude the aircraft flys at
	6: _approachBearing : <NUMBER> - The bearing from which the aircraft will approach from (if below 0, it will be random)
	7: _globalLimiter <STRING> - The global used to limit having too many of a certain support active at any time
	8: _side : <SIDE> - The side of the created helicopter

Returns:
	ARRAY - The vehicle info
		0: <OBJECT> - The vehicle created
		1: <ARRAY> - The vehicle crew
		2: <GROUP> - The group the crew is a part of
		3: <ARRAY> - Turret units

Examples:
    (begin example)
		[
			BLWK_playAreaCenter,
			BLWK_playAreaRadius,
			[7] call BLWK_fnc_getFriendlyVehicleClass,
			180,
			20,
			50,
			0,
			"B_Heli_Attack_01_dynamicLoadout_F"
		] call BLWK_fnc_passiveHelicopterGunner;
    (end)

Author(s):
	Ansible2 // Cipher




Issues:
	- Needs to use event handlers for the destruction of the helicopter to say over the radio that the support is dead instead of a loop
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_passiveHelicopterGunner";

#define SPAWN_DISTANCE 2000
#define DETECT_ENEMY_RADIUS 700
#define MIN_RADIUS 200
#define STAR_BEARINGS [0,144,288,72,216]

params [
	"_centerPosition",
	"_radius",
	"_aircraftType",
	"_timeOnStation",
	["_supportSpeedLimit",10,[123]],
	["_flyInHeight",30,[123]],
	["_approachBearing",-1],
	["_defaultVehicleType",""],
	["_globalLimiter",""],
	["_side",BLUFOR]
];


/* ----------------------------------------------------------------------------
	verify vehicle has turrets that are not fire from vehicle and not copilot positions
---------------------------------------------------------------------------- */
private _turretsWithWeapons = [_aircraftType] call KISKA_fnc_classTurretsWithGuns;

// go to default aircraft type if no suitable turrets are found
if (_turretsWithWeapons isEqualTo []) exitWith {
	if (_aircraftType != _defaultVehicleType AND {_defaultVehicleType != ""}) then {
		[[_aircraftType," does not meet standards for function, falling back to: ",_defaultVehicleType],false] call KISKA_fnc_log;
		private _newParams = _this;
		_newParams set [2,_defaultVehicleType];
		_newParams call BLWK_fnc_passiveHelicopterGunner;
	} else {
		[[_aircraftType," does not meet standards for function and there is no default to fall back on"],true] call KISKA_fnc_log;
		[]
	};
};


if (_globalLimiter != "") then {
	missionNamespace setVariable [_globalLimiter,true];
};


/* ----------------------------------------------------------------------------
	Create vehicle
---------------------------------------------------------------------------- */
if (_approachBearing < 0) then {
	_approachBearing = round (random 360);
};
private _spawnPosition = _centerPosition getPos [SPAWN_DISTANCE,_approachBearing + 180];
_spawnPosition set [2,_flyInHeight];

private _vehicleArray = [_spawnPosition,0,_aircraftType,_side] call BIS_fnc_spawnVehicle;


private _vehicle = _vehicleArray select 0;
_vehicle flyInHeight _flyInHeight;
BLWK_zeus addCuratorEditableObjects [[_vehicle],true];



// make crew somewhat more effective by changing their behaviour
private _turretUnits = [];
private _vehicleCrew = _vehicleArray select 1;
private _turretSeperated = false;
_vehicleCrew apply {
	_x allowDamage false;
	_x disableAI "SUPPRESSION";
	_x disableAI "RADIOPROTOCOL";
	_x setSkill 1;

	// give turrets their own groups so that they can engage targets at will
	if ((_vehicle unitTurret _x) in _turretsWithWeapons) then {
	/*
		About seperating one turret...
		My testing has revealed that in order to have both turrets on a helicopter (if it has two)
		 engaging targets simultaneously, one needs to be in a seperate group from the pilot, and one
		 needs to be grouped with the pilot.
	*/
		if !(_turretSeperated) then {
			_turretSeperated = true;
			private _group = createGroup _side;
			[_x] joinSilent _group;
			_group setBehaviour "COMBAT";
			_group setCombatMode "RED";
		};
		_turretUnits pushBack _x;
	} else { // disable targeting for the other crew
		_x disableAI "AUTOCOMBAT";
		_x disableAI "TARGET";
		//_x disableAI "AUTOTARGET";
		_x disableAI "FSM";
	};
};

_vehicleArray pushBack _turretUnits;

// keep the pilots from freaking out under fire
private _pilotsGroup = _vehicleArray select 2;
_pilotsGroup setBehaviour "CARELESS"; // Only careless group will follow speed limit
// the pilot group's combat mode MUST be a fire-at-will version as it adjusts it for the entire vehicle
_pilotsGroup setCombatMode "RED";




/* ----------------------------------------------------------------------------
	Move to support zone
---------------------------------------------------------------------------- */
private _params = [
	_centerPosition,
	_radius,
	_timeOnStation,
	_supportSpeedLimit,
	_approachBearing,
	_globalLimiter,
	_side,
	_vehicle,
	_pilotsGroup,
	_vehicleCrew,
	_turretUnits
];

_params spawn {
	params [
		"_centerPosition",
		"_radius",
		"_timeOnStation",
		"_supportSpeedLimit",
		"_approachBearing",
		"_globalLimiter",
		"_side",
		"_vehicle",
		"_pilotsGroup",
		"_vehicleCrew",
		"_turretUnits"
	];

	// once you go below a certain radius, it becomes rather unnecessary
	if (_radius < MIN_RADIUS) then {
		_radius = MIN_RADIUS;
	};

	// move to support zone
	waitUntil {
		if ((!alive _vehicle) OR {(_vehicle distance2D _centerPosition) <= _radius}) exitWith {
			true
		};
		_vehicle move _centerPosition;
		sleep 2;
		false
	};

	// delete crew if vehicle got blown up on the way
	private _fn_exitForDeadVehicle = {
		if (_globalLimiter != "") then {
			missionNamespace setVariable [_globalLimiter,false];
		};

		if (_side isEqualTo BLUFOR) then {
			[TYPE_HELO_DOWN] call BLWK_fnc_supportRadioGlobal;
		};

		_vehicleCrew apply {
			if (alive _x) then {
				deleteVehicle _x
			};
		};
	};

	if (!alive _vehicle) exitWith {
		call _fn_exitForDeadVehicle;
	};


	/* ----------------------------------------------------------------------------
		Do support
	---------------------------------------------------------------------------- */
	// to keep helicopters from just wildly flying around
	_vehicle limitSpeed _supportSpeedLimit;

	private _fn_getTargets = {
		(_vehicle nearEntities [["MAN","CAR","TANK"],DETECT_ENEMY_RADIUS]) select {
			!(isAgent teamMember _x) AND
			{[side _x, _side] call BIS_fnc_sideIsEnemy}
		};
	};
	private _targetsInArea = [];

	private _sleepTime = _timeOnStation / 5;
	private "_currentTarget";
	for "_i" from 0 to 4 do {

		if (!alive _vehicle) exitWith {};

		_targetsInArea = call _fn_getTargets;
		if !(_targetsInArea isEqualTo []) then {
			_targetsInArea apply {
				_currentTarget = _x;
				_turretUnits apply {
					_x reveal [_currentTarget,4];
				};
			};
		};

		_vehicle doMove (_centerPosition getPos [_radius,STAR_BEARINGS select _i]);

		sleep _sleepTime;
	};


	/* ----------------------------------------------------------------------------
		After support is done
	---------------------------------------------------------------------------- */
	if (!alive _vehicle) exitWith {
		call _fn_exitForDeadVehicle;
	};

	if (_globalLimiter != "") then {
		missionNamespace setVariable [_globalLimiter,false];
	};

	if (_side isEqualTo BLUFOR) then {
		[TYPE_CAS_ABORT] call BLWK_fnc_supportRadioGlobal;
	};


	// remove speed limit
	_vehicle limitSpeed 99999;

	// get helicopter to disengage and rtb
	(currentPilot _vehicle) disableAI "AUTOTARGET";
	_pilotsGroup setCombatMode "BLUE";

	// not using waypoints here because they are auto-deleted for an unkown reason a few seconds after being created for the unit

	// return to spawn position area
	private _deletePosition = _centerPosition getPos [SPAWN_DISTANCE,_approachBearing + 180];
	_vehicle doMove _deletePosition;

	waitUntil {
		if (!alive _vehicle OR {(_vehicle distance2D _deletePosition) <= 200}) exitWith {true};

		// if vehicle is disabled and makes a landing, just blow it up
		if ((getPosATL _vehicle select 2) < 5) exitWith {
			_vehicle setDamage 1;
			true
		};

		sleep 2;
		false
	};


	_vehicleCrew apply {
		if (alive _x) then {
			_vehicle deleteVehicleCrew _x;
		};
	};
	if (alive _vehicle) then {
		deleteVehicle _vehicle;
	};
};


_vehicleArray

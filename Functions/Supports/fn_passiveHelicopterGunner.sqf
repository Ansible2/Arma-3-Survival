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
	4: _flyinHeight : <NUMBER> - The altittude the aircraft flys at
	5: _supportSpeedLimit : <NUMBER> - The max speed the aircraft can fly while in the support radius
	6: _approachBearing : <NUMBER> - The bearing from which the aircraft will approach from (if below 0, it will be random)
	7: _globalLimiter <STRING> - The global used to limit having too many of a certain support active at any time
	8: _side : <SIDE> - The side of the created helicopter

Returns:
	ARRAY - The vehicle info
		0: <OBJECT> - The vehicle created
		1: <ARRAY> - The vehicle crew
		2: <GROUP> - The group the crew is a part of

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
	- The helicopter sometimes stops short of the support zone and never gets inside which results in an infinite loop
	- Gunners in seperate groups DO NOT want to engage targets at will
	
	- Larger helicopters sometimes get into a very difficult to control rotation that they can't get out of
	- Sometimes, the helicopter will not RTB, it will just circle the area and eventually leave
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
	"_flyInHeight",
	"_supportSpeedLimit",
	"_approachBearing",
	"_defaultVehicleType",
	"_globalLimiter",
	["_side",BLUFOR]
];


/* ----------------------------------------------------------------------------
	verify vehicle has turrets that are not fire from vehicle and not copilot positions
---------------------------------------------------------------------------- */
// excludes fire from vehicle turrets
private _allVehicleTurrets = [_aircraftType, false] call BIS_fnc_allTurrets;
// just turrets with weapons
private _turretsWithWeapons =  [];
private ["_turretWeapons_temp","_return_temp","_turretPath_temp"];
_allVehicleTurrets apply {
	_turretPath_temp = _x;
	_turretWeapons_temp = getArray([_aircraftType,_turretPath_temp] call BIS_fnc_turretConfig >> "weapons");
	// if turrets are found
	if !(_turretWeapons_temp isEqualTo []) then {
		// some turrets are just optics, need to see they actually have ammo to shoot
		_return_temp = _turretWeapons_temp findIf {
			private _mags = [_x] call BIS_fnc_compatibleMagazines;
			!(_mags isEqualTo []) AND {!((_mags select 0) == "laserbatteries")}
		};

		if !(_return_temp isEqualTo -1) then {
			_turretsWithWeapons pushBack _turretPath_temp;
		};
	};
};
// go to default aircraft type if no suitable turrets are found
if (_turretsWithWeapons isEqualTo []) exitWith {
	private _newParams = _this;
	_newParams set [2,_defaultVehicleType];
	_newParams call BLWK_fnc_passiveHelicopterSupport;
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
_vehicleCrew apply {
	_x allowDamage false;
	_x disableAI "SUPPRESSION";	
	_x disableAI "RADIOPROTOCOL";
	_x setSkill 1;
	//_x setSkill ["spotDistance",1];
	//_x setSkill ["spotTime",1];

	// give turrets their own groups so that they can engage targets at will
	if ((_vehicle unitTurret _x) in _turretsWithWeapons) then {
		private _group = createGroup _side;
		[_x] joinSilent _group;
		_group setBehaviour "COMBAT";
		_group setCombatMode "RED";
		_turretUnits pushBack _x;
	} else { // disable targeting for the other crew
		_x disableAI "AUTOCOMBAT";
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
		_x disableAI "FSM";
	};
};


// keep the pilots from freaking out under fire
private _pilotsGroup = _vehicleArray select 2;
_pilotsGroup setBehaviour "SAFE";
_pilotsGroup setCombatMode "YELLOW";




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

null = _params spawn {
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
	hint "engage";
	
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
					(group _x) reveal [_currentTarget,4];
				};	
			};

			{
				_x commandTarget (_targetsInArea select _forEachIndex);
				_x commandFire (_targetsInArea select _forEachIndex);
			} forEach _turretUnits;
		};

		_vehicle doMove (_centerPosition getPos [_radius,STAR_BEARINGS select _i]);

		sleep _sleepTime;		
	};
/*
	while {alive _vehicle AND {time <= _timeOffStation}} do {
		
		_targetsInArea = call _fn_getTargets;
		if !(_targetsInArea isEqualTo []) then {
			_targetsInArea apply {			
				_pilotsGroup reveal [_x,4];
			};

			_movePosition = (selectRandom _targetsInArea) getPos [random 10,random 360];
			_vehicle move _movePosition;
		} else {
			_movePosition = [_centerPosition, _radius/2] call CBAP_fnc_randPos;
			_vehicle move _movePosition;
		};

		sleep 10;
	};
*/

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
	_vehicle limitSpeed 9999;
	
	[_pilotsGroup] call CBAP_fnc_clearWaypoints;
	
	private _deletePosition = _centerPosition getPos [SPAWN_DISTANCE,_approachBearing + 180];
	waitUntil {
		
		if (!alive _vehicle OR {(_vehicle distance2D _deletePosition) <= 200}) exitWith {true};
		
		// if vehicle is disabled and makes a landing, just blow it up
		if ((getPosATL _vehicle select 2) < 2) exitWith {
			_vehicle setDamage 1;
			true
		};
		
		_vehicle move _deletePosition;
		
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
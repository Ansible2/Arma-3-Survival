/* ----------------------------------------------------------------------------
Function: BLWK_fnc_aircraftGunner

Description:
	Spawns in an aircraft that circles the play area.
	Users are allowed access to all turrets on the aircraft.

Parameters:
  	0: _vehicleClass : <STRING> - The class of the vehicle to be a gunner on
	1: _loiterHeight : <NUMBER> - At what height does the aircraft fly
	2: _loiterRadius : <NUMBER> - The radius of the circle around which the 	
		aircraft will loiter

	3: _defaultVehicleType : <STRING> - A fall through vehicle class in case 
		_vehicleClass is found not to be compatible

	4: _globalUseVarString : <STRING> - A global string that is used to not allow
		other players access to the same support type simaltaneously

Returns:
	NOTHING

Examples:
    (begin example)
		private _friendlyAttackHeliClass = [7] call BLWK_fnc_getFriendlyVehicleClass;
		[
			_friendlyAttackHeliClass,
			400,
			500,
			"B_Heli_Attack_01_dynamicLoadout_F",
			"BLWK_heliGunnerInUse"
		] call BLWK_fnc_aircraftGunner;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_vehicleClass","_loiterHeight","_loiterRadius","_defaultVehicleType","_globalUseVarString"];

// verify vehicle has turrets that are not fire from vehicle and not copilot positions
// excludes fire from vehicle turrets
private _allVehicleTurrets = [_vehicleClass, false] call BIS_fnc_allTurrets;
// just turrets with weapons
private _turretsWithWeapons =  [];
private ["_turretWeapons_temp","_return_temp","_turretPath_temp"];
_allVehicleTurrets apply {
	_turretPath_temp = _x;
	_turretWeapons_temp = getArray([_vehicleClass,_turretPath_temp] call BIS_fnc_turretConfig >> "weapons");
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
	_newParams set [0,_defaultVehicleType];
	_newParams call BLWK_fnc_aircraftGunner;
};


// create vehicle
private _spawnPosition = [BLWK_playAreaMarker, true] call CBAP_fnc_randPosArea;
_spawnPosition set [2,_loiterHeight];
private _vehicleArray = [_spawnPosition,0,_vehicleClass,BLUFOR] call BIS_fnc_spawnVehicle;
private _vehicle = _vehicleArray select 0;
_vehicle allowDamage false;
// clear out vehicle cargo
clearBackpackCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;


// get rid of excess crew
private _vehicleCrew = _vehicleArray select 1;
_vehicleCrew apply {
	if ((_vehicle unitTurret _x) in _turretsWithWeapons) then {
		_vehicle deleteVehicleCrew _x
	} else {
		_x allowDamage false;
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
	};
};


// setup waypoints
private _vehicleGroup = _vehicleArray select 2;
_vehicleGroup setBehaviour "SAFE";
_vehicleGroup setCombatMode "BLUE";
private _loiterWaypoint = _vehicleGroup addWaypoint [BLWK_playAreaCenter,0];
_loiterWaypoint setWaypointType "LOITER";
_loiterWaypoint setWaypointLoiterRadius _loiterRadius;
_loiterWaypoint setWaypointLoiterType "CIRCLE_L";
_loiterWaypoint setWaypointLoiterAltitude _loiterHeight;
_vehicle flyInHeight _loiterHeight;
_loiterWaypoint setWaypointSpeed "LIMITED";


// handle view distances so things aren't cloudy
private _estimatedDistance = round (sqrt ((_loiterHeight^2) + (_loiterRadius^2)));
private _overallViewDistance = round (_estimatedDistance * 2.5);
private _objectViewDistance = round (_estimatedDistance * 1.5);
if (viewDistance < _overallViewDistance) then {
	setViewDistance _overallViewDistance;
};
if ((getObjectViewDistance select 0) < _objectViewDistance) then {
	setObjectViewDistance _objectViewDistance;
};
//hint str [_estimatedDistance,_overallViewDistance,_objectViewDistance];


// setup player interaction
BLWK_enforceArea = false;
[player,false] call BLWK_fnc_adjustStalkable; // make it so AI don't hunt the player
player allowDamage false;
player moveInTurret [_vehicle,_turretsWithWeapons select 0];

// store volume for reset
localNamespace setVariable ["BLWK_soundVolume",soundVolume];
// turrets are stupid loud
[] spawn {3 fadeSound 0.25}; 

// keep player from ejecting or switching seats with vanilla actions
_vehicle lock true; 
// disable the ability to take control of the aircraft
_vehicle enableCoPilot false; 

// set variable to limit player points while using the support
missionNamespace setVariable ["BLWK_isAircraftGunner",true];
// set this type of gunner as active so multiple people can't spam it
missionNamespace setVariable [_globalUseVarString,true,true]; 



/* ----------------------------------------------------------------------------
	Create actions to switch turrets
---------------------------------------------------------------------------- */
private _turretSwitchActions = [];
private ["_turretAction_temp","_turretMagazines_temp","_turretPath_temp"];	
{
	_turretPath_temp = _x;

	_turretAction_temp = [	
		player,
		format ["<t color='#3c77ba'>Switch To Turret %1</t>",_forEachIndex + 1], 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		["!(((objectParent player) turretUnit ",str _turretPath_temp,") isEqualTo player)"] joinString "", // check if units current turret is the stored one, don't show if it is
		"true", 
		{}, 
		{}, 
		{
			params ["_target", "_caller", "", "_arguments", "", ""];
			moveOut _caller;
			_caller moveInTurret [(_arguments select 0),_arguments select 1];
		}, 
		{}, 
		[_vehicle,_turretPath_temp], 
		0.5, 
		1, 
		false, 
		false, 
		false
	] call BIS_fnc_holdActionAdd;

	_turretSwitchActions pushBack _turretAction_temp;

	// give turrets a bit more ammo
	_turretMagazines_temp = _vehicle magazinesTurret _turretPath_temp;
	_turretMagazines_temp apply {
		_vehicle addMagazineTurret [_x,_turretPath_temp];
	};
} forEach _turretsWithWeapons;


/* ----------------------------------------------------------------------------
	Store exit function
---------------------------------------------------------------------------- */
localNamespace setVariable ["BLWK_fnc_exitFromAircraft",{
	params ["_caller","_actionId","_arguments"];

	missionNamespace setVariable ["BLWK_isAircraftGunner",false];

	3 fadeSound (localNamespace getVariable "BLWK_soundVolume");

	setViewDistance -1;
	setObjectViewDistance -1;

	moveOut _caller;
	_caller setVehiclePosition [BLWK_mainCrate,[],5,"NONE"];
	_caller setVelocity [0,0,0];
	[_caller,true] call BLWK_fnc_adjustStalkable;

	// add this action id to list of switch turret actions for removal
	private _actions = _arguments select 0;
	_actions pushBack _actionId;
	_actions apply {
		[_caller,_x] call BIS_fnc_holdActionRemove;
	};

	// delete vehicle
	private _vehicle = _arguments select 1;
	private _vehicleGroup = _arguments select 2;
	(units _vehicleGroup) apply {
		_vehicle deleteVehicleCrew _x;
	};
	deleteGroup _vehicleGroup;
	deleteVehicle _vehicle;

	// allow other users to access the support type again
	missionNamespace setVariable [_arguments select 3,false,true];
	
	[] spawn BLWK_fnc_playAreaEnforcementLoop;

	sleep 10;

	_caller allowDamage true;
}];


/* ----------------------------------------------------------------------------
	Create action to exit the support and return to The Crate
---------------------------------------------------------------------------- */
private _exitAction = [	
	player,
	"<t color='#c91306'>Return To The Crate</t>", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"true",
	"true", 
	{}, 
	{}, 
	{
		[_this select 1,_this select 2,_this select 3] call (localNamespace getVariable "BLWK_fnc_exitFromAircraft");
	}, 
	{}, 
	[_turretSwitchActions,_vehicle,_vehicleGroup,_globalUseVarString], 
	1, 
	1, 
	false, 
	false, 
	false
] call BIS_fnc_holdActionAdd;



/* ----------------------------------------------------------------------------
	While in use loop
---------------------------------------------------------------------------- */
[[_turretSwitchActions,_vehicle,_vehicleGroup,_globalUseVarString],_exitAction] spawn {
	params ["_actionArgs","_exitAction"];
	
	private _vehicle = _actionArgs select 1;
	// waitUntil we have started a wave to start counting them towards a lifetime
	waitUntil {
		if (!BLWK_inBetweenWaves OR {isNull _vehicle}) exitWith {true};
		sleep 10;
		false
	};

	// the null check for the vehicle is here so many times because at any given point
	// the player can initiate a manual return to The Crate
	if (isNull _vehicle) exitWith {};

	// wait to delete support
	private _startingWave = BLWK_currentWaveNumber;
	private _endWave = _startingWave + BLWK_aircraftGunnerLifetime;
	private _informed = false;
	waitUntil {
		if (!_informed AND {BLWK_currentWaveNumber == (_endWave - 1)}) then {
			hint parseText "<t color='#03d7fc'>You gunner support will end the next wave!</t>";
			_informed = true;
		};
		if (BLWK_currentWaveNumber >= _endWave) exitWith {true};
		if (isNull _vehicle) exitWith {true};
		// if player died
		if !(player in _vehicle) exitWith {true};
		sleep 10;
		false
	};

	if (isNull _vehicle) exitWith {};

	hint "Your support expired";

	[player,_exitAction,_actionArgs] call (localNamespace getVariable "BLWK_fnc_exitFromAircraft");
};
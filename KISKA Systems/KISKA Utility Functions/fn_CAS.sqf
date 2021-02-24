/* ----------------------------------------------------------------------------
Function: KISKA_fnc_CAS

Description:
	Completes either a gun run, bomb run, rockets, or rocket and gun strike.

Parameters:
	0: _attackPosition : <OBJECT or ARRAY> - ASL position or object to attack
	1: _attackTypeID : <NUMBER> - 0 - Guns, 1 - Rockets, 2 - Guns & Rockets, 3 - Bomb
	2: _attackDirection : <NUMBER> - The direction the aircraft should approach from relative to North
	3: _planeClass : <STRING> - The className of the aircraft
	4: _attackHeight : <NUMBER> - At what height should the aircraft start firing
	5: _spawnDistance : <NUMBER> - How far away to spawn the aircraft
	6: _breakOffDistance : <NUMBER> - The distance to target at which the aircraft should definately disengage and fly away (to not crash)
	7: _allowDamage : <BOOL> - Allow damage of both the crew and aircraft

Returns:
	NOTHING

Examples:
    (begin example)

		[myTarget] spawn KISKA_fnc_CAS;

    (end)

Author(s):
	Bohemia Interactive,
	Modified By: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define GUN_RUN_ID 0
#define GUNS_AND_ROCKETS_ARMOR_PIERCING_ID 1
#define GUNS_AND_ROCKETS_HE_ID 2
#define ROCKETS_ARMOR_PIERCING_ID 3
#define ROCKETS_HE_ID 4
#define AGM_ID 5
#define BOMB_UGB_ID 6
#define BOMB_CLUSTER_ID 7

#define CANNON_TYPE "CANNON"
#define AGM_TYPE "AGM"
#define ROCKETS_AP_TYPE "ROCKETS_AP"
#define ROCKETS_HE_TYPE "ROCKETS_HE"
#define BOMB_UGB_TYPE "BOMB UGB"
#define BOMB_CLUSTER_TYPE "BOMB CLUSTER"

#define DEFAULT_CANNON_CLASS "Twin_Cannon_20mm"
#define DEFAULT_CANNON_MAG_CLASS "PylonWeapon_300Rnd_20mm_shells"

#define PLANE_SPEED 75// m/s
#define PLANE_VELOCITY(THE_SPEED) [0,THE_SPEED,0]

#define SCRIPT_NAME "KISKA_fnc_CAS"
scriptName SCRIPT_NAME;

params [
	["_attackPosition",objNull,[[],objNull]],
	["_attackTypeID",0,[123]],
	["_attackDirection",0,[123]],
	["_planeClass","B_Plane_CAS_01_dynamicLoadout_F",[""]],
	["_attackHeight",1300,[123]],
	["_spawnDistance",2000,[123]],
	["_breakOffDistance",500,[123]],
	["_allowDamage",false,[true]]
];

if (_attackPosition isEqualType objNull AND {isNull _attackPosition} OR {_attackPosition isEqualTo []}) exitWith {
	[[_attackPosition," is an invalid target"],true] call KISKA_fnc_log;
};

private _planeCfg = configfile >> "cfgvehicles" >> _planeClass;
if !(isclass _planeCfg) exitwith {
	[[_planeClass," Vehicle class not found, moving to default aircraft..."],true] call KISKA_fnc_log;
	_this set [3,"B_Plane_CAS_01_dynamicLoadout_F"];
	_this spawn KISKA_fnc_CAS; 
};


/* ----------------------------------------------------------------------------

	select weapons to use

---------------------------------------------------------------------------- */
private _attackMagazines = switch _attackTypeID do {
	case GUN_RUN_ID: {
		[CANNON_TYPE]
	};
	case GUNS_AND_ROCKETS_ARMOR_PIERCING_ID: {
		[CANNON_TYPE,[ROCKETS_AP_TYPE,"PylonRack_7Rnd_Rocket_04_AP_F"]]
	};
	case GUNS_AND_ROCKETS_HE_ID: {
		[CANNON_TYPE,[ROCKETS_HE_TYPE,"PylonRack_7Rnd_Rocket_04_HE_F"]]
	};
	case ROCKETS_ARMOR_PIERCING_ID: {
		[[ROCKETS_AP_TYPE,"PylonRack_7Rnd_Rocket_04_AP_F"]]
	};
	case ROCKETS_HE_ID: {
		[[ROCKETS_HE_TYPE,"PylonRack_7Rnd_Rocket_04_HE_F"]]
	};
	case AGM_ID: {
		[[AGM_TYPE,"PylonRack_1Rnd_Missile_AGM_02_F"]]
	};
	case BOMB_UGB_ID: {
		[[BOMB_UGB_TYPE,"PylonMissile_1Rnd_Bomb_04_F"]]
	};
	case BOMB_CLUSTER_ID: {
		[[BOMB_CLUSTER_TYPE,"PylonMissile_1Rnd_BombCluster_01_F"]]
	};
};


private _exitToDefault = false;


////// Verify the plane has the right weapons for what is asked of it and adjust if it doesn't //////
private _weaponsToUse = [];
private _planeClassWeapons = _planeClass call BIS_fnc_weaponsEntityType;
private _pylonConfig = _planeCfg >> "Components" >> "TransportPylonsComponent" >> "pylons";

// if the plane has pylons
if (isClass _pylonConfig) then {
	
	private _allVehiclePylons =  ("true" configClasses _pylonConfig) apply {configName _x};	

	// some planes (Buzzard) have their cannon as a pylon, don't want to replace it if needed
	if (CANNON_TYPE in _attackMagazines) then {
		
		// find the cannon weapon in the planes default loadout
		private _cannonIndex = _planeClassWeapons findIf {
			[
				(configFile >> "cfgWeapons" >> _x),
				(configFile >> "cfgWeapons" >> "cannonCore")
			] call CBA_fnc_inheritsFrom;
		};

		private _cannonClass = "";
		// if a cannon is found, use it, else add one
		private _canonPylonData = [];
		if (_cannonIndex != -1) then {

			_cannonClass = _planeClassWeapons select _cannonIndex;

			// if the cannon is on a pylon delete the pylon from the list so it's not changed
			private _cannonPylonIndex = _allVehiclePylons findIf {
				getText(_pylonConfig >> _x >> "attachment") == _cannonClass;
			};
			if (_cannonPylonIndex != -1) then {
				_allVehiclePylons deleteAt _cannonPylonIndex;
			};

		} else {

			_cannonClass = DEFAULT_CANNON_CLASS;
			_canonPylonData pushBack DEFAULT_CANNON_MAG_CLASS;
			private _pylonToUse = _allVehiclePylons deleteAt 0; // set the first pylon as the cannon
			_canonPylonData pushBack _pylonToUse;
		};
			
		_weaponsToUse pushBack [CANNON_TYPE,_cannonClass,_canonPylonData];
		// remove cannon so we don't need to check it later
		_attackMagazines deleteAt (_attackMagazines find CANNON_TYPE);

	};

	if !(_attackMagazines isEqualTo []) then {
		private ["_attackTypeString","_attackMagazineClass","_attackWeaponClass"];
		{	
			[["attackMag is: ",_x],false] call KISKA_fnc_log;
			_attackMagazineClass = _x select 1;
			_attackWeaponClass = [configFile >> "cfgMagazines" >> _attackMagazineClass >> "pylonWeapon"] call BIS_fnc_getCfgData;

			_attackTypeString = _x select 0;
			// pushBack string for attack type, the weapon used, the mag for adding a pylon, and what pylon to add it to
			_weaponsToUse pushBack [_attackTypeString,_attackWeaponClass,[_attackMagazineClass,_allVehiclePylons deleteAt 0]];
		} forEach _attackMagazines;
	};
} else {
	_exitToDefault = true;
};


if (_exitToDefault) exitwith {
	[["Weapon types of ",_attackMagazines," for plane class: ",_planeClass," not entirely found, moving to default Aircraft..."],true] call KISKA_fnc_log;
	// exit to default aircraft type 
	_this set [3,"B_Plane_CAS_01_dynamicLoadout_F"];
	_this spawn KISKA_fnc_CAS;
};


/* ----------------------------------------------------------------------------

	Define attack function

---------------------------------------------------------------------------- */
KISKA_fnc_casAttack = {
	params ["_plane","_dummyTarget","_weaponsToUse","_attackTypeID","_attackPosition","_breakOffDistance"];
	
	private ["_weapon_temp","_weaponArray_temp"];
	private _pilot = currentPilot _plane;
	
	private _fn_setWeaponTemp = {
		params ["_type"];
		_weaponArray_temp = _weaponsToUse select (_weaponsToUse findIf {(_x select 0) == _type});
		_weapon_temp = _weaponArray_temp select 1;
	};
	private _fn_fireGun = {
		params ["_numRounds"];
		// set _weapon_temp to gun
		[CANNON_TYPE] call _fn_setWeaponTemp;
		for "_i" from 1 to _numRounds do {
			if ((_plane distance _attackPosition) < _breakOffDistance) exitWith {};
			_pilot fireAtTarget [_dummyTarget,_weapon_temp];
			sleep 0.03;
		};
	};
	private _fn_fireRockets = {
		params ["_numRounds","_type"];
		// find rocket launcher
		[_type] call _fn_setWeaponTemp;
		for "_i" from 1 to _numRounds do {
			if ((_plane distance _attackPosition) < _breakOffDistance) exitWith {};
			_pilot fireAtTarget [_dummyTarget,_weapon_temp];
			sleep 0.5;
		};
	};
	private _fn_fireSimple = {
		params ["_type"];
		[_type] call _fn_setWeaponTemp;
		_pilot fireAtTarget [_dummyTarget,_weapon_temp];
	};

	// decide how to fire
	switch (_attackTypeID) do {
		case GUN_RUN_ID: {
			[200] call _fn_fireGun;
		};
		case GUNS_AND_ROCKETS_ARMOR_PIERCING_ID: {
			[100] call _fn_fireGun;
			[6,ROCKETS_AP_TYPE] call _fn_fireRockets;
		};
		case GUNS_AND_ROCKETS_HE_ID: {
			[100] call _fn_fireGun;
			[6,ROCKETS_HE_TYPE] call _fn_fireRockets;
		};
		case ROCKETS_ARMOR_PIERCING_ID: {
			[8,ROCKETS_AP_TYPE] call _fn_fireRockets;
		};
		case ROCKETS_HE_ID: {
			[8,ROCKETS_HE_TYPE] call _fn_fireRockets;
		};
		case AGM_ID: {
			[AGM_TYPE] call _fn_fireSimple;
		};
		case BOMB_UGB_ID: {
			[BOMB_UGB_TYPE] call _fn_fireSimple;
		};
		case BOMB_CLUSTER_ID: {
			[BOMB_CLUSTER_TYPE] call _fn_fireSimple;
		};
	};

	_plane setVariable ["KISKA_completedFiring",true];
};


/* ----------------------------------------------------------------------------

	Position plane towards target

---------------------------------------------------------------------------- */
private _planeSpawnPosition = _attackPosition getPos [_spawnDistance,_attackDirection + 180];
_planeSpawnPosition set [2,_attackHeight];
private _planeSide = (getnumber (_planeCfg >> "side")) call BIS_fnc_sideType;
private _planeArray = [_planeSpawnPosition,_attackDirection,_planeClass,_planeSide] call BIS_fnc_spawnVehicle;
private _plane = _planeArray select 0;
private _crew = _planeArray select 1;

if !(_allowDamage) then {
	_plane allowDamage false;
	_crew apply {
		_x allowDamage false;
	};
};


// update the planes pylons
_weaponsToUse apply {
	private _pylonData = _x select 2;
	// the cannon may not have any pylon data and therefore _pylonData will be []
	if !(_pylonData isEqualTo []) then {
		(_x select 2) params ["_magClass","_pylon"];
		_plane setPylonLoadout [_pylon,_magClass,true];
	};
};



_plane setPosASL _planeSpawnPosition;
_plane setDir _attackDirection;

// telling the plane to ultimately fly past the target after we're done controlling it
_plane move (_attackPosition getPos [5000,_attackDirection]);
_plane disableAi "move";
_plane disableAi "target";
_plane disableAi "autotarget";
_plane setCombatMode "blue";


// angling the plane towards the target
if (_attackPosition isEqualType objNull) then {
	_attackPosition = getPosASLVisual _attackPosition;
};

// yaw
private _planePositionASL = getPosASLVisual _plane;
private _planeVectorDir = _planePositionASL vectorFromTo _attackPosition;
_plane setVectorDir _planeVectorDir;
// pitch
private _planePitch = atan (_spawnDistance / _attackHeight);
[_plane,-90 + _planePitch,0] call BIS_fnc_setPitchBank;

// set plane's speed to 200 km/h
_plane setVelocityModelSpace PLANE_VELOCITY(PLANE_SPEED);


/* ----------------------------------------------------------------------------

	Fix planes velocity towards the target

---------------------------------------------------------------------------- */
// get flight characteristics to steer the plane onto target
private _distanceToTarget = _attackPosition vectorDistance _planePositionASL;
private _flightTime = (_distanceToTarget - _breakOffDistance) / PLANE_SPEED;
private _startTime = time;
private _timeAfterFlight = time + _flightTime;
private _planeVectorUp = vectorUpVisual _plane;

private ["_interval","_planeVectorDirTo","_planeVectorDirFrom"];
while {!(isNull _plane) AND {!(_plane getVariable ["KISKA_completedFiring",false])} AND {(_plane distance _attackPosition) > _breakOffDistance}} do {
	//--- Set the plane approach vector
	_interval = linearConversion [_startTime,_timeAfterFlight,time,0,1];
	_planeVectorDirTo = _planePositionASL vectorFromTo _attackPosition;
	_planeVectorDirFrom = vectorDirVisual _plane;
	
	_plane setVelocityTransformation [
		_planeSpawnPosition, _attackPosition,
		PLANE_VELOCITY(PLANE_SPEED), PLANE_VELOCITY(PLANE_SPEED),
		_planeVectorDirFrom,_planeVectorDirTo,
		_planeVectorUp, _planeVectorUp,
		_interval
	];
	_planePositionASL = getPosASLVisual _plane;
	_plane setVelocityModelSpace PLANE_VELOCITY(PLANE_SPEED);


	// start firing
	// check if plane is 1200m from target and hasn't already started shooting
	if ((_planePositionASL vectorDistance _attackPosition) <= 1200) then {
		
		
		//private "_dummyTarget";
		if (!(isNull _plane) AND {!(_plane getVariable ["KISKA_startedFiring",false])}) then {
			_plane setVariable ["KISKA_startedFiring",true];
			// create a target to shoot at
			private _dummyTargetClass = ["LaserTargetE","LaserTargetW"] select (_planeSide getfriend west > 0.6);
			private _dummyTarget = createvehicle [_dummyTargetClass,[0,0,0],[],0,"NONE"];
			_plane setVariable ["KISKA_casDummyTarget",_dummyTarget];
			_dummyTarget setPosASL _attackPosition;	
			_plane reveal laserTarget _dummyTarget;
			_plane dowatch laserTarget _dummyTarget;
			_plane dotarget laserTarget _dummyTarget;

			[_plane,_dummyTarget,_weaponsToUse,_attackTypeID,_attackPosition,_breakOffDistance] spawn KISKA_fnc_casAttack;
		} else {
			// ensures strafing effect with the above setVelocityTransformation
			/// for some reason, private variables outside the main if here do not work
			/// had to use this method of storing the target instead
			if !(isNull _plane) then {
				private _dummyTarget = _plane getVariable "KISKA_casDummyTarget";
				_attackPosition = AGLToASL(_dummyTarget getPos [0.1,(getDirVisual _plane)]);
				_dummyTarget setPosASL _attackPosition;
			};
		};
	};

	sleep 0.01;
};


/* ----------------------------------------------------------------------------

	Handle After CAS complete

---------------------------------------------------------------------------- */
// forces plane to keep flying in the general direction they currently are
// if not, once the setVelocityTransformation loop is done, it can rapidly change course
_plane setVelocityModelSpace PLANE_VELOCITY(PLANE_SPEED);

// after fire is complete
_plane flyInHeight (_attackHeight * 2);


// pop flares
for "_i" from 1 to 4 do {
	currentPilot _plane forceweaponfire ["CMFlareLauncher","Burst"];
	sleep 1
};

// give the plane some time to get out of audible distance before deletion
sleep 60;

// delete
_crew apply {
	if (!isNull _x) then {
		_plane deleteVehicleCrew _x;
	};
};

if (alive _plane) then {
	deletevehicle _plane;
};

private _group = _planeArray select 2;
if (!isNull _group) then {
	deletegroup _group;
};
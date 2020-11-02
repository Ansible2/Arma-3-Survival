/* ----------------------------------------------------------------------------
Function: BLWK_fnc_CAS

Description:
	Completes either a gun run, bomb run, rockets, or rocket and gun strike.

Parameters:
	0: _attackPosition : <OBJECT or ARRAY> - ASL position or object to attack
	1: _attackTypeID : <NUMBER> - 0 - Guns, 1 - Rockets, 2 - Guns & Rockets, 3 - Bomb
	2: _attackDirection : <NUMBER> - The direction the aircraft should approach from relative to North
	3: _planeClass : <STRING> - The className of the aircraft

Returns:
	NOTHING

Examples:
    (begin example)

		null = [myTarget] spawn BLWK_fnc_CAS;

    (end)

Author(s):
	Bohemia Interactive,
	Modified By: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_attackPosition",objNull,[[],objNull]],
	["_attackTypeID",0,[123]],
	["_attackDirection",0,[123]],
	["_planeClass","B_Plane_CAS_01_F",[""]]
];

if (_attackPosition isEqualType objNull AND {isNull _attackPosition} OR {_attackPosition isEqualTo []}) exitWith {
	["%1 is invalid target",_attackPosition] call BIS_fnc_error;

	false
};

private _planeCfg = configfile >> "cfgvehicles" >> _planeClass;
if !(isclass _planeCfg) exitwith {
	["Vehicle class '%1' not found",_planeClass] call BIS_fnc_error; 
	false
};


/* ----------------------------------------------------------------------------

	select weapons to use

---------------------------------------------------------------------------- */
#define GUN_RUN_ID 0
#define ROCKETS_ID 1
#define GUNS_AND_ROCKETS_ID 2
#define BOMBS_ID 3
private _attackTypesString = switch _attackTypeID do {
	case GUN_RUN_ID: {["machinegun"]};
	case ROCKETS_ID: {["rocketlauncher"]};
	case GUNS_AND_ROCKETS_ID: {["machinegun","rocketlauncher"]};
	case BOMBS_ID: {["bomblauncher"]};
	default {[]};
};

// get planes weapon lists
private _weaponsToUse = [];
private _planeClassWeapons = _planeClass call BIS_fnc_weaponsEntityType;
private ["_fireModes_temp","_mode_temp","_weaponType_temp"];
_planeClassWeapons apply {

	// get weapon type to see if it matches any in the _attackTypesString array
	// "in" command is CASE SENSETIVE
	_weaponType_temp = tolower ((_x call BIS_fnc_itemType) select 1);
	if (_weaponType_temp in _attackTypesString) then {
		// get the weapon's modes
		_fireModes_temp = getarray(configfile >> "cfgweapons" >> _x >> "modes");
		if (count _fireModes_temp > 0) then {
			_mode_temp = _fireModes_temp select 0;
			if (_mode_temp == "this") then {
				_mode_temp = _x
			};
			// CIPHER COMMENT: may not even need _mode_temp here
			_weaponsToUse pushBack [_x,_mode_temp,_weaponType_temp];
		};
	};
};
if (_weaponsToUse isEqualTo []) exitwith {
	["No weapon of types %2 found on '%1', moving to default Aircraft",_planeClass,_attackTypesString] call BIS_fnc_error;
	// exit to default aircraft type 
	null = [_attackPosition,_attackTypeID,_attackDirection,"B_Plane_CAS_01_F"] spawn BLWK_fnc_CAS;
};


/* ----------------------------------------------------------------------------

	Define attack function

---------------------------------------------------------------------------- */
BLWK_fnc_casAttack = {
	params ["_plane","_dummyTarget","_weaponsToUse","_attackTypeID"];
	
	private ["_weapon_temp","_weaponArray_temp"];
	private _pilot = currentPilot _plane;
	
	private _fn_fireGun = {
		params ["_numRounds"];
		// find gun to fire
		_weaponArray_temp = _weaponsToUse select (_weaponsToUse findIf {(_x select 2) == "machinegun"});
		_weapon_temp = _weaponArray_temp select 0;
		for "_i" from 1 to _numRounds do {
			_pilot fireAtTarget [_dummyTarget,_weapon_temp];
			sleep 0.03;
		};
	};
	private _fn_fireRockets = {
		params ["_numRounds"];
		// find rocket launcher
		_weaponArray_temp = _weaponsToUse select (_weaponsToUse findIf {(_x select 2) == "rocketlauncher"});
		_weapon_temp = _weaponArray_temp select 0;
		for "_i" from 1 to _numRounds do {
			_pilot fireAtTarget [_dummyTarget,_weapon_temp];
			sleep 0.5;
		};
	};
	
	if (_attackTypeID isEqualTo GUN_RUN_ID) exitWith {
		[200] call _fn_fireGun;
		_plane setVariable ["BLWK_completedFiring",true];
	};
	if (_attackTypeID isEqualTo ROCKETS_ID) exitWith {
		[8] call _fn_fireRockets;
		_plane setVariable ["BLWK_completedFiring",true];
	};
	if (_attackTypeID isEqualTo GUNS_AND_ROCKETS_ID) exitWith {
		[100] call _fn_fireGun;
		[4] call _fn_fireRockets;
		_plane setVariable ["BLWK_completedFiring",true];
	};
	if (_attackTypeID isEqualTo BOMBS_ID) exitWith {
		_weaponArray_temp = _weaponsToUse select (_weaponsToUse findIf {(_x select 2) == "bomblauncher"});
		_weapon_temp = _weaponArray_temp select 0;
		_pilot fireAtTarget [_dummyTarget,_weapon_temp];
		_plane setVariable ["BLWK_completedFiring",true];
	};
};


/* ----------------------------------------------------------------------------

	Position plane towards target

---------------------------------------------------------------------------- */
#define ATTACK_HEIGHT 1000
#define ATTACK_DISTANCE 2000

private _planeSpawnPosition = _attackPosition getPos [ATTACK_DISTANCE,_attackDirection + 180];
_planeSpawnPosition set [2,ATTACK_HEIGHT];
private _planeSide = (getnumber (_planeCfg >> "side")) call BIS_fnc_sideType;
private _planeArray = [_planeSpawnPosition,_attackDirection,_planeClass,_planeSide] call BIS_fnc_spawnVehicle;
private _plane = _planeArray select 0;
_plane setPosASL _planeSpawnPosition;
_plane setDir _attackDirection;

// telling the plane to ultimately fly past the target after we're done controlling it
_plane move (_attackPosition getPos [5000,_attackDirection]);
_plane disableai "move";
_plane disableai "target";
_plane disableai "autotarget";
_plane setcombatmode "blue";


// angling the plane towards the target
if (_attackPosition isEqualType objNull) then {
	_attackPosition = getPosASLVisual _attackPosition;
};

// yaw
private _planePositionASL = getPosASLVisual _plane;
private _planeVectorDir = _planePositionASL vectorFromTo _attackPosition;
_plane setVectorDir _planeVectorDir;
// pitch
private _planePitch = atan (ATTACK_DISTANCE / ATTACK_HEIGHT);
[_plane,-90 + _planePitch,0] call BIS_fnc_setPitchBank;

// set plane's speed to 200 km/h
#define PLANE_SPEED 75// m/s
#define PLANE_VELOCITY(THE_SPEED) [0,THE_SPEED,0]
_plane setVelocityModelSpace PLANE_VELOCITY(PLANE_SPEED);


/* ----------------------------------------------------------------------------

	Fix planes velocity towards the target

---------------------------------------------------------------------------- */
// get flight characteristics to steer the plane onto target
#define BREAK_OFF_DISTANCE 500
private _distanceToTarget = _attackPosition vectorDistance _planePositionASL;
private _flightTime = (_distanceToTarget - BREAK_OFF_DISTANCE) / PLANE_SPEED;
private _startTime = time;
private _timeAfterFlight = time + _flightTime;
private _planeVectorUp = vectorUpVisual _plane;

private ["_interval","_planeVectorDirTo","_planeVectorDirFrom"];
while {!(_plane getVariable ["BLWK_completedFiring",false])} do {
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
	// check if plane is 1000m from target and hasn't already started shooting
	if ((_planePositionASL vectorDistance _attackPosition) <= 1200) then {
		
		
		//private "_dummyTarget";
		if !(_plane getVariable ["BLWK_startedFiring",false]) then {
			_plane setVariable ["BLWK_startedFiring",true];
			// create a target to shoot at
			private _dummyTargetClass = ["LaserTargetE","LaserTargetW"] select (_planeSide getfriend west > 0.6);
			private _dummyTarget = createvehicle [_dummyTargetClass,[0,0,0],[],0,"NONE"];
			_plane setVariable ["BLWK_casDummyTarget",_dummyTarget];
			_dummyTarget setPosASL _attackPosition;	
			_plane reveal laserTarget _dummyTarget;
			_plane dowatch laserTarget _dummyTarget;
			_plane dotarget laserTarget _dummyTarget;

			null = [_plane,_dummyTarget,_weaponsToUse,_attackTypeID] spawn BLWK_fnc_casAttack;
		} else {
			// ensures strafing effect with the above setVelocityTransformation
			if !("bomblauncher" in _attackTypesString) then {
				// for some reason, private variables outside the main if here do not work
				// had to use this method of storing the target instead
				private _dummyTarget = _plane getVariable "BLWK_casDummyTarget";
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
_plane flyInHeight (ATTACK_HEIGHT * 2);


// pop flares
for "_i" from 1 to 4 do {
	currentPilot _plane forceweaponfire ["CMFlareLauncher","Burst"];
	sleep 1
};

// give the plane some time to get out of audible distance before deletion
sleep 45;

// delete
if (alive _plane) then {
	private _group = group _plane;
	private _crew = crew _plane;
	_crew apply {
		_plane deleteVehicleCrew _x;
	};	
	deletevehicle _plane;
	deletegroup _group;
};
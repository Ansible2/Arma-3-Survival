//BIS_fnc_moduleCAS
//a3\modules_f_curator\CAS\functions\fn_moduleCAS.sqf

_logic = _this select 0;
_units = _this select 1;
_activated = _this select 2;

//--- Terminate on client (unless it's curator who created the module)
if (!isserver && {local _x} count (objectcurators _logic) == 0) exitwith {};

if (_activated) then {

	//--- Wait for params to be set
	if (_logic call bis_fnc_isCuratorEditable) then {
		waituntil {!isnil {_logic getvariable "vehicle"} || isnull _logic};
	};
	if (isnull _logic) exitwith {};

	//--- Show decal
	if ({local _x} count (objectcurators _logic) > 0) then {
		//--- Reveal the circle to curators
		_logic hideobject false;
		_logic setpos position _logic;
	};
	if !(isserver) exitwith {};

	_planeClass = _logic getvariable ["vehicle","B_Plane_CAS_01_F"];
	_planeCfg = configfile >> "cfgvehicles" >> _planeClass;
	if !(isclass _planeCfg) exitwith {["Vehicle class '%1' not found",_planeClass] call bis_fnc_error; false};

	//--- Restore custom direction
	_dirVar = _fnc_scriptname + typeof _logic;
	_logic setdir (missionnamespace getvariable [_dirVar,direction _logic]);

	//--- Detect gun
	_weaponTypesID = _logic getvariable ["type",getnumber (configfile >> "cfgvehicles" >> typeof _logic >> "moduleCAStype")];
	_weaponTypes = switch _weaponTypesID do {
		case 0: {["machinegun"]};
		case 1: {["missilelauncher"]};
		case 2: {["machinegun","missilelauncher"]};
		case 3: {["bomblauncher"]};
		default {[]};
	};
	_weapons = [];
	{
		if (tolower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then {
			_modes = getarray (configfile >> "cfgweapons" >> _x >> "modes");
			if (count _modes > 0) then {
				_mode = _modes select 0;
				if (_mode == "this") then {_mode = _x;};
				_weapons set [count _weapons,[_x,_mode]];
			};
		};
	} foreach (_planeClass call bis_fnc_weaponsEntityType);//getarray (_planeCfg >> "weapons");
	if (count _weapons == 0) exitwith {["No weapon of types %2 wound on '%1'",_planeClass,_weaponTypes] call bis_fnc_error; false};

	_posATL = getposatl _logic;
	_pos = +_posATL;
	_pos set [2,(_pos select 2) + getterrainheightasl _pos];
	_dir = direction _logic;

	_dis = 3000;
	_alt = 1000;
	_pitch = atan (_alt / _dis);
	_speed = 400 / 3.6;
	_duration = ([0,0] distance [_dis,_alt]) / _speed;

	//--- Create plane
	_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
	_planePos set [2,(_pos select 2) + _alt];
	_planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
	_planeArray = [_planePos,_dir,_planeClass,_planeSide] call bis_fnc_spawnVehicle;
	_plane = _planeArray select 0;
	_plane setposasl _planePos;
	_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
	_plane disableai "move";
	_plane disableai "target";
	_plane disableai "autotarget";
	_plane setcombatmode "blue";

	_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
	_velocity = [_vectorDir,_speed] call BIS_fnc_vectorMultiply;
	_plane setvectordir _vectorDir;
	[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
	_vectorUp = vectorup _plane;

	//--- Remove all other weapons;
	_currentWeapons = weapons _plane;
	{
		if !(tolower ((_x call bis_fnc_itemType) select 1) in (_weaponTypes + ["countermeasureslauncher"])) then {
			_plane removeweapon _x;
		};
	} foreach _currentWeapons;

	//--- Cam shake
	_ehFired = _plane addeventhandler [
		"fired",
		{
			_this spawn {
				_plane = _this select 0;
				_plane removeeventhandler ["fired",_plane getvariable ["ehFired",-1]];
				_projectile = _this select 6;
				waituntil {isnull _projectile};
				[[0.005,4,[_plane getvariable ["logic",objnull],200]],"bis_fnc_shakeCuratorCamera"] call bis_fnc_mp;
			};
		}
	];
	_plane setvariable ["ehFired",_ehFired];
	_plane setvariable ["logic",_logic];
	_logic setvariable ["plane",_plane];

	//--- Show hint
	[[["Curator","PlaceOrdnance"],nil,nil,nil,nil,nil,nil,true],"bis_fnc_advHint",objectcurators _logic] call bis_fnc_mp;

	//--- Play radio
	[_plane,"CuratorModuleCAS"] call bis_fnc_curatorSayMessage;

	//--- Debug - visualize tracers
	if (false) then {
		BIS_draw3d = [];
		//{deletemarker _x} foreach allmapmarkers;
		_m = createmarker [str _logic,_pos];
		_m setmarkertype "mil_dot";
		_m setmarkersize [1,1];
		_m setmarkercolor "colorgreen";
		_plane addeventhandler [
			"fired",
			{
				_projectile = _this select 6;
				[_projectile,position _projectile] spawn {
					_projectile = _this select 0;
					_posStart = _this select 1;
					_posEnd = _posStart;
					_m = str _projectile;
					_mColor = "colorred";
					_color = [1,0,0,1];
					if (speed _projectile < 1000) then {
						_mColor = "colorblue";
						_color = [0,0,1,1];
					};
					while {!isnull _projectile} do {
						_posEnd = position _projectile;
						sleep 0.01;
					};
					createmarker [_m,_posEnd];
					_m setmarkertype "mil_dot";
					_m setmarkersize [1,1];
					_m setmarkercolor _mColor;
					BIS_draw3d set [count BIS_draw3d,[_posStart,_posEnd,_color]];
				};
			}
		];
		if (isnil "BIS_draw3Dhandler") then {
			BIS_draw3Dhandler = addmissioneventhandler ["draw3d",{{drawline3d _x;} foreach (missionnamespace getvariable ["BIS_draw3d",[]]);}];
		};
	};

	//--- Approach
	_fire = [] spawn {waituntil {false}};
	_fireNull = true;
	_time = time;
	_offset = if ({_x == "missilelauncher"} count _weaponTypes > 0) then {20} else {0};
	waituntil {
		_fireProgress = _plane getvariable ["fireProgress",0];

		//--- Update plane position when module was moved / rotated
		if ((getposatl _logic distance _posATL > 0 || direction _logic != _dir) && _fireProgress == 0) then {
			_posATL = getposatl _logic;
			_pos = +_posATL;
			_pos set [2,(_pos select 2) + getterrainheightasl _pos];
			_dir = direction _logic;
			missionnamespace setvariable [_dirVar,_dir];

			_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
			_planePos set [2,(_pos select 2) + _alt];
			_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
			_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
			_plane setvectordir _vectorDir;
			//[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
			_vectorUp = vectorup _plane;

			_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
		};

		//--- Set the plane approach vector
		_plane setVelocityTransformation [
			_planePos, [_pos select 0,_pos select 1,(_pos select 2) + _offset + _fireProgress * 12],
			_velocity, _velocity,
			_vectorDir,_vectorDir,
			_vectorUp, _vectorUp,
			(time - _time) / _duration
		];
		_plane setvelocity velocity _plane;

		//--- Fire!
		if ((getposasl _plane) distance _pos < 1000 && _fireNull) then {


			//--- Create laser target
			private _targetType = if (_planeSide getfriend west > 0.6) then {"LaserTargetW"} else {"LaserTargetE"};
			_target = ((position _logic nearEntities [_targetType,250])) param [0,objnull];
			if (isnull _target) then {
				_target = createvehicle [_targetType,position _logic,[],0,"none"];
			};
			_plane reveal lasertarget _target;
			_plane dowatch lasertarget _target;
			_plane dotarget lasertarget _target;

			_fireNull = false;
			terminate _fire;
			_fire = [_plane,_weapons,_target,_weaponTypesID] spawn {
				_plane = _this select 0;
				_planeDriver = driver _plane;
				_weapons = _this select 1;
				_target = _this select 2;
				_weaponTypesID = _this select 3;
				_duration = 3;
				_time = time + _duration;
				waituntil {
					{
						//_plane selectweapon (_x select 0);
						//_planeDriver forceweaponfire _x;
						_planeDriver fireattarget [_target,(_x select 0)];
					} foreach _weapons;
					_plane setvariable ["fireProgress",(1 - ((_time - time) / _duration)) max 0 min 1];
					sleep 0.1;
					time > _time || _weaponTypesID == 3 || isnull _plane //--- Shoot only for specific period or only one bomb
				};
				sleep 1;
			};
		};

		sleep 0.01;
		scriptdone _fire || isnull _logic || isnull _plane
	};
	_plane setvelocity velocity _plane;
	_plane flyinheight _alt;

	//--- Fire CM
	if ({_x == "bomblauncher"} count _weaponTypes == 0) then {
		for "_i" from 0 to 1 do {
			driver _plane forceweaponfire ["CMFlareLauncher","Burst"];
			_time = time + 1.1;
			waituntil {time > _time || isnull _logic || isnull _plane};
		};
	};

	if !(isnull _logic) then {
		sleep 1;
		deletevehicle _logic;
		waituntil {_plane distance _pos > _dis || !alive _plane};
	};

	//--- Delete plane
	if (alive _plane) then {
		_group = group _plane;
		_crew = crew _plane;
		deletevehicle _plane;
		{deletevehicle _x} foreach _crew;
		deletegroup _group;
	};
};




params [
	["_attackPosition",objNull,[[],objNull]],
	["_planeClass","B_Plane_CAS_01_F",[""]],
	["_attackDirection",0,[123]],
	["_attackTypes",0,[123]]
];

if (_attackPosition isEqualType objNull AND {isNull _attackPosition}) exitWith {
	"Null object passed as target" call BIS_fnc_error;

	false
};

private _planeCfg = configfile >> "cfgvehicles" >> _planeClass;
if !(isclass _planeCfg) exitwith {
	["Vehicle class '%1' not found",_planeClass] call bis_fnc_error; 
	false
};

private _attackTypesString = switch _attackTypes do {
	case 0: {["machinegun"]};
	case 1: {["missilelauncher"]};
	case 2: {["machinegun","missilelauncher"]};
	case 3: {["bomblauncher"]};
	default {[]};
};

// get planes weapon lists
private _weaponsToUse = [];
private _planeClassWeapons = _planeClass call bis_fnc_weaponsEntityType;
private ["_modes_temp","_mode_temp"];
_planeClassWeapons apply {
	// get weapon type to see if it matches any in the _attackTypes array
	if (tolower ((_x call bis_fnc_itemType) select 1) in _attackTypes) then {
		// get the weapon's modes
		_modes_temp = getarray (configfile >> "cfgweapons" >> _x >> "modes");
		if (count _modes_temp > 0) then {
			_mode_temp = _modes_temp select 0;
			if (_mode_temp == "this") then {
				_mode_temp = _x
			};
			_weaponsToUse pushBack [_x,_mode_temp];
		};
	};
};
if (_weaponsToUse isEqualTo []) exitwith {
	["No weapon of types %2 wound on '%1'",_planeClass,_attackTypes] call BIS_fnc_error; 
	
	false
};


#define ATTACK_HEIGHT 1000
#define ATTACK_DISTANCE 3000

private _planeSpawnPosition = _attackPosition getPos [ATTACK_DISTANCE,_attackDirection + 180];
_planeSpawnPosition = _planeSpawnPosition vectorAdd [0,0,ATTACK_HEIGHT];
private _planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
private _planeArray = [_planeSpawnPosition_attackDirection,_planeClass,_planeSide] call bis_fnc_spawnVehicle;
private _plane = _planeArray select 0;

// telling the plane to ultimately fly past the target after we're done controlling it
_plane move (_attackPosition getPos [ATTACK_DISTANCE,_attackDirection]);
_plane disableai "move";
_plane disableai "target";
_plane disableai "autotarget";
_plane setcombatmode "blue";


// angling the plane towards the target
if (_attackPosition isEqualType objNull) then {
	_attackPosition = getPosASL _attackPosition;
};
// yaw
private _planeVectorDir = _planeSpawnPosition vectorFromTo _attackPosition;
_plane setVectorDir _planeVectorDir;
// pitch
private _planePitch = atan (ATTACK_DISTANCE / ATTACK_HEIGHT);
[_plane,-90 + _planePitch,0] call BIS_fnc_setPitchBank;

// set plane's speed to 200 km/h
#define PLANE_SPEED 55.55556 // m/s
#define PLANE_VELOCITY(THE_SPEED) [0,THE_SPEED,0]
_plane setVelocityModelSpace PLANE_VELOCITY(PLANE_SPEED);

// time on target
//private _time = time;
//private _offset = [0,20] select ("missilelaunscher" in _attackTypesString);
private _planeVectorUp = vectorUpVisual _plane;
_planeVectorDir = vectorDirVisual _plane;

// the absolute max distance between target and plane to avoid a crash
#define BREAK_OFF_DISTANCE 500
private _angleToPlane = abs (acos ((_attackPosition distance2D _plane) / (_attackPosition vectorDistance _plane)));




private _distanceToTarget = _attackPosition distance _plane;
private _flightTime = (_distanceToTarget - BREAK_OFF_DISTANCE) / PLANE_SPEED;
private _startTime = time;
private _timeAfterFlight = time + _flightTime;


private _completedFiring = false;
private "_interval";
_plane setVariable ["_fireProgress",0];
while {!_completedFiring} do {
	//--- Set the plane approach vector
	_interval = linearConversion [_startTime,_timeAfterFlight,time,0,1];
	_plane setVelocityTransformation [
		_planeSpawnPosition, _attackPosition,
		PLANE_VELOCITY(PLANE_SPEED), PLANE_VELOCITY(PLANE_SPEED),
		_planeVectorDir,_planeVectorDir,
		_planeVectorUp, _planeVectorUp,
		_interval
	];
	if ((getPosASLVisual _plane) vectorDistance _attackPosition <= 1000) then {
		// ensures strafing effect
		if !("bomblauncher" in _attackTypesString) then {
			_attackPosition = _attackPosition + 1;
		};
		//_plane setVelocityModelSpace PLANE_VELOCITY(PLANE_SPEED);

		
	};










	sleep 0.01;
};










private _attackVelocity = _planeVectorDir vectorMultiply ATTACK_SPEED;
private _attackDuration = ([0,0] distance [ATTACK_DISTANCE,ATTACK_HEIGHT]) / _speed;
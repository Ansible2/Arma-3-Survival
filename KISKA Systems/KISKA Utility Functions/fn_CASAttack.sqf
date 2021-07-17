#include "..\KISKA Headers\CAS Type IDs.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_CASAttack

Description:
	Fires off the various weapons of a CAS strike.

Parameters:
	0: _plane : <OBJECT> -
	1: _dummyTarget : <OBJECT> -
    2: _weaponsToUse : <OBJECT> -
    3: _attackTypeID : <NUMBER> -
    4: _attackPosition : <ARRAY> -
    5: _breakOffDistance : <NUMBER> -

Returns:
	NOTHING

Examples:
    (begin example)
		Should not be called on its own but in KISKA_fnc_CAS
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_CASAttack";

if !(canSuspend) exitWith {
	["Needs to be run in scheduled, exiting to scheduled...",true] call KISKA_fnc_log;
	_this spawn KISKA_fnc_CASAttack;
};


params ["_plane","_dummyTarget","_weaponsToUse","_attackTypeID","_attackPosition","_breakOffDistance"];


private ["_weaponClass_temp","_weaponArray_temp","_magClass_temp"];
private _pilot = currentPilot _plane;
_plane setVariable ["KISKA_CAS_guidedWeapon",""];


private _fn_setWeaponTemp = {
	params ["_type",["_setAsGuided",false]];
	_weaponArray_temp = _weaponsToUse select (_weaponsToUse findIf {(_x select 0) == _type});
	_weaponClass_temp = _weaponArray_temp select 1;
    if (_setAsGuided) then {
        _plane setVariable ["KISKA_CAS_guidedWeapon",_weaponClass_temp];
    };
	//_plane setVariable ["KISKA_CAS_tempWeapon",_weaponClass_temp];
    _magClass_temp = (_weaponArray_temp select 2) select 0;
	//[["Setting weapon class temp to: ", _weaponClass_temp]] call KISKA_fnc_log;
};


// CUP planes in particular have an issue with rocket fire not being accurate
_plane addEventHandler ["Fired", {
	params ["_plane", "_weapon", "", "", "", "", "_projectile", ""];

	if (_weapon == (_plane getVariable "KISKA_CAS_guidedWeapon")) then {

		[_plane,_projectile] spawn {
			params ["_plane","_projectile"];

			private _projectileStartPosASL = getPosASLVisual _projectile;
			private _dummyTarget = _plane getVariable ["KISKA_casDummyTarget",objNull];
			private _attackPosition = getPosASLVisual _dummyTarget;
			private _vectors = [_projectileStartPosASL,_attackPosition] call KISKA_fnc_getVectorToTarget;

            sleep 0.1; // allow the projectile to get some speed

            private _speed = speed _projectile;
			_projectile setVectorDirAndUp _vectors;
			_projectile setVelocityModelSpace [0,_speed,0];

			private _vectorDir = _vectors select 0;
			private _vectorUp = _vectors select 1;
			private _vectorDistanceToTarget = _attackPosition vectorDistance _projectileStartPosASL;
			private _flightTime = _vectorDistanceToTarget / _speed;
			private _startTime = time;
			private _timeAfterFlight = time + _flightTime;

			private "_interval";

			waitUntil {
				_interval = linearConversion [_startTime,_timeAfterFlight,time,0,1];
				_attackPosition = getPosASLVisual _dummyTarget;

				_projectile setVelocityTransformation [
					_projectileStartPosASL, _attackPosition,
					velocity _projectile, velocity _projectile,
					_vectorDir,_vectorDir,
					_vectorUp, _vectorUp,
					_interval
				];

                sleep 0.01;

				isNull _projectile;
			};
		};

	};
}];


private _fn_fireGun = {
	params ["_numRounds"];
	// set _weaponClass_temp to gun
	[CANNON_TYPE] call _fn_setWeaponTemp;

	private _didFireAtTarget = false;
	private _forceFire = false;
	private _weaponMode = "";

	for "_i" from 1 to _numRounds do {
		if ((_plane distance _attackPosition) < _breakOffDistance) exitWith {};

		if !(_forceFire) then {
			_didFireAtTarget = _pilot fireAtTarget [_dummyTarget,_weaponClass_temp];
			if !(_didFireAtTarget) then {
				_forceFire = true;
				_weaponMode = (getArray(configFile >> "CfgWeapons" >> _weaponClass_temp >> "modes")) select 0;
			};

		} else {
            // certain vehicles seem to not work with fireAtTarget on the cannon ("vn_b_air_f4c_cas" from CDLC SOGPF)
			_pilot forceWeaponFire [_weaponClass_temp,_weaponMode];

		};

		sleep 0.03;
	};
};


private _fn_fireRockets = {
	params ["_numRounds","_type"];
	// find rocket launcher
	[_type,true] call _fn_setWeaponTemp;

	for "_i" from 1 to _numRounds do {
		if ((_plane distance _attackPosition) < _breakOffDistance) then {break;};
		_pilot fireAtTarget [_dummyTarget,_weaponClass_temp];
		sleep 0.5;
	};
};


private _fn_fireSimple = {
	params ["_numRounds","_type",["_guideToTarget",false]];

    [_type,_guideToTarget] call _fn_setWeaponTemp;

    if (_numRounds isEqualTo -1) then {
        _numRounds = getNumber(configFile >> "CfgMagazines" >> _magClass_temp >> "count");
        if (_numRounds isEqualTo 0) then {
            _numRounds = 1;
        };
    };

    for "_i" from 1 to _numRounds do {
        _pilot fireAtTarget [_dummyTarget,_weaponClass_temp];
        sleep 0.5;
    };
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
		[1,AGM_TYPE] call _fn_fireRockets;
	};
	case BOMB_LGB_ID: {
		[1,BOMB_LGB_TYPE] call _fn_fireSimple;
	};
	case BOMB_CLUSTER_ID: {
		[-1,BOMB_UGB_TYPE] call _fn_fireSimple;
	};
    case BOMB_NAPALM_ID: {
		[-1,BOMB_UGB_TYPE,true] call _fn_fireSimple;
	};
};

_plane setVariable ["KISKA_completedFiring",true];


nil

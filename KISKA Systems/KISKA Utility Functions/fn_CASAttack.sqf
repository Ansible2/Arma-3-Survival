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

#define FIRE_GUN_INTERVAL 0.03
#define FIRE_ROCKET_INTERVAL 0.5
#define FIRE_BOMB_INTERVAL 0.5
#define GUIDE_WEAPON_INTERVAL 0.05

params [
    "_plane",
    "_dummyTarget",
    "_weaponsToUse",
    "_attackTypeID",
    "_attackPosition",
    "_breakOffDistance"
];

_plane setVariable ["KISKA_CAS_guidedFireEvent",{
    params ["_plane","_projectile"];

    private _projectileStartPosASL = getPosASLVisual _projectile;
    private _dummyTarget = _plane getVariable ["KISKA_CAS_dummyTarget",objNull];
    private _attackPosition = getPosASLVisual _dummyTarget;
    private _vectors = [_projectileStartPosASL,_attackPosition] call KISKA_fnc_getVectorToTarget;

    private _speed = speed _projectile;
    _projectile setVectorDirAndUp _vectors;
    _projectile setVelocityModelSpace [0,_speed,0];

    _vectors params ["_vectorDir","_vectorUp"];
    private _vectorDistanceToTarget = _attackPosition vectorDistance _projectileStartPosASL;
    private _flightTime = _vectorDistanceToTarget / _speed;
    private _startTime = time;
    private _timeAfterFlight = time + _flightTime;

    [
        {
            params ["_args","_id"];

            if (isNull _projectile) exitWith { 
                [_id] call CBAP_fnc_removePerFrameHandler;
            };

            _args params [
                "_projectile",
                "_projectileStartPosASL",
                "_vectorDir",
                "_vectorUp",
                "_startTime",
                "_timeAfterFlight",
                "_attackPosition"
            ];

            private _interval = linearConversion [_startTime,_timeAfterFlight,time,0,1];
            private _velocity = velocity _projectile;
            _projectile setVelocityTransformation [
                _projectileStartPosASL, _attackPosition,
                _velocity, _velocity,
                _vectorDir,_vectorDir,
                _vectorUp, _vectorUp,
                _interval
            ];
        },
        GUIDE_WEAPON_INTERVAL,
        [
            _projectile,
            _projectileStartPosASL,
            _vectorDir,
            _vectorUp,
            _startTime,
            _timeAfterFlight,
            _attackPosition
        ]
    ] call CBAP_fnc_addPerFrameHandler;
}];


// CUP planes in particular have an issue with rocket fire not being accurate
// This will guide projectiles to where they should go
_plane addEventHandler ["Fired", {
    params ["_plane", "_weapon", "", "", "", "", "_projectile"];

    private _isGuidedWeapon = _weapon == (_plane getVariable "KISKA_CAS_guidedWeapon");
    if (_isGuidedWeapon) then {
        [
            _plane getVariable ["KISKA_CAS_guidedFireEvent",{}],
            [_plane, _projectile],
            0.1  // allow the projectile to get some speed
        ] call CBAP_fnc_waitAndExecute;
    };
}];


private _fn_generateQueuedFireItems = {
    params [
        ["_numberOfRounds",-1,[123]],
        ["_weaponType","",[""]],
        ["_fireInterval",0.5,[123]],
        ["_isGuided",false,[false]]
    ];

    private _indexOfWeaponInfoForType = _weaponsToUse findIf {(_x select 0) == _weaponType};
    private _weaponArray = _weaponsToUse select _indexOfWeaponInfoForType;
    _weaponArray params ["","_weaponClass","_pylonInfo"];
    private _weaponMagClass = _pylonInfo select 0;

    if (_numberOfRounds < 1) then {
        private _configedNumberOfRoundsInMag = getNumber(configFile >> "CfgMagazines" >> _weaponMagClass >> "count");
        if (_configedNumberOfRoundsInMag isEqualTo 0) then {
            _numberOfRounds = 1;
        } else {
            _numberOfRounds = _configedNumberOfRoundsInMag;
        };
    };

    private _fireModes = getArray(configFile >> "CfgWeapons" >> _weaponClass >> "modes");
    private _primaryFireMode = _fireModes param [0,""];

    private _fireWeaponArgs = [
        _fireInterval, 
        [_weaponClass, _primaryFireMode, _isGuided]
    ];
    private _queuedFireItems = [];
    for "_i" from 1 to _numberOfRounds do { _queuedFireItems pushBack _fireWeaponArgs };


    _queuedFireItems
};


private "_fireQueue";
// decide how to fire
switch (_attackTypeID) do {
    case GUN_RUN_ID: {
        _fireQueue = [200, CANNON_TYPE, FIRE_GUN_INTERVAL] call _fn_generateQueuedFireItems;
    };
    case GUNS_AND_ROCKETS_ARMOR_PIERCING_ID: {
        _fireQueue = [100, CANNON_TYPE, FIRE_GUN_INTERVAL] call _fn_generateQueuedFireItems;
        _fireQueue append ([6, ROCKETS_AP_TYPE, FIRE_ROCKET_INTERVAL, true] call _fn_generateQueuedFireItems);
    };
    case GUNS_AND_ROCKETS_HE_ID: {
        _fireQueue = [100, CANNON_TYPE, FIRE_GUN_INTERVAL] call _fn_generateQueuedFireItems;
        _fireQueue append ([6, ROCKETS_HE_TYPE, FIRE_ROCKET_INTERVAL, true] call _fn_generateQueuedFireItems);
    };
    case ROCKETS_ARMOR_PIERCING_ID: {
        _fireQueue = [8, ROCKETS_AP_TYPE, FIRE_ROCKET_INTERVAL, true] call _fn_generateQueuedFireItems;
    };
    case ROCKETS_HE_ID: {
        _fireQueue = [8, ROCKETS_HE_TYPE, FIRE_ROCKET_INTERVAL, true] call _fn_generateQueuedFireItems;
    };
    case AGM_ID: {
        _fireQueue = [1, AGM_TYPE, 0, true] call _fn_generateQueuedFireItems;
    };
    case BOMB_LGB_ID: {
        _fireQueue = [1, BOMB_LGB_TYPE, 0] call _fn_generateQueuedFireItems;
    };
    case BOMB_NAPALM_ID;
    case BOMB_CLUSTER_ID: {
        _fireQueue = [-1, BOMB_UGB_TYPE, FIRE_BOMB_INTERVAL] call _fn_generateQueuedFireItems;
    };
};

private _fireIntervalTotal = 0;
private _maxFireQueueIndex = (count _fireQueue) - 1;
private _planeInfo = [
    _plane,
    _attackPosition,
    _breakOffDistance,
    _dummyTarget,
    currentPilot _plane
];

_plane setVariable ["KISKA_CAS_completedFiring",false];


{
    _x params ["_fireInterval","_fireInfo"];

    private _isFinal = _forEachIndex isEqualTo _maxFireQueueIndex;
    [
        {
            // split in two so that constant info (_planeInfo) can remain the same array 
            // and only the dynamic info (_fireInfo) will be new arrays for each fire
            params [
                ["_planeInfo",[],[[]],5],
                ["_fireInfo",[],[[]],3],
                ["_isFinal",false,[false]]
            ];
            
            _planeInfo params [
                ["_plane",objNull,[objNull]],
                ["_attackPosition",[],[[]],3],
                ["_breakOffDistance",1,[123]],
                ["_dummyTarget",objNull,[objNull]],
                ["_pilot",objNull,[objNull]]
            ];
            
            if (_plane getVariable ["KISKA_CAS_completedFiring",true]) exitWith {};


            _fireInfo params [
                ["_weaponClass","",[""]],
                ["_primaryFireMode","",[""]],
                ["_isGuided",false,[false]]
            ];

            if (_isGuided) then {
                _plane setVariable ["KISKA_CAS_guidedWeapon",_weaponClass];
            };

            // certain vehicles seem to not work with fireAtTarget on the cannon ("vn_b_air_f4c_cas" from CDLC SOGPF)
            private _canFireAtTarget = _pilot fireAtTarget [_dummyTarget,_weaponClass];
            if (!_canFireAtTarget) then {
                _pilot forceWeaponFire [_weaponClass,_primaryFireMode];
            };

            if (_isFinal OR ((_plane distance _attackPosition) < _breakOffDistance)) exitWith {
                _plane setVariable ["KISKA_CAS_completedFiring",true];
            };
        },
        [_planeInfo, _fireInfo, _isFinal],
        _fireIntervalTotal
    ] call CBAP_fnc_waitAndExecute;

    _fireIntervalTotal = _fireIntervalTotal + _fireInterval;
} forEach _fireQueue;


nil

/* ----------------------------------------------------------------------------
Function: KISKA_fnc_helicopterGunner

Description:
    Spawns a helicopter (or uses an existing one) to partol a given area for a period of time and
     engage enemy targets in a given area.

Parameters:
    0: _centerPosition : <Position[], OBJECT> - The position around which the helicopter will patrol
    1: _radius : <NUMBER> - The size of the radius to patrol around
    2: _aircraftType : <STRING or OBJECT> - The class of the helicopter to spawn
        If object, it is expected that this is a helicopter with crew
    3: _timeOnStation : <NUMBER> - How long will the aircraft be supporting
    4: _supportSpeedLimit : <NUMBER> - The max speed the aircraft can fly while in the support radius
    5: _flyinHeight : <NUMBER> - The altittude the aircraft flys at
    6: _approachBearing : <NUMBER> - The bearing from which the aircraft will approach from (if below 0, it will be random)
        This has no effect if an object is used for _aircraftType
    7: _side : <SIDE> - The side of the created helicopter
    8: _postSupportCode : <CODE, ARRAY, or STRING> - Code to execute after the support completes.
            See KISKA_fnc_callBack.
            The default behaviour is for the aircraft to move 2000 meters away and for
             its complete crew and self to be deleted. The _postSupportCode should return a `BOOL`
             that if `false` will NOT perform the default behaviour in addition to the callback.
        
            Parameters:
            - 0: <OBJECT> - The helicopter confucting support
            - 1: <GROUP> - The group the pilot belongs to
            - 2: <OBJECT[]> - The full vehicle crew
            - 3: <OBJECT> - The unit that *should* be the pilot of the helicopter
            - 4: <ARRAY> - The position the helicopter was supporting

Returns:
    ARRAY - The vehicle info
        0: <OBJECT> - The vehicle created
        1: <OBJECT[]> - The vehicle crew
        2: <GROUP> - The group the crew is a part of

Examples:
    (begin example)
        [
            player,
            250,
            "B_Heli_Attack_01_dynamicLoadout_F"
        ] call KISKA_fnc_helicopterGunner;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_helicopterGunner";

#define SPAWN_DISTANCE 2000
#define DETECT_ENEMY_RADIUS 700
#define MIN_RADIUS 200
#define STAR_BEARINGS [0,144,288,72,216]

params [
    ["_centerPosition",[],[objNull,[]],[2,3]],
    ["_radius",200,[123]],
    ["_aircraftType","",["",objNull]],
    ["_timeOnStation",180,[123]],
    ["_supportSpeedLimit",10,[123]],
    ["_flyInHeight",30,[123]],
    ["_approachBearing",-1,[123]],
    ["_side",BLUFOR,[sideUnknown]],
    ["_postSupportCode",{},["",{},[]]]
];


/* ----------------------------------------------------------------------------
    verify vehicle has turrets that are not fire from vehicle and not copilot positions
---------------------------------------------------------------------------- */
private _vehicleArray = [];
private _vehicleExistedBeforeFunction = _aircraftType isEqualType objNull;
if (_vehicleExistedBeforeFunction) then {
    private _aircraft = _aircraftType;
    _aircraftType = typeOf _aircraft;

    _vehicleArray pushBack _aircraft;
    _vehicleArray pushBack (crew _aircraft);
    _vehicleArray pushBack (group (currentPilot _aircraft));
};
private _turretsWithWeapons = [_aircraftType] call KISKA_fnc_classTurretsWithGuns;

if (_turretsWithWeapons isEqualTo []) exitWith {
    [[_aircraftType," does not meet standards for function!"],true] call KISKA_fnc_log;
    []
};


/* ----------------------------------------------------------------------------
    Create vehicle
---------------------------------------------------------------------------- */
if (!_vehicleExistedBeforeFunction) then {
    if (_approachBearing < 0) then {
        _approachBearing = round (random 360);
    };

    private _spawnPosition = [
        _centerPosition,
        SPAWN_DISTANCE,
        (_approachBearing + 180),
        _flyInHeight
    ] call KISKA_fnc_getPosRelativeSurface;

    _vehicleArray = [
        _spawnPosition,
        0,
        _aircraftType,
        _side, 
        false
    ] call KISKA_fnc_spawnVehicle;
};

_vehicleArray params ["_heli","_heliCrew","_pilotsGroup"];
private _pilot = currentPilot _heli;

[_pilotsGroup,true] call KISKA_fnc_ACEX_setHCTransfer;

// if using an already exisiting aircraft, the enigne must be on prior to getting a "move" command
if !(isEngineOn _heli) then {
    _heli engineOn true;
};
_heli flyInHeight _flyInHeight;


_heli setVariable ["KISKA_helicopterGunner_vehicleInfo",[_heli,_pilotsGroup,_heliCrew,_pilot]];
_pilot setVariable ["KISKA_helicopterGunner_vehicleInfo",[_heli,_pilotsGroup,_heliCrew,_pilot]];

/* ----------------------------------------------------------------------------
    Eventhandlers
---------------------------------------------------------------------------- */
/* ---------------------------------------
    Heli Killed Event
--------------------------------------- */
private _heliKilledEventId = _heli addEventHandler ["KILLED", {
    params ["_heli"];

    private _args = _heli getVariable ["KISKA_helicopterGunner_vehicleInfo",[]];
    [
        _heli, 
        "KISKA_helicopterGunner_event_heliKilled", 
        _args, 
        false
    ] call BIS_fnc_callScriptedEventHandler;

    [_heli,"KISKA_helicopterGunner_event_heliKilled"] call BIS_fnc_removeAllScriptedEventHandlers;

    _heli setVariable ["KISKA_helicopterGunner_stop",true];
}];
_heli setVariable ["KISKA_helicopterGunner_heliKilledEventId",_heliKilledEventId];


/* ---------------------------------------
    Pilot Killed Event
--------------------------------------- */
private _pilotKilledEventId = _pilot addEventHandler ["KILLED", {
    params ["_pilot"];

    private _args = _pilot getVariable ["KISKA_helicopterGunner_vehicleInfo",[]];
    [
        _pilot, 
        "KISKA_helicopterGunner_event_pilotKilled", 
        _args, 
        false
    ] call BIS_fnc_callScriptedEventHandler;

    [_pilot,"KISKA_helicopterGunner_event_pilotKilled"] call BIS_fnc_removeAllScriptedEventHandlers;

    private _heli = _args param [0,objNull];
    _heli setVariable ["KISKA_helicopterGunner_stop",true];
}];
_pilot setVariable ["KISKA_helicopterGunner_pilotKilledEventId",_pilotKilledEventId];


/* ---------------------------------------
    Pilot Getout Event
--------------------------------------- */
private _pilotGetOutEventId = _pilot addEventHandler ["GetOutMan", {
    params ["_pilot"];

    private _args = _pilot getVariable ["KISKA_helicopterGunner_vehicleInfo",[]];
    [
        _pilot, 
        "KISKA_helicopterGunner_event_pilotGotOut", 
        _args, 
        false
    ] call BIS_fnc_callScriptedEventHandler;

    [_pilot,"KISKA_helicopterGunner_event_pilotGotOut"] call BIS_fnc_removeAllScriptedEventHandlers;

    private _heli = _args param [0,objNull];
    _heli setVariable ["KISKA_helicopterGunner_stop",true];
}];
_pilot setVariable ["KISKA_helicopterGunner_pilotGotOutEventId",_pilotGetOutEventId];


/* ---------------------------------------
    Add default events
--------------------------------------- */
if (!_vehicleExistedBeforeFunction) then {
    [
        _heli,
        "KISKA_helicopterGunner_event_heliKilled",
        { 
            params ["_heli","","_heliCrew"];

            
            _heliCrew apply {
                _heli deleteVehicleCrew _x;
            };
        }
    ] call BIS_fnc_addScriptedEventHandler;

    [
        _heli,
        "KISKA_helicopterGunner_event_pilotKilled",
        { 
            params ["_heli"];
            _heli setDamage 1;
        }
    ] call BIS_fnc_addScriptedEventHandler;

    [
        _heli,
        "KISKA_helicopterGunner_event_pilotGotOut",
        { 
            params ["_heli"];
            _heli setDamage 1;
        }
    ] call BIS_fnc_addScriptedEventHandler;
};

/* ----------------------------------------------------------------------------
    Post Support Function
---------------------------------------------------------------------------- */
private _fn_supportEnded = {
    params [
        ["_heli",objNull,[objNull]],
        ["_pilotsGroup",grpNull,[grpNull]],
        ["_heliCrew",[],[[]]],
        ["_pilot",objNull,[objNull]],
        ["_centerPosition",[],[[]]],
        ["_postSupportCode",{},[{},"",[]]],
        ["_approachBearing",0,[123]]
    ];

    private _runDefault = true;
    private _postSupportCodeIsNotEmpty = (_postSupportCode isNotEqualTo {}) AND (_postSupportCode isNotEqualTo "") AND (_postSupportCode isNotEqualTo []);
    if (_postSupportCodeIsNotEmpty) then {
        _runDefault = [
            _this,
            _postSupportCode
        ] call KISKA_fnc_callBack;
    };


    if (
        (!_runDefault) OR 
        (_heli getVariable ["KISKA_helicopterGunner_stop",true])
    ) exitWith {
        [_heli,"KISKA_helicopterGunner_event_heliKilled"] call BIS_fnc_removeAllScriptedEventHandlers;
        [_pilot,"KISKA_helicopterGunner_event_pilotKilled"] call BIS_fnc_removeAllScriptedEventHandlers;
        [_pilot,"KISKA_helicopterGunner_event_pilotGotOut"] call BIS_fnc_removeAllScriptedEventHandlers;

        _heli removeEventHandler [
            "KILLED",
            _heli getVariable ["KISKA_helicopterGunner_heliKilledEventId",-1]
        ];
        _pilot removeEventHandler [
            "KILLED",
            _pilot getVariable ["KISKA_helicopterGunner_pilotKilledEventId",-1]
        ];
        _pilot removeEventHandler [
            "GetOutMan",
            _pilot getVariable ["KISKA_helicopterGunner_pilotGotOutEventId",-1]
        ];
    };


    // get helicopter to disengage and rtb
    _pilot disableAI "AUTOTARGET";
    _pilotsGroup setCombatMode "BLUE";

    // not using waypoints here because they are auto-deleted for an unkown reason a few seconds after being created for the unit

    // return to spawn position area
    private _deletePosition = _centerPosition getPos [SPAWN_DISTANCE,_approachBearing + 180];
    _heli doMove _deletePosition;

    waitUntil {
        private _isOnGround = ((getPosATL _heli) select 2) < 2;
        if (
            _isOnGround OR
            (_heli getVariable ["KISKA_helicopterGunner_stop",true]) OR
            {(_heli distance2D _deletePosition) <= 200}
        ) then {
            if (_isOnGround) then {
                _heli setDamage 1;
            };

            breakWith true
        };

        sleep 2;
        false
    };

    // killed event shousld have taken care of cleanup
    if !(alive _heli) exitWith {};

    [_heli,"KISKA_helicopterGunner_event_heliKilled"] call BIS_fnc_removeAllScriptedEventHandlers;
    [_pilot,"KISKA_helicopterGunner_event_pilotKilled"] call BIS_fnc_removeAllScriptedEventHandlers;
    [_pilot,"KISKA_helicopterGunner_event_pilotGotOut"] call BIS_fnc_removeAllScriptedEventHandlers;

    _heliCrew apply {
        _heli deleteVehicleCrew _x;
    };
    deleteVehicle _heli;
};


/* ----------------------------------------------------------------------------
    Move to support zone
---------------------------------------------------------------------------- */
// move command only supports position arrays
if (_centerPosition isEqualType objNull) then {
    _centerPosition = getPosATL _centerPosition;
};

_heli setVariable ["KISKA_helicopterGunner_stop",false];


private _params = [
    _centerPosition,
    _radius,
    _timeOnStation,
    _supportSpeedLimit,
    _approachBearing,
    _side,
    _heli,
    _pilotsGroup,
    _heliCrew,
    _pilot,
    _postSupportCode,
    _fn_supportEnded
];

_params spawn {
    params [
        "_centerPosition",
        "_radius",
        "_timeOnStation",
        "_supportSpeedLimit",
        "_approachBearing",
        "_side",
        "_heli",
        "_pilotsGroup",
        "_heliCrew",
        "_pilot",
        "_postSupportCode",
        "_fn_supportEnded"
    ];

    // once you go below a certain radius, it becomes rather unnecessary
    if (_radius < MIN_RADIUS) then {
        _radius = MIN_RADIUS;
    };

    // move to support zone
    // checking driver instead of cache to see if they got out of the vehicle
    private _vehicleEffective = true;
    waitUntil {
        private _isOnGround = ((getPosATL _heli) select 2) < 2;
        if (
            _isOnGround OR 
            (_heli getVariable ["KISKA_helicopterGunner_stop",true])
        ) then {
            _vehicleEffective = false;
            breakWith true
        };

        _pilotsGroup move _centerPosition;
        sleep 2;

        ((_heli distance2D _centerPosition) <= _radius)
    };

    
    if !(_vehicleEffective) exitWith {
        [
            _heli,
            _pilotsGroup,
            _heliCrew,
            _pilot,
            _centerPosition,
            _postSupportCode,
            _approachBearing
        ] call _fn_supportEnded;
    };


    /* ----------------------------------------------------------------------------
        Do support
    ---------------------------------------------------------------------------- */
    [
        _heli,
        5,
        4,
        _radius * 2,
        1,
        true
    ] spawn KISKA_fnc_engageHeliTurretsLoop;

    // to keep helicopters from just wildly flying around
    _heli limitSpeed _supportSpeedLimit;
    private _sleepTime = 20;
    private _numberOfBearings = count STAR_BEARINGS;
    private _elapsedTime = 0;
    private _bearingIndex = 0;
    while {_timeOnStation > _elapsedTime} do {
         private _isOnGround = ((getPosATL _heli) select 2) < 2;
        if (
            _isOnGround OR 
            (_heli getVariable ["KISKA_helicopterGunner_stop",true])
        ) then {
            break;
        };

        private _movePos = _centerPosition getPos [_radius,STAR_BEARINGS select _bearingIndex];
        _bearingIndex = _bearingIndex + 1;
        if (_bearingIndex >= _numberOfBearings) then {
            _bearingIndex = 0;
        };

        _heli doMove _movePos;

        private _newElapsedTime = _elapsedTime + _sleepTime;
        private _isLastRotation = _newElapsedTime > _timeOnStation;
        if (_isLastRotation) then {
            sleep (_timeOnStation - _elapsedTime);
        } else {
            sleep _sleepTime;
        };

        _elapsedTime = _newElapsedTime;
    };

    // end engage heli turrets loop
    _heli setVariable ["KISKA_heliTurrets_endLoop",true];

    /* ----------------------------------------------------------------------------
        After support is done
    ---------------------------------------------------------------------------- */
    //[TYPE_CAS_ABORT,_heliCrew select 0,_side] call KISKA_fnc_supportRadio;

    // remove speed limit
    _heli limitSpeed 99999;

    [
        _heli,
        _pilotsGroup,
        _heliCrew,
        _pilot,
        _centerPosition,
        _postSupportCode,
        _approachBearing
    ] call _fn_supportEnded;
};


_vehicleArray

/* ----------------------------------------------------------------------------
Function: KISKA_fnc_helicopterGunner

Description:
    Spawns a helicopter (or uses an existing one) to partol a given area for a period of time and
     engage enemy targets in a given area.

Parameters:
    0: _centerPosition : <PositionAGL[], OBJECT> - The position around which the helicopter will patrol
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
            its complete crew and self to be deleted.
        
            Parameters:
            - 0: <OBJECT> - The helicopter confucting support
            - 1: <GROUP> - The group the pilot belongs to
            - 2: <OBJECT[]> - The full vehicle crew
            - 3: <ARRAY> - The position the helicopter was supporting

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
    "_centerPosition",
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
if (_aircraftType isEqualType objNull) then {
    private _aircraft = _aircraftType;
    _aircraftType = typeOf _aircraft;

    _vehicleArray pushBack _aircraft;
    _vehicleArray pushBack (crew _aircraft);
    _vehicleArray pushBack (group (currentPilot _aircraft));
};
private _turretsWithWeapons = [_aircraftType] call KISKA_fnc_classTurretsWithGuns;

// go to default aircraft type if no suitable turrets are found
if (_turretsWithWeapons isEqualTo []) exitWith {
    [[_aircraftType," does not meet standards for function!"],false] call KISKA_fnc_log;
    []
};


/* ----------------------------------------------------------------------------
    Create vehicle
---------------------------------------------------------------------------- */
if (_approachBearing < 0) then {
    _approachBearing = round (random 360);
};

private _spawnPosition = [
    _centerPosition,
    SPAWN_DISTANCE,
    (_approachBearing + 180)
] call KISKA_fnc_getPosRelativeSurface;
_spawnPosition vectorAdd [0,0,_flyInHeight];

if (_vehicleArray isEqualTo []) then {
    _vehicleArray = [_spawnPosition,0,_aircraftType,_side, false] call KISKA_fnc_spawnVehicle;
};

// disable HC transfer
private _pilotsGroup = _vehicleArray select 2;
// [_pilotsGroup,true] call KISKA_fnc_ACEX_setHCTransfer;

private _vehicle = _vehicleArray select 0;
// if using an already exisiting aircraft, the enigne must be on prior to getting a "move" command
if !(isEngineOn _vehicle) then {
    _vehicle engineOn true;
};
_vehicle flyInHeight _flyInHeight;
// notify side if destroyed
_vehicle addEventHandler ["KILLED",{
    params ["_vehicle"];
    //[TYPE_HELO_DOWN,_vehicleCrew select 0,_side] call KISKA_fnc_supportRadio;

    (crew _vehicle) apply {
        if (alive _x) then {
            deleteVehicle _x
        };
    };
}];



private _vehicleCrew = _vehicleArray select 1;


/* ----------------------------------------------------------------------------
    Move to support zone
---------------------------------------------------------------------------- */
// move command only supports position arrays
if (_centerPosition isEqualType objNull) then {
    _centerPosition = getPosATL _centerPosition;
};

private _params = [
    _centerPosition,
    _radius,
    _timeOnStation,
    _supportSpeedLimit,
    _approachBearing,
    _side,
    _vehicle,
    _pilotsGroup,
    _vehicleCrew,
    _postSupportCode
];

_params spawn {
    params [
        "_centerPosition",
        "_radius",
        "_timeOnStation",
        "_supportSpeedLimit",
        "_approachBearing",
        "_side",
        "_vehicle",
        "_pilotsGroup",
        "_vehicleCrew",
        "_postSupportCode"
    ];

    // once you go below a certain radius, it becomes rather unnecessary
    if (_radius < MIN_RADIUS) then {
        _radius = MIN_RADIUS;
    };

    // move to support zone
    // checking driver instead of cache to see if they got out of the vehicle
    waitUntil {
        if (
            (!alive _vehicle) OR 
            {isNull (driver _vehicle)} OR 
            {(_vehicle distance2D _centerPosition) <= _radius}
        ) then {
            breakWith true
        };
        _pilotsGroup move _centerPosition;
        sleep 2;
        false
    };


    /* ----------------------------------------------------------------------------
        Do support
    ---------------------------------------------------------------------------- */
    [
        _vehicle,
        5,
        4,
        _radius * 2,
        1,
        true
    ] spawn KISKA_fnc_engageHeliTurretsLoop;

    // to keep helicopters from just wildly flying around
    _vehicle limitSpeed _supportSpeedLimit;

    private _sleepTime = _timeOnStation / 5;
    for "_i" from 0 to 4 do {
        if (
            (!alive _vehicle) OR 
            (isNull (driver _vehicle))
        ) then {
            break;
        };

        _vehicle doMove (_centerPosition getPos [_radius,STAR_BEARINGS select _i]);
        sleep _sleepTime;
    };

    _vehicle setVariable ["KISKA_heliTurrets_endLoop",true];

    /* ----------------------------------------------------------------------------
        After support is done
    ---------------------------------------------------------------------------- */
    //[TYPE_CAS_ABORT,_vehicleCrew select 0,_side] call KISKA_fnc_supportRadio;

    // remove speed limit
    _vehicle limitSpeed 99999;

    if (_postSupportCode isNotEqualTo {}) exitWith {
        [
            [
                _vehicle,
                _pilotsGroup,
                _vehicleCrew,
                _centerPosition
            ],
            _postSupportCode
        ] call KISKA_fnc_callBack;
    };

    // get helicopter to disengage and rtb
    (currentPilot _vehicle) disableAI "AUTOTARGET";
    _pilotsGroup setCombatMode "BLUE";

    // not using waypoints here because they are auto-deleted for an unkown reason a few seconds after being created for the unit

    // return to spawn position area
    private _deletePosition = _centerPosition getPos [SPAWN_DISTANCE,_approachBearing + 180];
    _vehicle doMove _deletePosition;

    waitUntil {
        if (
            (!alive _vehicle) OR 
            {(_vehicle distance2D _deletePosition) <= 200}
        ) then {
            breakWith true
        };

        // if vehicle is disabled and makes a landing, just blow it up
        if (
            (((getPosATL _vehicle) select 2) < 2) OR 
            (isNull (driver _vehicle))
        ) exitWith {
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

/* ----------------------------------------------------------------------------
Function: BLWK_fnc_startAircraftGunner

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
        ] call BLWK_fnc_startAircraftGunner;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_startAircraftGunner";

#define VOLUME_WHEN_IN_VEHICLE 0.25

params [
    "_vehicleClass",
    "_loiterHeight",
    "_loiterRadius",
    "_defaultVehicleType",
    "_globalUseVarString"
];

private _turretsWithWeapons = [_vehicleClass] call KISKA_fnc_classTurretsWithGuns;
// go to default aircraft type if no suitable turrets are found
if (_turretsWithWeapons isEqualTo []) then {
    [
        [
            _vehicleClass,
        " : does not meet type standards to be used, moving to default type: ",
        _defaultVehicleType
        ],
        true
    ] call KISKA_fnc_log;

    _vehicleClass = _defaultVehicleType;
    _turretsWithWeapons = [_defaultVehicleType] call KISKA_fnc_classTurretsWithGuns;
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


private _loiterDirection = "CIRCLE_L";

// handle cases where helicopter has dominant turret on right side, 
// helicopter needs to loiter in a clockwise fashion
private _mainTurretWeaponsArray = getArray(
    configFile >> "CfgVehicles" >> _vehicleClass >> 
    "Turrets" >> "MainTurret" >> "Weapons"
);
if ((count _mainTurretWeaponsArray) > 0) then {

    private _mainTurretWeapon = _mainTurretWeaponsArray select 0;
    private _mainTurretDir = _vehicle weaponDirection _mainTurretWeapon;
    private _mainTurretRelativeDir = (_vehicle vectorWorldToModel _mainTurretDir) call CBAP_fnc_vectDir;

    if (_mainTurretRelativeDir >= 0 AND (_mainTurretRelativeDir <= 180)) then {
        [
            [
                "Found that vehicle class ",
                _vehicleClass,
                " met standards to have a loiter of clockwise"
            ],
            false
        ] call KISKA_fnc_log;
        _loiterDirection = "CIRCLE";
    };
};



private _vehicleGroup = _vehicleArray select 2;
_vehicleGroup setBehaviour "SAFE";
_vehicleGroup setCombatMode "BLUE";
private _loiterWaypoint = _vehicleGroup addWaypoint [BLWK_playAreaCenter,0];
_loiterWaypoint setWaypointType "LOITER";
_loiterWaypoint setWaypointLoiterRadius _loiterRadius;
_loiterWaypoint setWaypointLoiterType _loiterDirection;
_loiterWaypoint setWaypointLoiterAltitude _loiterHeight;
_vehicle flyInHeight _loiterHeight;
_loiterWaypoint setWaypointSpeed "LIMITED";


// handle view distances so things aren't cloudy
// turn off View Distance Limiter
private _VDLWasRunning = false;
if (KISKA_VDL_run) then {
    KISKA_VDL_run = false;
    _VDLWasRunning = true;
};

private _estimatedDistance = round (sqrt ((_loiterHeight^2) + (_loiterRadius^2)));
private _overallViewDistance = round (_estimatedDistance * 2.5);
private _objectViewDistance = round (_estimatedDistance * 1.8);
if (_objectViewDistance > 2000) then {
    _objectViewDistance = 2000;
};
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
private _damageAllowedAdjustmentId = [player,false] call BLWK_fnc_allowDamage;
player moveInTurret [_vehicle,_turretsWithWeapons select 0];

// keep player from ejecting or switching seats with vanilla actions
_vehicle lock true;
// disable the ability to take control of the aircraft
_vehicle enableCoPilot false;

// set variable to limit player points while using the support
missionNamespace setVariable ["BLWK_isAircraftGunner",true];
// set this type of gunner as active so multiple people can't spam it
missionNamespace setVariable [_globalUseVarString,true,true];



/* ----------------------------------------------------------------------------
    Create hold actions
---------------------------------------------------------------------------- */
private _holdActionIds = [];
{
    private _turretPath = _x;
    private _turretAction = [
        player,
        format ["<t color='#3c77ba'>Switch To Turret %1</t>",_forEachIndex + 1],
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        // check if units current turret is the stored one, don't show if it is
        ["!(((objectParent player) turretUnit ",str _turretPath,") isEqualTo player)"] joinString "",
        "true",
        {},
        {},
        {
            params ["_target", "_caller", "", "_vehicleAndTurretPath"];
            
            moveOut _caller;
            _caller moveInTurret _vehicleAndTurretPath;
        },
        {},
        [_vehicle,_turretPath],
        0.5,
        1,
        false,
        false,
        false
    ] call BIS_fnc_holdActionAdd;

    _holdActionIds pushBack _turretAction;

    // give turrets a bit more ammo
    private _turretMagazines = _vehicle magazinesTurret _turretPath;
    _turretMagazines apply {
        _vehicle addMagazineTurret [_x,_turretPath];
    };
} forEach _turretsWithWeapons;

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
        call BLWK_fnc_endAircraftGunner;
    },
    {},
    [],
    1,
    1,
    false,
    false,
    false
] call BIS_fnc_holdActionAdd;
_holdActionIds pushBack _exitAction;


/* ----------------------------------------------------------------------------
    Prepare Exit Requirements
---------------------------------------------------------------------------- */
if !(["BLWK_manage_aircraftSound"] call KISKA_fnc_managedRun_isDefined) then {
    [
        "BLWK_manage_aircraftSound",
        {
            params ["_timeToFade","_volume",["_resetVolumeVariable",false]];

            _timeToFade fadeSound _volume;
            if (_resetVolumeVariable) then {
                localNamespace setVariable ["BLWK_soundVolume",nil];
            };
        }
    ] call KISKA_fnc_managedRun_updateCode;
};

// turrets are stupid loud
if (isNil {localNamespace getVariable "BLWK_soundVolume"}) then {
    localNamespace setVariable ["BLWK_soundVolume",soundVolume];
};

private _soundAdjustId = [
    "BLWK_manage_aircraftSound",
    [3, VOLUME_WHEN_IN_VEHICLE]
] call KISKA_fnc_managedRun_execute;


localNamespace setVariable ["BLWK_aircraftGunnerEndData",[
    _holdActionIds,
    _vehicle,
    _vehicleGroup,
    _globalUseVarString,
    _VDLWasRunning,
    _damageAllowedAdjustmentId,
    _soundAdjustId
]];

/* ----------------------------------------------------------------------------
    While in use loop
---------------------------------------------------------------------------- */
[_vehicle,_soundAdjustId] spawn {
    params ["_vehicle","_soundAdjustId"];

    // waitUntil we have started a wave to start counting them towards a lifetime
    waitUntil {
        if (!BLWK_inBetweenWaves OR (isNull _vehicle)) exitWith {true};
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
    private _notificationWave = _endWave - 1;
    waitUntil {
        if ((!_informed) AND (BLWK_currentWaveNumber >= _notificationWave)) then {
            ["Your gunner support will end the next wave!"] call KISKA_fnc_notification;
            _informed = true;
        };

        if (
            (BLWK_currentWaveNumber >= _endWave) OR 
            { isNull _vehicle } OR 
            { !(player in _vehicle) }
        ) exitWith {true};

        // sometimes, sound will be adjusted back to 1 if using something like zeus
        // soundVolume is relatively precise but not always exact when adjusted with fadeSound; 
        // using a 0.05 buffer to make sure it actually changed before readjusting
        if (soundVolume > (VOLUME_WHEN_IN_VEHICLE + 0.05)) then {
            [
                "BLWK_manage_aircraftSound",
                [1, VOLUME_WHEN_IN_VEHICLE],
                localNamespace,
                _soundAdjustId
            ] call KISKA_fnc_managedRun_execute;
        };

        sleep 10;
        false
    };


    if (isNull _vehicle) exitWith {};


    ["Your support expired"] call KISKA_fnc_notification;
    call BLWK_fnc_endAircraftGunner;
};


// 1. adjust position of already created aircraft gunners around new area
// newly spawned aircraft gunners are created around the extraction area
// 2. end aircraft gunners when extraction helicopter spawns
// 3. do not allow more extraction gunners to be created after helicopers spawn
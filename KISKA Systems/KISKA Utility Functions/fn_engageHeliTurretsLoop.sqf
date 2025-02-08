/* ----------------------------------------------------------------------------
Function: KISKA_fnc_engageHeliTurretsLoop

Description:
    Sets up a helicopter's turrets to be able to properly engage enemies without
     without the pilot going crazy.

    Starts a loop that will reveal targets within a given radius to gunners to engage.

    You can use variables in the _heli's namepsace to adjust params dynamically:
        "KISKA_heliTurrets_endLoop" - ends the function
        "KISKA_heliTurrets_sleepTime" - adjusts the _sleepTime param
        "KISKA_heliTurrets_revealAccuracy" - adjusts the _revealAccuracy param
        "KISKA_heliTurrets_detectionRadius" - adjusts the _detectionRadius param
        "KISKA_heliTurrets_running" - checks if the system is running

Parameters:
    0: _heli : <OBJECT> - The helicopter to set up
    1: _sleepTime : <NUMBER> - Time in between each "refresh" of the targets gunners are revealed
    2: _revealAccuracy : <NUMBER> - The accuracy of the reveals of targets for gunners
    3: _detectionRadius : <NUMBER> - The radius within to search for targets for the gunners
    4: _skill : <NUMBER> - The skill of the vehicle crew
    5: _makeInvulnerable : <BOOL> - Makes vehicle crew invulnerable or not
    6: _turretsWithWeapons : <ARRAY> - If you've already found which turrets to regard as "gunner" turrets, pass their turret paths
        or the function will get them.

Returns:
    NOTHING

Examples:
    (begin example)
        [
            _vehicle,
            5,
            4,
            250,
            1,
            true
        ] spawn KISKA_fnc_engageHeliTurretsLoop;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_engageHeliTurretsLoop";

#define MIN_SLEEP_TIME 0.01
#define EXIT_VAR_STR "KISKA_heliTurrets_endLoop"
#define SLEEP_TIME_VAR_STR "KISKA_heliTurrets_sleepTime"
#define REVEAL_ACC_VAR_STR "KISKA_heliTurrets_revealAccuracy"
#define IS_RUNNING_VAR_STR "KISKA_heliTurrets_running"
#define DETECT_RADIUS_VAR_STR "KISKA_heliTurrets_detectionRadius"

if (!canSuspend) exitWith {
    ["Needs to be run in scheduled! Exiting to scheduled...",true] call KISKA_fnc_log;
    _this spawn KISKA_fnc_engageHeliTurretsLoop;
};


params [
    ["_heli",objNull,[objNull]],
    ["_sleepTime",5,[123]],
    ["_revealAccuracy",4,[123]],
    ["_detectionRadius",250,[123]],
    ["_skill",1,[123]],
    ["_makeInvulnerable",false,[true]],
    ["_turretsWithWeapons",[],[[]]]
];


if (isNull _heli) exitWith {
    ["A null object was passed",true] call KISKA_fnc_log;
    nil
};


/* ----------------------------------------------------------------------------
    verify vehicle is compatible
---------------------------------------------------------------------------- */
private _aircraftType = typeOf _heli;
if (_turretsWithWeapons isEqualTo []) then {
    _turretsWithWeapons = [_aircraftType] call KISKA_fnc_classTurretsWithGuns;
};
if (_turretsWithWeapons isEqualTo []) exitWith {
    [[_aircraftType," does not have properly configured turrets!"],true] call KISKA_fnc_log;
    nil
};



/* ----------------------------------------------------------------------------
    Prepare AI
---------------------------------------------------------------------------- */
private _turretUnits = [];
private _turretSeperated = false;
private _vehicleCrew = crew _heli;
private _side = side (_vehicleCrew select 0);

_vehicleCrew apply {
    if (_makeInvulnerable) then {
       _x allowDamage false;
    };
    _x setSkill _skill;

    _x disableAI "SUPPRESSION";
    _x disableAI "RADIOPROTOCOL";

    // give turrets their own groups so that they can engage targets at will
    if ((_heli unitTurret _x) in _turretsWithWeapons) then {
    /*
        About seperating one turret...
        My testing has revealed that in order to have both turrets on a helicopter (if it has two)
         engaging targets simultaneously, one needs to be in a seperate group from the pilot, and one
         needs to be grouped with the pilot.
    */
        if !(_turretSeperated) then {
            _turretSeperated = true;
            private _group = createGroup _side;
            [_x] joinSilent _group;
            _group setCombatBehaviour "COMBAT";
            _group setCombatMode "RED";
        };
        _turretUnits pushBack _x;
    } else { // disable targeting for the other crew
        _x disableAI "AUTOCOMBAT";
        _x disableAI "TARGET";
        //_x disableAI "AUTOTARGET";
        _x disableAI "FSM";
    };
};

// keep the pilots from freaking out under fire
private _pilotsGroup = group (currentPilot _heli);
_pilotsGroup setBehaviour "CARELESS"; // Only careless group will follow speed limit
// the pilot group's combat mode MUST be a fire-at-will version as it adjusts it for the entire vehicle
_pilotsGroup setCombatMode "RED";



/* ----------------------------------------------------------------------------
    Loop
---------------------------------------------------------------------------- */
private _fn_getTargets = {
    (_heli nearEntities [["MAN","CAR","TANK"],(_heli getVariable [DETECT_RADIUS_VAR_STR, _detectionRadius])]) select {
        !(isAgent teamMember _x) AND
        {[side _x, _side] call BIS_fnc_sideIsEnemy}
    };
};


if (_sleepTime < MIN_SLEEP_TIME) then {
    _sleepTime = MIN_SLEEP_TIME;
};


_heli setVariable [EXIT_VAR_STR,false];
_heli setVariable [IS_RUNNING_VAR_STR,true];
_heli setVariable [DETECT_RADIUS_VAR_STR, _detectionRadius];
_heli setVariable [SLEEP_TIME_VAR_STR, _sleepTime];
_heli setVariable [REVEAL_ACC_VAR_STR, _revealAccuracy];


private _targetsInArea = [];
// using waituntil to avoid running more then once a frame
waitUntil {
    if (!(alive _heli) OR (_heli getVariable [EXIT_VAR_STR,false])) exitWith {true};

    _targetsInArea = call _fn_getTargets;
    if (_targetsInArea isNotEqualTo []) then {

        _targetsInArea apply {
            _currentTarget = _x;

            _turretUnits apply {
                if !(isNull _x) then {
                    _x reveal [_currentTarget,(_heli getVariable [REVEAL_ACC_VAR_STR, _revealAccuracy])];
                };
            };

        };

    };

    sleep (_heli getVariable [SLEEP_TIME_VAR_STR, _sleepTime]);

    false
};

_heli setVariable [IS_RUNNING_VAR_STR,false];
_heli setVariable [EXIT_VAR_STR,false];

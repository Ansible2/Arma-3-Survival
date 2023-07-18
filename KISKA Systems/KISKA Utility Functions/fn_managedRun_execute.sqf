/* ----------------------------------------------------------------------------
Function: KISKA_fnc_managedRun_execute

Description:
    Allows multiple systems to manage a particular functionality or subset of code
     by restricting runs to only the latest id for a given namespace

    The code must be added with KISKA_fnc_managedRun_updateCode.

    An example is having competing systems that need to adjust the damage of the player
     at different times an perhaps with delays. Perhaps one system starts by taking ownership
     of this functionality to not allow the player to be damaged, however, later this system
     will reset wether or not the player has damage allowed after some delay.
    If another system (or the same one again in the future) wants to take ownership of this
     functionality to also set the player to not allow damage BEFORE the previous system
     has reset the player's isDamageAllowed state, it could become complex to try and handle
     the reset vs continuing to allow the player to not take damage. Instead, the previous
     system's code will now be blocked from running, as another id has taken ownership.

Parameters:
    0: _nameOfCode : <STRING> - The name of the code to run previously added with
        KISKA_fnc_managedRun_updateCode
    1: _args : <ARRAY> - An array of arguments that will be `_this` within the
        code to run
    2: _idNamespace : <GROUP, OBJECT, LOCATION, NAMESPACE, CONTROL, DISPLAY, TASK, TEAM-MEMBER> - 
        The namespace to restrict the id to. This is used to manage runs on two different
         objects for example
    3: _idToRunAgainst : <NUMBER> - The id the code is restricted to run against
    4: _isScheduled : <BOOL> - Whether the code will be executed in a scheduled environment

Returns:
    <NUMBER> - The id of the run made, `-1` if code was not run or a new id to make future runs
        against for a particular system.

Examples:
    (begin example)
        // add code for given id
        [
            "KISKA_manage_allowDamage",
            {
                params ["_unit","_isDamageAllowed"];
                _unit allowDamage _isDamageAllowed;
            }
        ] call KISKA_fnc_managedRun_updateCode;

        // initial run
        private _idOfRun = [
            "KISKA_manage_allowDamage",
            [player, false],
            player
        ] call KISKA_fnc_managedRun_execute;

        // try to change in the future
        [_idOfRun] spawn {
            params ["_idOfRun"];
            sleep 3;
            // does nothing because id was overwritten in the meantime
            [
                "KISKA_manage_allowDamage",
                [player, true],
                player,
                _idOfRun
            ] call KISKA_fnc_managedRun_execute;

            hint str (isDamageAllowed player) // false
        };

        private _idOfADifferentRun = [
            "KISKA_manage_allowDamage",
            [player, false],
            player
        ] call KISKA_fnc_managedRun_execute;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_managedRun_execute";

params [
    ["_nameOfCode","",[""]],
    ["_args",[],[[]]],
    ["_idNamespace",localNamespace,[grpNull,objNull,locationNull,controlNull,displayNull,taskNull,teamMemberNull,localNamespace]],
    ["_idToRunAgainst",-1,[123]],
    ["_isScheduled",false,[true]]
];

private _codeMap = localNamespace getVariable ["KISKA_managedRun_codeMap",-1];
if (_codeMap isEqualTo -1) exitWith { 
    [
        [
            "KISKA_managedRun_codeMap is not defined, did you add ",
            _nameOfCode,
            " with KISKA_fnc_managedRun_updateCode?"
        ],
        true
    ] call KISKA_fnc_log;
    -1 
};

if !(_nameOfCode in _codeMap) exitWith { 
    [
        [
            "KISKA_managedRun_codeMap does not contain key for ",
            _nameOfCode,
            ". Did you add ",
            _nameOfCode,
            " with KISKA_fnc_managedRun_updateCode?"
        ],
        true
    ] call KISKA_fnc_log;
    -1 
};


private _isNewManagement = _idToRunAgainst isEqualTo -1;
private _currentAdjustmentId = _idNamespace getVariable ["KISKA_managedRun_latestId",-1];
private _idToAdjustIsCurrent = _currentAdjustmentId isEqualTo _idToRunAgainst;

// new id was made, don't run code
if ((!_isNewManagement) AND (!_idToAdjustIsCurrent)) exitWith { -1 };

private _idOfRun = -1;
if (_isNewManagement) then {
    // assign new adjusment id as latest
    _idOfRun = ["KISKA_managedRun_latestId",_idNamespace] call KISKA_fnc_idCounter;
} else {
    _idOfRun = _idToRunAgainst;
};

private _code = _codeMap get _nameOfCode;
[_args,_code,_isScheduled] call KISKA_fnc_callBack;


_idOfRun

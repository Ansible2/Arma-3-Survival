/* ----------------------------------------------------------------------------
Function: KISKA_fnc_removeArsenal

Description:
    Removes both BIS and ACE arsenals from several or a single object.
    This has a global effect.

Parameters:
    0: _arsenals <ARRAY or OBJECT> - An array of objects to add arsenals to

Returns:
    <BOOL> - true if done, false if not

Examples:
    (begin example)
        [[arsenal1, arsenal2]] call KISKA_fnc_removeArsenal;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_removeArsenal";

params [
    ["_arsenals",[],[[],objNull]]
];

if (_arsenals isEqualTo [] OR {(_arsenals isEqualType objNull) AND {isNull _arsenals}}) exitWith {
    [["_arsenals are invalid: ",str _arsenals],true] call KISKA_fnc_log;
    false
};

if !(_arsenals isEqualType []) then {
    _arsenals = [_arsenals];
};

private _aceLoaded = ["ace_arsenal"] call KISKA_fnc_isPatchLoaded;

_arsenals apply {
    if (_aceLoaded) then {
        [_x, true] call ace_arsenal_fnc_removeBox
    };

    /* ["AmmoboxExit",_x] call BIS_fnc_arsenal; */
    [_x] remoteExecCall ["KISKA_fnc_removeBISArsenalAction", 0, true];
};


true

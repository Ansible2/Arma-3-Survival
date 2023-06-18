/* ----------------------------------------------------------------------------
Function: KISKA_fnc_pushBackToArray

Description:
    Pushes back a value to a global array.

    This was used in lieu of creating a public variable to sync the array.
    In order to keep network traffic lower if the array becomes large.

Parameters:
    0: _arrayVariableName : <STRING> - The array in string format
    1: _entryToAdd : <ANY> - The value to pushBack
    2: _namespace : <NAMESPACE,OBJECT,GROUP,LOCATION,CONTROL, or DISPLAY> - What namespace the array is in

Returns:
    <BOOL> - true if added, false if not

Examples:
    (begin example)
        ["myGlobalArrayVar",someInfoHere,missionNamespace] call KISKA_fnc_pushBackToArray;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_pushBackToArray";

params [
    ["_arrayVariableName","",[""]],
    "_entryToAdd",
    ["_namespace",missionNamespace,[missionNamespace,objNull,grpNull,controlNull,displayNull,locationNull]]
];

if (isNil "_entryToAdd") exitWith {
    ["_entryToAdd was undefined, nothing to pushback",true] call KISKA_fnc_log;
    false
};

if (_arrayVariableName isEqualTo "") exitWith {
    ["Array variable name is empty string",true] call KISKA_fnc_log;
    false
};

private _array = _namespace getVariable [_arrayVariableName,[]];
_array pushBack _entryToAdd;

if (isNil {_namespace getVariable _arrayVariableName}) then {
    _namespace setVariable [_arrayVariableName,_array];
};


true

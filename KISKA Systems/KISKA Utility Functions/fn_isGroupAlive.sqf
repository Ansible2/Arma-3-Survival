/* ----------------------------------------------------------------------------
Function: KISKA_fnc_isGroupAlive

Description:
    Checks if any unit in the group is alive.

Parameters:
    0: _group <GROUP or OBJECT> - The group or a unit in that group to check the status for

Returns:
    <BOOL> - True if a unit in the group is alive, false otherwise

Examples:
    (begin example)
        [group player] call KISKA_fnc_isGroupAlive;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_isGroupAlive";

params [
    ["_group",grpNull,[grpNull,objNull]]
];


if (isNull _group) exitWith {false};

if (_group isEqualType objNull) then {
    _group = group _group;
};

private _units = units _group;
private _personInGroupIsAlive = (_units findIf {alive _x}) isNotEqualTo -1;


_personInGroupIsAlive

/* ----------------------------------------------------------------------------
Function: BLWK_fnc_standardWave_onGroupCreated

Description:
    Inits code specific to when a group is created for the common standard wave.

Parameters:
    0: _group : <GROUP> - The created group

Returns:
    NOTHING

Examples:
    (begin example)
        [group _unit] call BLWK_fnc_standardWave_onGroupCreated;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_standardWave_onGroupCreated";

params [
    ["_group",grpNull,[grpNull]]
];

[_group] spawn BLWK_fnc_stalking_start;


nil

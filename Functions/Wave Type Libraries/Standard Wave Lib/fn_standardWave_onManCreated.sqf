/* ----------------------------------------------------------------------------
Function: BLWK_fnc_standardWave_onManCreated

Description:
    Inits code specific to when a unit is created for the common standard wave.

Parameters:
    0: _unit : <OBJECT> - The created Man unit

Returns:
    NOTHING

Examples:
    (begin example)
        [_unit] call BLWK_fnc_standardWave_onManCreated;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_standardWave_onManCreated";

params [
    ["_unit",objNull,[objNull]]
];

// private _group = group _unit;
// [_group] spawn BLWK_fnc_pathing_mainLoop;
// [_unit] spawn BLWK_fnc_pathing_collisionLoop;
// [_group] spawn BLWK_fnc_startStalkingPlayers;


nil

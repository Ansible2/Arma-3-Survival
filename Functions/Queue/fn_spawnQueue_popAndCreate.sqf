/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_popAndCreate

Description:
    Takes the first entry in the enemy man spawn queue, removes the item and then
     spawns the unit from the arguments.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_spawnQueue_popAndCreate;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_popAndCreate";

// check if queue is empty
private _queue = localNamespace getVariable ["BLWK_spawnQueue",[]];
if (_queue isEqualTo []) exitWith {};

(_queue deleteAt 0) params ["_type","_position","_onManCreatedFunctionName"];

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

if (!isServer) exitWith {};

// check if queue is empty
private _queue = localNamespace getVariable ["BLWK_spawnQueue",[]];
if (_queue isEqualTo []) exitWith {
    // TODO: end wave
};

private _spawnArgs = _queue deleteAt 0;
_spawnArgs remoteExecCall ["BLWK_fnc_spawnQueue_create",BLWK_theAIHandlerOwnerID];



nil

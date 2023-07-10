/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_popAndCreate

Description:
    Takes the first entry in the enemy man spawn queue, removes the item and then
     spawns the unit from the arguments.

Parameters:
    NONE

Returns:
    <[STRING, PositionATL[] OR OBJECT, STRING]> - the element removed or empty `[]`
        if no items were in queue

Examples:
    (begin example)
        private _poppedElement = call BLWK_fnc_spawnQueue_popAndCreate;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_popAndCreate";

if (!isServer) exitWith {};

// check if queue is empty
private _queue = localNamespace getVariable ["BLWK_spawnQueue",[]];
if (_queue isEqualTo []) exitWith {
    []
};

private _spawnArgs = _queue deleteAt 0;
_spawnArgs remoteExecCall ["BLWK_fnc_spawnQueue_create",BLWK_theAIHandlerOwnerID];


_spawnArgs

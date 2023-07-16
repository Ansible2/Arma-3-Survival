/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_popAndCreate

Description:
    Takes the first entry in creation args spawn queue, removes the item and then
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

private _stagedSpawns = localNamespace getVariable ["BLWK_spawnQueue_stagedSpawns",-1];
private _stagedIsUninitialized = _stagedSpawns isEqualTo -1;
if (_stagedIsUninitialized) then {
    _stagedSpawns = [];
    localNamespace setVariable ["BLWK_spawnQueue_stagedSpawns",_stagedSpawns];
};


private _queue = localNamespace getVariable ["BLWK_spawnQueue",[]];
if (_queue isEqualTo []) exitWith {
    if (_stagedSpawns isNotEqualTo []) then {
        localNamespace setVariable ["BLWK_spawnQueue_stagedSpawns",[]];
        [_stagedSpawns] remoteExecCall ["BLWK_fnc_spawnQueue_create",BLWK_theAIHandlerOwnerID];
    };

    _queue
};


private _maxGroupSize = localNamespace getVariable ["BLWK_spawnQueue_maxGroupSize",1];
private _insertedIndex = _stagedSpawns pushBack (_queue deleteAt 0);
if ((_insertedIndex + 1) isEqualTo _maxGroupSize) then {
    localNamespace setVariable ["BLWK_spawnQueue_stagedSpawns",[]];
    [_stagedSpawns] remoteExecCall ["BLWK_fnc_spawnQueue_create",BLWK_theAIHandlerOwnerID];
};


_queue

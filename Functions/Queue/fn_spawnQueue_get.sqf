/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_get

Description:
    Returns the currently queued list of entries to spawn.

Parameters:
    NONE

Returns:
    <ARRAY> - the queue of spawn arguments

Examples:
    (begin example)
        private _queue = call BLWK_fnc_spawnQueue_get;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_get";

private _queue = localNamespace getVariable ["BLWK_spawnQueue",-1];
if (_queue isEqualTo -1) then {
	_queue = [];
    localNamespace setVariable ["BLWK_spawnQueue",_queue];
};


_queue

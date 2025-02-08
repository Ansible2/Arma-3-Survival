/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_getAvailableGroup

Description:
    Returns an empty group from the precreated groups for the spawn queue.

Parameters:
	NONE

Returns:
    <GROUP> - an empty group to use

Examples:
    (begin example)
        private _group = call BLWK_fnc_spawnQueue_getAvailableGroup;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_getAvailableGroup";

private _groupsToChooseFrom = localNamespace getVariable "BLWK_spawnQueue_groups";
private _groupIndex = _groupsToChooseFrom findIf { (count (units _x)) isEqualTo 0 };

if (_groupIndex < 0) then {
	["BLWK_fnc_spawnQueue_getAvailableGroup could not find any _groupIndex that had not units!",false] remoteExecCall ["KISKA_fnc_log",2];
};


_groupsToChooseFrom param [_groupIndex,(_groupsToChooseFrom select 0)]

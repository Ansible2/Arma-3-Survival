/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pathing_checkGroupStatus

Description:
	Checks if a group is still alive.

Parameters:
	0: _groupToCheck : <GROUP> - The group to check over

Returns:
	<BOOL> - true if active, false if not

Examples:
    (begin example)

		_isActive = [_group] call BLWK_fnc_pathing_checkGroupStatus;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_pathing_checkGroupStatus";

params ["_groupToCheck"];

// check if it was deleted
if (isNull _groupToCheck) exitWith {
	[["Found that ",_groupToCheck," is a null group"],false] call KISKA_fnc_log;
	false
};

// check if anyone is in it
private _groupUnits = units _groupToCheck;
if (_groupUnits isEqualTo []) exitWith {
	[["Found that ",_groupToCheck," is an empty group"],false] call KISKA_fnc_log;
	false
};

// check if anyone is alive
private _aliveIndex = _groupUnits findIf {alive _x};
if (_aliveIndex != -1) exitWith {
	true
}; 


false
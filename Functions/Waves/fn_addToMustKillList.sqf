/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addToMustKillList

Description:
	Adds a number of units to the server's global array that keeps track of what units need
	 to be killed before the round can be done.

Parameters:
	0: _unitsToAdd : <OBJECT[]> - The units to add

Returns:
	NOTHING

Examples:
    (begin example)
		[[myUnit,aSecondUnit]] call BLWK_fnc_addToMustKillList;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params [
	["_unitsToAdd",[],[[]]]
];


private _currentList = call BLWK_fnc_getMustKillList;
_unitsToAdd apply {
	if (isNull _x) exitWith {
		["A null unit was passed..."] call KISKA_fnc_log;
		continue
	};

	_currentList pushBackUnique _x;
};

localNamespace setVariable ["BLWK_mustKillList",_currentList];

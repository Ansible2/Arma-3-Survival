/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addToMustKillList

Description:
	Adds a unit to the server's global array that keeps track of what units need
	 to be killed before the round can be done.

Parameters:
	0: _unitToAdd : <OBJECT> - The unit to add

Returns:
	NOTHING

Examples:
    (begin example)
		[myUnit] call BLWK_fnc_addToMustKillList;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params [
	["_unitToAdd",objNull,[objNull]]
];

if (isNull _unitToAdd) exitWith {
	["A null unit was passed..."] call KISKA_fnc_log;
	nil
};

private _currentArray = call BLWK_fnc_getMustKillList;
_currentArray pushBackUnique _unitToAdd;
localNamespace setVariable ["BLWK_mustKillList",_currentArray];

/* ----------------------------------------------------------------------------
Function: KISKA_fnc_findIfBool

Description:
	Checks if an array index satisfies the provided code, and returns a BOOL
	 for whether or not one was found.

Parameters:
	0: _array : <ARRAY> - The array to check
	1: _codeToCheck : <CODE> - The code to check against the array indexes.
		Needs to return a BOOl
	2: _thisArgs : <ARRAY> - Any local arguements that can be passed

Returns:
	<BOOL> - True if an index meets the condition, false if not

Examples:
    (begin example)
		// returns true if any player is alive
		[allPlayers,{alive _x}] call KISKA_fnc_findIfBool;
    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "KISKA_fnc_findIfBool"
scriptName SCRIPT_NAME;

params [
	["_array",[],[[]]],
	["_codeToCheck",{},[{}]],
	["_thisArgs",[],[[]]]
];

private _index = _array findIf _codeToCheck;

if (_index != -1) then {
	true
} else {
	false
};
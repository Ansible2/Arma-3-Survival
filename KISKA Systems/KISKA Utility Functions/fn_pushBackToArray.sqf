/* ----------------------------------------------------------------------------
Function: KISKA_fnc_pushBackToArray

Description:
	Pushes back a value to a global array.

	This was used in lieu of creating a public variable to sync the array.
	In order to keep network traffic lower if the array becomes large.

Parameters:
	0: _arrayVariableName : <STRING> - The array in string format
	1: _entryToAdd : <ANY> - The value to pushBack
	2: _namespace : <NAMESPACE,OBJECT,GROUP,LOCATION,CONTROL,DISPLAY> - What namespace the array is in

Returns:
	BOOL

Examples:
    (begin example)

		["myGlobalArrayVar",someInfoHere,missionNamespace] call KISKA_fnc_pushBackToArray;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_arrayVariableName","",[""]],
	"_entryToAdd",
	["_namespace",missionNamespace,[missionNamespace,objNull,grpNull,controlNull,displayNull,locationNull]]
];

if (_arrayVariableName isEqualTo "") exitWith {
	"KISKA_fnc_pushBackToArray: Array variable name is empty string" call BIS_fnc_error;
};

private _array = _namespace getVariable [_arrayVariableName,[]];

_array pushBack _entryToAdd;

if (isNil {_namespace getVariable _arrayVariableName}) then {
	_namespace setVariable [_arrayVariableName,_array];
};


true
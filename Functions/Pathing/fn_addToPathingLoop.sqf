/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addToPathingLoop

Description:
	Add units to 

Parameters:
	0: _unitToAdd : <OBJECT OR GROUP> - The unit or group to add to the array

Returns:
	BOOL

Examples:
    (begin example)

		_wasAdded = [myUnit] call BLWK_fnc_addToPathingLoop;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#include "..\..\Headers\Pathing Global Strings.hpp"

params [
	["_unitToAdd",objNull,[grpNull,objNull]]
];

if (isNull _unitToAdd) exitWith {
	"null _unitToAdd" call BIS_fnc_error;
	false
};

if (_unitToAdd isEqualType objNull AND {!alive _unitToAdd}) exitWith {
	["_unitToAdd %1 is dead!",_unitToAdd] call BIS_fnc_error;
	false
};

private _array = missionNamespace getVariable [LOOP_ARRAY_VAR,[]];
_array pushBackUnique _unitToAdd;
missionNamespace setVariable [LOOP_ARRAY_VAR,_array];


true
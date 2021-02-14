#include "..\..\Headers\Stalker Global Strings.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_canUnitBeStalked

Description:
	Checks whether or not a unit is able to be stalked by the AI.

Parameters:
	0: _unitToAdd : <OBJECT OR GROUP> - The unit or group to add to the array

Returns:
	BOOL

Examples:
    (begin example)
		_isStalkable = [aUnit] call BLWK_fnc_canUnitBeStalked;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_unit",objNull,[objNull]]
];

if ((alive _unit) AND {incapacitatedState _unit isEqualTo ""} AND {_unit getVariable [IS_UNIT_AVAILABLE_VAR,true]}) then {
	true
} else {
	false
};
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_getPathingArray

Description:
	Gets the pathing loop array of units that will be checked for positions.

Parameters:
	NONE

Returns:
	ARRAY - the units/groups in the array

Examples:
    (begin example)

		_unitArray = call BLWK_fnc_getPathingArray;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#include "..\..\Headers\Pathing Global Strings.hpp"

private _array = missionNamespace getVariable [LOOP_ARRAY_VAR,[]];

_array
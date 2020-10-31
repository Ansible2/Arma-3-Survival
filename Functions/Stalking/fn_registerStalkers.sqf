/* ----------------------------------------------------------------------------
Function: BLWK_fnc_registerStalkers

Description:
	Adds the number of a stalker group's units to the unit being stalked
	 total's so that they can be evenly spread across all units.

Parameters:
	0: _unit : <OBJECT> - The unit being stalked
	1: _stalkerGroup : <GROUP> - The group that will now be stalking the unit

Returns:
	NOTHING

Examples:
    (begin example)

		[aUnit,aStalkerGroup] call BLWK_fnc_registerStalkers;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#include "..\..\Headers\Stalker Global Strings.hpp"

params [
	["_unit",objNull,[objNull]],
	["_stalkerGroup",grpNull,[grpNull]]
];

private _currentStalkerCount = _unit getVariable [STALKER_COUNT_VAR,0];
_unit setVariable [STALKER_COUNT_VAR,_currentStalkerCount + (count (units _stalkerGroup))];
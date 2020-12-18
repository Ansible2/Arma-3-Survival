/* ----------------------------------------------------------------------------
Function: BLWK_fnc_registerStalkers

Description:
	Registers the count of _stalkerGroup's units to the total units stalking
	 _unit currently so that we can track how many at any given time are stalking
	 a specific unit.

Parameters:
	0: _unit : <OBJECT> - The unit being stalked
	1: _stalkerGroup : <GROUP> - The group that will now be stalking the unit

Returns:
	NOTHING

Examples:
    (begin example)

		[aUnit,aStalkerGroup] call BLWK_fnc_registerStalkers;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#include "..\..\Headers\Stalker Global Strings.hpp"

params [
	["_unit",objNull,[objNull]],
	["_stalkerGroup",grpNull,[grpNull]]
];

if (isNull _unit) exitWith {};

private _currentStalkerCount = _unit getVariable [STALKER_COUNT_VAR,0];
_unit setVariable [STALKER_COUNT_VAR,_currentStalkerCount + (count (units _stalkerGroup))];
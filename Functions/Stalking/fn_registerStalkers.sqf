#include "..\..\Headers\Stalker Global Strings.hpp"

params [
	["_unit",objNull,[objNull]],
	["_stalkerGroup",grpNull,[grpNull]]
];

private _currentStalkerCount = _unit getVariable [STALKER_COUNT_VAR,0];
_unit setVariable [STALKER_COUNT_VAR,_currentStalkerCount + (count (units _stalkerGroup))];
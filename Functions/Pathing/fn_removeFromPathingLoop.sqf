#include "..\..\Headers\Pathing Global Strings.hpp"

params [
	["_unitToRemove",objNull,[grpNull,objNull]]
];

if (isNull _unitToRemove) exitWith {
	"null _unitToRemove" call BIS_fnc_error;
	false
};

private _array = missionNamespace getVariable [LOOP_ARRAY_VAR,[]];
private _index = _array findIf {_x isEqualTo _unitToRemove};

// if found in array
if (_index != -1) then {
	_array deleteAt _index;
	missionNamespace setVariable [LOOP_ARRAY_VAR,_array];
	
	true
} else {
	["_unitToRemove %1 is not located inside "#LOOP_ARRAY_VAR,_unitToRemove] call BIS_fnc_error;

	false
};
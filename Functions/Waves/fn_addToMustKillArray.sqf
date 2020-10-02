if (!isServer) exitWith {false};

#include "..\..\Headers\String Constants.hpp"

params [
	["_unitToAdd",objNull,[objNull]]
];

if (isNull _unitToAdd) exitWith {false};

private _currentArray = missionNamespace getVariable [WAVE_ENEMIES_ARRAY,[]];

_currentArray pushBackUnique _unitToAdd;

missionNamespace setVariable [WAVE_ENEMIES_ARRAY,_currentArray,2];


true
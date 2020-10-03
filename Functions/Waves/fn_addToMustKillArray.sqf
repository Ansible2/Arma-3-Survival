/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addToMustKillArray

Description:
	Adds a unit to the server's global array that keeps track of what units need
	 to be killed before the round can be done.


Parameters:
	0: _unitToAdd : <OBJECT> - The unit to add

Returns:
	BOOL

Examples:
    (begin example)

		[myUnit] call BLWK_fnc_addToMustKillArray;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
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
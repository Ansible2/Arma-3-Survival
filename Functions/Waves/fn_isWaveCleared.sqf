/* ----------------------------------------------------------------------------
Function: BLWK_fnc_isWaveCleared

Description:
	Checks all the units in the global must kill array to see if any are still alive.

	Executed from "BLWK_fnc_startWave"

Parameters:
	NONE

Returns:
	BOOL

Examples:
    (begin example)

		_areEnemiesDead = call BLWK_fnc_isWaveCleared;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

#include "..\..\Headers\String Constants.hpp"

private _index = (missionNamespace getVariable [WAVE_ENEMIES_ARRAY,[]]) findIf {alive _x};
if !(_index isEqualTo -1) then {
	false
} else {
	true
};
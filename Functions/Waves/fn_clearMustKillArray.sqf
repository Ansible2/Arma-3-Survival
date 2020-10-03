/* ----------------------------------------------------------------------------
Function: BLWK_fnc_clearMustKillArray

Description:
	SImply clears the global variable array for the next round.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_clearMustKillArray;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#include "..\..\Headers\String Constants.hpp"

missionNamespace setVariable [WAVE_ENEMIES_ARRAY,[],2];
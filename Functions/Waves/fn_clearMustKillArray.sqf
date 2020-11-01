/* ----------------------------------------------------------------------------
Function: BLWK_fnc_clearMustKillArray

Description:
	Simply clears the global variable array for the next round.

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
#ifndef WAVE_ENEMIES_ARRAY
	#include "..\..\Headers\String Constants.hpp"
#endif

missionNamespace setVariable [WAVE_ENEMIES_ARRAY,[],2];
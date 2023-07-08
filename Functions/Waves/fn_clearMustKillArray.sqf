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

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
// need to check if anyone is still alive before clearing
waitUntil {
	if (call BLWK_fnc_isWaveCleared) exitWith {true};
	sleep 0.5;
	false
};

missionNamespace setVariable ["BLWK_mustKillList",[]];
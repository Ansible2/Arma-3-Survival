/* ----------------------------------------------------------------------------
Function: BLWK_fnc_clearMustKillList

Description:
	Simply clears the global variable array for the next round.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_clearMustKillList;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_clearMustKillList";

localNamespace setVariable ["BLWK_mustKillList",[]];

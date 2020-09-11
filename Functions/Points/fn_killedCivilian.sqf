/* ----------------------------------------------------------------------------
Function: BLWK_fnc_killedCivilian

Description:
	Docks points from player when they kill a civilian

	Executed from ""

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_killedCivilian;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_player",player,[objNull]]
];

[BLWK_pointsForKill * 10] call BLWK_fnc_spendPoints;

playSound "alarm";

null = [_unit, round (BLWK_pointsForKill * -10), [1, 0.1, 0.1]] spawn killPoints_fnc_hitMarker;
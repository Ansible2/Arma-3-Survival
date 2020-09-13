/* ----------------------------------------------------------------------------
Function: BLWK_fnc_killedCivilian

Description:
	Docks points from player when they kill a civilian

	Executed from ""

Parameters:
	0: _killedCivilian : <OBJECT> - The person killed

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_killedCivilian;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_killedCivilian"];

[BLWK_pointsForKill * 10] call BLWK_fnc_subtractPoints;

playSound "alarm";

[_killedCivilian, round (BLWK_pointsForKill * -10), true] call BLWK_fnc_createHitMarker;
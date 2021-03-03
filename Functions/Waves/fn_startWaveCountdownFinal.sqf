/* ----------------------------------------------------------------------------
Function: BLWK_fnc_startWaveCountdownFinal

Description:
	Prints out the final 15 seconds before a wave starts with sounds
	 on a player's screen.

	Executed from "BLWK_fnc_endWave"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_startWaveCountdownFinal;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

private _countDown = 15;
while {_countDown >= 0} do {

	if (_countDown <= 10) then {
		playSound "beep_target";
	};

	[str _countDown, 0, 0, 1, 0] spawn BIS_fnc_dynamicText;
	
	sleep 1;
	_countDown = _countDown - 1;
};
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_startWaveCountdownFinal

Description:
	Prints out the final seconds before a wave starts with sounds
	 on a player's screen.

	Executed from "BLWK_fnc_endWave"

Parameters:
	0: _countDown : <NUMBER> - The amount to countdown from

Returns:
	NOTHING

Examples:
    (begin example)
		[5] spawn BLWK_fnc_startWaveCountdownFinal;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

if (!canSuspend) exitWith {
	_this spawn BLWK_fnc_startWaveCountdownFinal;
};

params [
	["_countDown",15,[123]]
];

while {_countDown >= 0} do {

	if (_countDown <= 10) then {
		playSound "beep_target";
	};

	[str _countDown, 0, 0, 1, 0] spawn BIS_fnc_dynamicText;

	uiSleep 1;
	_countDown = _countDown - 1;
};

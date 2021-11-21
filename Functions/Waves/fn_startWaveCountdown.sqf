/* ----------------------------------------------------------------------------
Function: BLWK_fnc_startWaveCountdown

Description:
    Starts the count down to the next wave on the server.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_startWaveCountdown;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_startWaveCountdown";

if (!isServer OR !canSuspend) exitWith {};

if (BLWK_timeBetweenRounds > 0) then {
	private _params = [BLWK_timeBetweenRounds,15,10];
	_params remoteExec ["KISKA_fnc_countdown",-2];
	_params call KISKA_fnc_countdown;
};

/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleTwelveHourWave

Description:
	Creates the twelve hour wave.

	Executed from "BLWK_fnc_decideWaveType"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		null = [] spawn BLWK_fnc_handleTwelveHourWave;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

private _dateBeforeChange = date;
private _currentWave = BLWK_currentWaveNumber;

skipTime 12;

waitUntil {
	if (_currentWave != BLWK_currentWaveNumber) exitWith {true};
	sleep 2;
	false
};

[_dateBeforeChange] remoteExecCall ["setDate",0];
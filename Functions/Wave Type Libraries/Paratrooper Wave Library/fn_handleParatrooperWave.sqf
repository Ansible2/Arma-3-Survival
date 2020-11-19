/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleParatrooperWave

Description:
	This is simply an alias for the below functions. It is used to exec
	 both on whomever the AI handler is without using multiple remoteExecs

	Executed from "BLWK_fnc_decideWaveType"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_handleParatrooperWave;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define MAX_NUM_PARAS 15
private _startingWaveUnits = call BLWK_fnc_createStdWaveInfantry;

private _unitCount = count _startingWaveUnits;
if (_startingWaveUnits < MAX_NUM_PARAS) then {

	null = [bulwarkBox,_startingWaveUnits,""] spawn BLWK_fnc_paratroopers;
} else {

};
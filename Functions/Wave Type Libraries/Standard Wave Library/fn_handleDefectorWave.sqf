/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleDefectorWave

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

		call BLWK_fnc_handleDefectorWave;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
private _startingWaveUnits = [true] call BLWK_fnc_createStdWaveInfantry;
[_startingWaveUnits,true] call BLWK_fnc_stdEnemyVehicles;
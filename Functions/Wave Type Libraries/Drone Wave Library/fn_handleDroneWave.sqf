/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleDroneWave

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

		call BLWK_fnc_handleDroneWave;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
call BLWK_fnc_createStdWaveInfantry;
[] spawn BLWK_fnc_createDroneWave;
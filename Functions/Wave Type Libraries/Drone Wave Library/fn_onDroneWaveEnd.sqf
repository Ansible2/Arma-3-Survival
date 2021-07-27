/* ----------------------------------------------------------------------------
Function: BLWK_fnc_onDroneWaveEnd

Description:
	Nils BLWK_allDronesCreated

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_onDroneWaveEnd;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_onDroneWaveEnd";

// handle drone wave global
missionNamespace setVariable ["BLWK_allDronesCreated",nil,[0,2] select isMultiplayer];

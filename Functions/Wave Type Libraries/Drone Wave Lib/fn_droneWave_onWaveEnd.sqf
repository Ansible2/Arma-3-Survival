/* ----------------------------------------------------------------------------
Function: BLWK_fnc_droneWave_onWaveEnd

Description:
    Resets the local "BLWK_droneWave_allDronesCreated" var

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_droneWave_onWaveEnd;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_droneWave_onWaveEnd";

localNamespace setVariable ["BLWK_droneWave_allDronesCreated",nil];

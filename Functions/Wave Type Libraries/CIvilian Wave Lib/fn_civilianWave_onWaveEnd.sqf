/* ----------------------------------------------------------------------------
Function: BLWK_fnc_civilianWave_onWaveEnd

Description:
	Deletes any civilians created for the wave.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_civilianWave_onWaveEnd;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_civilianWave_onWaveEnd";

// delete any alive civilians from special wave

private _civilians = localNamespace getVariable ["BLWK_civilianWave_civilians",[]];
_civilians apply { deleteVehicle _x };

localNamespace setVariable ["BLWK_civilianWave_civilians",nil];

/* ----------------------------------------------------------------------------
Function: BLWK_fnc_standardWave_onWaveInit

Description:
    The on wave init for standard waves.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_standardWave_onWaveInit;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_standardWave_onWaveInit";

if !(missionNamespace getVariable ["BLWK_isExtractionWave",false]) then {
    private _startingWaveUnits = call BLWK_fnc_getMustKillList;
    [_startingWaveUnits] call BLWK_fnc_standardWave_vehicles;
};


nil

/* ----------------------------------------------------------------------------
Function: BLWK_fnc_suicideWave_onWaveInit

Description:
    The on wave init for suicide waves.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_suicideWave_onWaveInit;
    (end)

Author(s):
    Hilltop(Willtop) & omNomios,
    Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_suicideWave_onWaveInit";

private _startingWaveUnits = call BLWK_fnc_getMustKillList;
private _numberOfBombers = round (count _startingWaveUnits / 4);
private _bombers = _startingWaveUnits select [0,_numberOfBombers];

[_bombers] remoteExecCall ["BLWK_fnc_suicideWave_makeBombers",BLWK_theAIHandlerOwnerID];

nil

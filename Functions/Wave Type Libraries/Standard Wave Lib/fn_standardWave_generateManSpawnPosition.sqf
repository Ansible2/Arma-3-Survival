/* ----------------------------------------------------------------------------
Function: BLWK_fnc_standardWave_generateManSpawnPosition

Description:
    Gets a spawn position for a unit to a man unit to spawn at.

Parameters:
    NONE

Returns:
    <PositionATL[]> - A position for a man unit to spawn.

Examples:
    (begin example)
        private _position = call BLWK_fnc_standardWave_generateManSpawnPosition;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_standardWave_generateManSpawnPosition";

selectRandom BLWK_infantrySpawnPositions

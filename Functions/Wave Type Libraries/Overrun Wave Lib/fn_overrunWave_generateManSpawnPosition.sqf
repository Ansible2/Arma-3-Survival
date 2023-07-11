/* ----------------------------------------------------------------------------
Function: BLWK_fnc_overrunWave_generateManSpawnPosition

Description:
    Sets up spawns for overrun wave units to be opposite of the players

Parameters:
    NONE

Returns:
    <PositionATL[]> - A position for a man unit to spawn.

Examples:
    (begin example)
        private _position = call BLWK_fnc_overrunWave_generateManSpawnPosition;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_overrunWave_generateManSpawnPosition";

#define NUMBER_ENEMY_POSITIONS 5
#define MAX_ENEMY_DIST 50
// localNamespace getVariable "BLWK_overrunWave_playerSpawn";

private _enemySpawns = localNamespace getVariable ["BLWK_overrunWave_enemySpawns",[]];

if (_enemySpawns isEqualTo []) then {
    private _enemyCenterPosition = localNamespace getVariable "BLWK_overrunWave_enemySpawnCenter";
    _enemySpawns pushBack _enemyCenterPosition;
    while {(count _enemySpawns) < NUMBER_ENEMY_POSITIONS} do {
        private _positionToPushBack = [
            _enemyCenterPosition,
            0,
            MAX_ENEMY_DIST, 
            0, 
            0
        ] call BIS_fnc_findSafePos;

        _enemySpawns pushBackUnique _positionToPushBack;
    };

    localNamespace setVariable ["BLWK_overrunWave_enemySpawns",_enemySpawns];
};


selectRandom _enemySpawns

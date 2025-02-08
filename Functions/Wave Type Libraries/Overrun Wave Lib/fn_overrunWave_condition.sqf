/* ----------------------------------------------------------------------------
Function: BLWK_fnc_overrunWave_condition

Description:
    Checks that the play area is has a viable set of opposite ends that both players
     and enemies will spawn on either side respectively.

Parameters:
    NONE

Returns:
    <BOOL> - Whether or not the overrun wave can proceed.

Examples:
    (begin example)
        private _canBeUsed = call BLWK_fnc_overrunWave_condition;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_overrunWave_condition";

#define DIST_BUFFER 50

private _distanceToCenter = BLWK_playAreaRadius + DIST_BUFFER;
private _potentialEnemySpawnCenterPosition = [];
private _potentialPlayerSpawnPosition = [];
private _playAreaIsViable = false;
for "_i" from 1 to 18 do {
    private _bearing = _i * 10;
    _potentialPlayerSpawnPosition = BLWK_playAreaCenter getPos [_distanceToCenter,_bearing];
    if (surfaceIsWater _potentialPlayerSpawnPosition) then {
        _potentialPlayerSpawnPosition = [];

    } else {
        _potentialEnemySpawnCenterPosition = BLWK_playAreaCenter getPos [_distanceToCenter,_bearing + 180];
        if (surfaceIsWater _potentialEnemySpawnCenterPosition) then {
            _potentialPlayerSpawnPosition = [];
            _potentialEnemySpawnCenterPosition = [];
        } else {
            _playAreaIsViable = true;
            break;
        };

    };
};

if (_playAreaIsViable) then {
    localNamespace setVariable ["BLWK_overrunWave_playerSpawn",_potentialPlayerSpawnPosition];
    localNamespace setVariable ["BLWK_overrunWave_enemySpawnCenter",_potentialEnemySpawnCenterPosition];
};


_playAreaIsViable

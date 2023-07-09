/* ----------------------------------------------------------------------------
Function: BLWK_fnc_wave_create

Description:
    Takes the first entry in the enemy man spawn queue, removes the item and then
     spawns the unit from the arguments.

Parameters:
    0: _waveConfig <CONFIG> - The config path of the wave to create
    1: _totalNumEnemiesToSpawnDuringWave <NUMBER> - The total number of enemies to spawn during the wave.
        If less than `1`, the number will be automatically calculated.

Returns:
    NOTHING

Examples:
    (begin example)
        [
            missionConfigFile >> "BLWK_waveTypes" >> "normalWaves" >> "standardWave"
        ] call BLWK_fnc_wave_create;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_wave_create";

// if (clientOwner isNotEqualTo BLWK_theAIHandlerOwnerID) exitWith {
//     private _message = [
//         "Executed BLWK_fnc_wave_create on clientOwner: ",
//         clientOwner,
//         " while BLWK_theAIHandlerOwnerID was: ",
//         BLWK_theAIHandlerOwnerID,
//         " on this machine! Defaulting to sever to handle the wave"
//     ] joinString "";
//     [_message,5] remoteExecCall ["KISKA_fnc_errorNotification",0];
// 	[_message,true] remoteExecCall ["KISKA_fnc_log",2];

// 	_this remoteExecCall ["BLWK_fnc_wave_create",2];
// };

// #define DEFAULT_ON_WAVE_SELECTED_NAME "BLWK_fnc_standardWave_onWaveSelected"
#define BASE_ENEMY_NUMBER 2

params [
    ["_waveConfig",configNull,[configNull]],
    ["_totalNumEnemiesToSpawnDuringWave",-1,[123]]
];


/* ----------------------------------------------------------------------------
    Create Queue
---------------------------------------------------------------------------- */
if (_totalNumEnemiesToSpawnDuringWave < BASE_ENEMY_NUMBER) then {
    _totalNumEnemiesToSpawnDuringWave = BASE_ENEMY_NUMBER * ((BLWK_enemiesPerWaveMultiplier * BLWK_currentWaveNumber) + 1);
    _totalNumEnemiesToSpawnDuringWave = _totalNumEnemiesToSpawnDuringWave + (BLWK_enemiesPerPlayerMultiplier * (count (call CBAP_fnc_players)));
    _totalNumEnemiesToSpawnDuringWave = round _totalNumEnemiesToSpawnDuringWave;
};


private "_spawnPosition_temp";
if (!BLWK_multipleEnemyPositions) then {
	_spawnPosition_temp = selectRandom BLWK_infantrySpawnPositions;
};

private _generatManClassesFunction = [_waveConfig,"generateMenClassnames"] call BLWK_fnc_waves_getFunctionFromConfig;
private _availableClassnames = call _generatManClassesFunction;
private _generateSpawnPositionFunction = [_waveConfig,"generateManSpawnPosition"] call BLWK_fnc_waves_getFunctionFromConfig;
private _onManCreatedFunctionName = [_waveConfig,"generateManSpawnPosition",true] call BLWK_fnc_waves_getFunctionFromConfig;

for "_i" from 1 to _totalNumEnemiesToSpawnDuringWave do {
    if (BLWK_multipleEnemyPositions) then {
        _spawnPosition_temp = call _generateSpawnPositionFunction;
    };

    private _class = [_availableClassnames] call KISKA_fnc_selectRandom;
    [
        _class,
        _spawnPosition_temp,
        _onManCreatedFunctionName
    ] call BLWK_fnc_spawnQueue_add;
};


localNamespace setVariable ["BLWK_currentWaveConfig",_waveConfig];

/* ----------------------------------------------------------------------------
    Spawn initial enemies
---------------------------------------------------------------------------- */
private _numberOfStartingEnemies = BLWK_maxEnemyInfantryAtOnce;
private _numberOfUnitsInQueue = count (call BLWK_fnc_spawnQueue_get);
if (_numberOfUnitsInQueue < BLWK_maxEnemyInfantryAtOnce) then {
	_numberOfStartingEnemies = _numberOfUnitsInQueue;
};
private _unit = objNull;
private _units = [];
for "_i" from 1 to _numberOfStartingEnemies do {
	call BLWK_fnc_spawnQueue_popAndCreate;
};


/* ----------------------------------------------------------------------------
    Activate Initialization
---------------------------------------------------------------------------- */
[_waveConfig,_numberOfStartingEnemies] spawn {
    params ["_waveConfig","_numberOfStartingEnemies"];
    
    waitUntil {
        (count (call BLWK_fnc_getMustKillList) >= _numberOfStartingEnemies)
    };

    [
        BLWK_fnc_waves_onInitialized,
        [_waveConfig]
    ] call CBAP_fnc_directCall;
};


nil

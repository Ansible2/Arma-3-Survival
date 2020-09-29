#include "..\Headers\Que Strings.hpp"

// CIPHER COMMENT: need to add support for defector waves and also for pistol only waves


#define BASE_ENEMY_NUMBER 2
BLWK_enemiesPerWaveMultiplier = 0.5;
BLWK_enemiesPerPlayerMultiplier = 1;


private _fn_getAvailableEnemyLists = {
	private _returnedLists = [];

	// classes
	_returnedLists pushback BLWK_level1_menClasses;
	// weight of class
	_returnedLists pushBack 1;

	if (BLWK_currentWaveNumber > 5) then {
		_returnedLists pushback BLWK_level2_menClasses;
		_returnedLists pushBack 2;
	};
	if (BLWK_currentWaveNumber > 10) then {
		_returnedLists pushback BLWK_level3_menClasses;
		_returnedLists pushBack 3;
	};
	if (BLWK_currentWaveNumber > 15) then {
		_returnedLists pushback BLWK_level4_menClasses;
		_returnedLists pushBack 4;
	};
	if (BLWK_currentWaveNumber > 20) then {
		_returnedLists pushback BLWK_level5_menClasses;
		_returnedLists pushBack 5;
	};

	_returnedLists
};

// get the total enemy number for this round
private _availableMenClassesWeighted = call _fn_getAvailableEnemyLists;
private _totalNumEnemiesToSpawnDuringWave = BASE_ENEMY_NUMBER * ((BLWK_enemiesPerWaveMultiplier * BLWK_currentWaveNumber) + 1);
_totalNumEnemiesToSpawnDuringWave = _totalNumEnemiesToSpawnDuringWave + (BLWK_enemiesPerPlayerMultiplier * (count (call CBAP_fnc_players)));
_totalNumEnemiesToSpawnDuringWave = round _totalNumEnemiesToSpawnDuringWave;



private "_selectedEnemyLevelTemp";
private _fn_selectEnemyType = {
	// select enemy level
	_selectedEnemyLevelTemp = selectRandomWeighted _availableMenClassesWeighted;
	// return a random entry from the selected level's array
	selectRandom _selectedEnemyLevelTemp
};

// cache AI spawn info for que
private ["_spawnPositionTemp","_typeTemp"];
for "_i" from 1 to _totalNumEnemiesToSpawnDuringWave do {
	_spawnPositionTemp = selectRandom BLWK_AISpawnPositions;
	_typeTemp = call _fn_selectEnemyType;

	[STANDARD_ENEMY_INFANTRY_QUE,_typeTemp,_spawnPositionTemp] call BLWK_fnc_addToQue;
};


// spawn the enemies for wave start
private _numStartingEnemies = BLWK_maxEnemyInfantryAtOnce;
private _spawnQueCount = count (missionNamespace getVariable [STANDARD_ENEMY_INFANTRY_QUE,[]]);
if (_spawnQueCount < BLWK_maxEnemyInfantryAtOnce) then {
	_numStartingEnemies = _spawnQueCount;
};
private _unit = objNull;
private _units = [];
for "_i" from 1 to _numStartingEnemies do {
	_unit = [STANDARD_ENEMY_INFANTRY_QUE,BLWK_fnc_stdEnemyManCreateCode] call BLWK_fnc_createFromQue;
	_units pushBack _unit;
};


_units
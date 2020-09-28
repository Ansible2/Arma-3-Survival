#define BASE_ENEMY_NUMBER 2
BLWK_enemiesPerWaveMultiplier = 0.5;
BLWK_enemiesPerPlayerMultiplier = 1;


private _fn_getAvailableEnemyLists = {
	private _returnedLists = [];

	_returnedLists pushback BLWK_level1_menClasses;
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
private _totalNumEnemiesToSpawn = BASE_ENEMY_NUMBER * ((BLWK_enemiesPerWaveMultiplier * BLWK_currentWaveNumber) + 1);
_totalNumEnemiesToSpawn = _totalNumEnemiesToSpawn + (BLWK_enemiesPerPlayerMultiplier * (count (call CBAP_fnc_players)));
_totalNumEnemiesToSpawn = round _totalNumEnemiesToSpawn;


private "_selectedEnemyLevelTemp";
private _fn_selectEnemyType = {
	// select enemy level
	_selectedEnemyLevelTemp = selectRandomWeighted _availableMenClassesWeighted;
	// return a random entry from the selected level's array
	selectRandom _selectedEnemyLevelTemp
};

// cache AI info for spawns
private ["_spawnPositionTemp","_typeTemp"];
for "_i" from 1 to _totalNumEnemiesToSpawn do {
	_spawnPositionTemp = selectRandom BLWK_AISpawnPositions;
	_typeTemp = call _fn_selectEnemyType;

	BLWK_AISpawnQue pushBack [_spawnPositionTemp,_typeTemp];
};

// adjust the immediate amount to spawn to either the max at once mission param
// or to the total number in this wave if it is less then BLWK_maxEnemyInfantryAtOnce
private _numEnemiesToSpawn = BLWK_maxEnemyInfantryAtOnce;
private _spawnQueCount = count BLWK_AISpawnQue;
if (_spawnQueCount < BLWK_maxEnemyInfantryAtOnce) then {
	_numEnemiesToSpawn = _spawnQueCount;
};

for "_i" from 1 to _numEnemiesToSpawn do {
	call BLWK_fnc_createEnemyFromQue;
};
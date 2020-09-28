#define BASE_ENEMY_NUMBER 2
BLWK_enemiesPerWaveMultiplier = 0.5;
BLWK_enemiesPerPlayerMultiplier = 1;

// Each wave level will add to the previous ones, albeit, 
// taking an ever larger percentage until we're at 50% for the current
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

[_totalNumEnemiesToSpawn] call 

private "_selectedEnemyLevelTemp";
private _fn_selectEnemyType = {
	// select enemy level
	_selectedEnemyLevelTemp = selectRandomWeighted _availableMenClassesWeighted;
	// return a random entry from the selected level's array
	selectRandom _selectedEnemyLevelTemp
};

// cache AI info for spawns
private ["_spawnPositionTemp","_typeTemp"];
private _AISpawnQueArray = [];
for "_i" from 1 to _totalNumEnemiesToSpawn do {
	_spawnPositionTemp = selectRandom BLWK_AISpawnPositions;
	_typeTemp = call _fn_selectEnemyType;

	_AISpawnQueArray pushBack [_spawnPositionTemp,_typeTemp];
};

missionNamespace setVariable ["BLWK_AISpawnQue",_AISpawnQueArray,BLWK_theAIHandler];





// need to adjust skill depending on round

private _numEnemiesToSpawn = BLWK_maxEnemyInfantryAtOnce;
if (count _AISpawnQueArray < BLWK_maxEnemyInfantryAtOnce) then {
	_numEnemiesToSpawn = count _AISpawnQueArray;
};

for "_i" from 1 to _numEnemiesToSpawn do {
	remoteExec ["BLWK_fnc_createEnemyFromQue",BLWK_theAIHandler];
};


/*
	- Base number of enemies is 2
	- We start with a multiplier of 1
	- Each round adds 0.5 to that multiplier
	- - So, round 3, the multiplier would be 2.5 ((0.5 * 3) + 1)

	- Lastly we multiply it by the base, so 2.5*2 = 5
*/


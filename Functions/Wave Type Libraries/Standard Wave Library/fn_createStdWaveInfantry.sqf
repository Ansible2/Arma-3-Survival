#include "..\..\..\Headers\String Constants.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createStdWaveInfantry

Description:
	Creates the standard infantry for a normal wave.
	
	Also has the ability to queue up units based upon the mission param size of
	 units allowed at once.
	 
Parameters:
	0: _isDefectorWave : <BOOL> - Will this be a wave of defectors

Returns:
	ARRAY - the units created

Examples:
    (begin example)

		[false] call BLWK_fnc_createStdWaveInfantry;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define BASE_ENEMY_NUMBER 2

params [
	["_isDefectorWave",false,[true]]
];

private _fn_getAvailableEnemyLists = {
	if (_isDefectorWave) exitWith {
		[BLWK_friendly_menClasses,1]
	};

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

// cache AI spawn info for queue
private ["_spawnPositionTemp","_typeTemp"];
for "_i" from 1 to _totalNumEnemiesToSpawnDuringWave do {
	_spawnPositionTemp = selectRandom BLWK_infantrySpawnPositions;
	_typeTemp = call _fn_selectEnemyType;

	[STANDARD_ENEMY_INFANTRY_QUEUE,_typeTemp,_spawnPositionTemp] call BLWK_fnc_addToQueue;
};


// spawn the enemies for wave start
private _numStartingEnemies = BLWK_maxEnemyInfantryAtOnce;
private _spawnQueueCount = count (missionNamespace getVariable [STANDARD_ENEMY_INFANTRY_QUEUE,[]]);
if (_spawnQueueCount < BLWK_maxEnemyInfantryAtOnce) then {
	_numStartingEnemies = _spawnQueueCount;
};
private _unit = objNull;
private _units = [];
for "_i" from 1 to _numStartingEnemies do {
	_unit = [STANDARD_ENEMY_INFANTRY_QUEUE,"_this call BLWK_fnc_stdEnemyManCreateCode"] call BLWK_fnc_createFromQueue;
	_units pushBack _unit;
};

missionNamespace setVariable ["BLWK_initialWaveSpawnComplete",true];
_units
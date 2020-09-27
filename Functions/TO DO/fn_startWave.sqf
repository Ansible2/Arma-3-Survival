// decide if special wave

// decide what AI should spawn

// start AI que loop

// spawn AI

// give AI the hit event handlers that add points

// inform pepople the round has started and what kind it is/number

// need to decide on special waves

if (!isServer) exitWith {};

// spawn loot
call BLWK_fnc_spawnLoot;


private _previousWaveNum = missionNamespace getVariable ["BLWK_currentWaveNumber",0];
missionNamespace setVariable ["BLWK_currentWaveNumber", _previousWaveNum + 1];

BLWK_friendly_menClasses
BLWK_friendly_vehicleClasses
BLWK_level1_menClasses
BLWK_level1_vehicleClasses
BLWK_level2_menClasses
BLWK_level2_vehicleClasses
BLWK_level3_menClasses
BLWK_level3_vehicleClasses
BLWK_level4_menClasses
BLWK_level4_vehicleClasses
BLWK_level5_menClasses
BLWK_level5_vehicleClasses

/*
	VEHICLES:
		- any round with above 4 players can have 2 vehicles spawn but less, only one will spawn
		
		- Vehicles will be staggered by at least 120 seconds. So first 1 spawns then the 2nd
		
		- vehicles are seperated into light and heavy cars, and light and heavt armour
		- -	There will be max percentage changces that each of these will be able to spawn
		- - - These spawn rates will be affected by:
		- - - - player count
		- - - - how long its been since a vehicle spawned
		- - Use a weighted array to select what gets spawned
		
		- There will still be a param value to determine when vehicles can spawn
		
		- vehicles can not spawn 2 waves in a row
		
		- There will be a threshold to determine if a vehicle will spwn or not:
		- - so if we wind up at 0 - 0.25 no vehicle spawns
		- - 0.25 - 0.5 small chance
		- - 0.5 - 0.75 Likely
		- - 0.75 - 1 100% you will get a vehicle

		- There will need to be two values to consider
		- - A. How likely is it that ANY vehicle will spawn this round?
		- - B. How likely is it that each TYPE of vehicle wil spawn?
*/
if (!isServer) exitWIth {};

#define BASE_LIKlIHOOD_HEAVY_ARMOUR 0.10
#define BASE_LIKlIHOOD_LIGHT_ARMOUR 0.15
#define BASE_LIKlIHOOD_HEAVY_CAR 0.25
#define BASE_LIKlIHOOD_LIGHT_CAR 0.50
#define ROUNDS_SINCE_MINUS_TWO(TOTAL_ROUNDS_SINCE) TOTAL_ROUNDS_SINCE - 2 

// CIPHER COMMENT: check for max wave upon end wave (the ting that will end the mission)


if (BLWK_currentWaveNumber >= BLWK_vehicleStartWave) then {
	private _howLikelyIsAVehicleToSpawn = 0;
	private _howLikelyIsAVheicleNOTToSpawn = 1 - _howLikelyIsAVehicleToSpawn;

	// The default value for BLWK_roundsSinceVehicleSpawned is 2 rounds because
	/// it will always have been at least two rounds before the BLWK_vehicleStartWave
	private _roundsSinceVehicleSpawned = missionNamespace getVariable ["BLWK_roundsSinceVehicleSpawned",2];
	private _vehicleWillSpawn = selectRandomWeighted [true,_howLikelyIsAVehicleToSpawn,false,_howlikelyIsAVheicleToNotSpawn];

	// wait until it has been at least two rounds to spawn another vehicle
	if (_roundsSinceVehicleSpawned >= 2) then {
		
		// only the rounds after the two will contribute to the liklihood percentage (5% per round)
		_howLikelyIsAVehicleToSpawn = ROUNDS_SINCE_MINUS_TWO(_roundsSinceVehicleSpawned) * 0.05;

		if (_vehicleWillSpawn) then {
			private _likelihoodItsHeavyArmour = BASE_LIKlIHOOD_HEAVY_ARMOUR;
			private _likelihoodItsLightArmour = BASE_LIKlIHOOD_LIGHT_ARMOUR;
			private _likelihoodItsHeavyCar = BASE_LIKlIHOOD_HEAVY_CAR;
			private _likelihoodItsLightCar = BASE_LIKlIHOOD_LIGHT_CAR;
			


		};
	};
};

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
private _AISpawnQueArray = [];
for "_i" from 1 to _totalNumEnemiesToSpawn do {
	_spawnPositionTemp = selectRandom BLWK_AISpawnPositions;
	_typeTemp = call _fn_selectEnemyType;

	_AISpawnQueArray pushBack [_spawnPositionTemp,_typeTemp];
};

missionNamespace setVariable ["BLWK_AISpawnQue",_AISpawnQueArray,BLWK_theAIHandler];





// need to adjust skill depending on round

private _numEnemiesToSpawn = BLWK_maxEnemiesAtOnce;
if (count _AISpawnQueArray < BLWK_maxEnemiesAtOnce) then {
	_numEnemiesToSpawn = count _AISpawnQueArray;
};
private ["_groupTemp","_spawnedUnitTemp"];
private _bulwarkPosition = getPosATL bulwarkBox;
for "_i" from 1 to _numEnemiesToSpawn do {
	(_AISpawnQueArray deleteAt 0) params ["_position","_type"];

	_groupTemp = createGroup OPFOR;
	_spawnedUnitTemp = _type createVehicle _position;

	[_spawnedUnitTemp] joinSilent _groupTemp;

	_groupTemp allowFleeing false;

	[_groupTemp, _bulwarkPosition, 20, "SAD", "AWARE", "RED"] call CBAP_fnc_addWaypoint;

	BLWK_zeus addCuratorEditableObjects [[_spawnedUnitTemp],false];

	BLWK_aliveEnemies pushBack _spawnedUnitTemp;


	// add the hit eventhandler to every player locally
	// make the body into a function and pass _this to reduce network load with remoteExec
	_spawnedUnit addEventHandler ["Hit", {
		private _insitgator = _this select 3;

		if (_instigator isEqualTo player) then {
			private _unit = _this select 0;
			private _points = BLWK_pointsForHit + (BLWK_pointsMultiForDamage * _damage);
			[_unit,_points] call BLWK_fnc_createHitMarker;
			[_points] call BLWK_fnc_addPoints;
		};
	}];

	_spawnedUnitTemp addMPEventHandler ["mpKilled",{
		//_this call BLWK_fnc_enemyKilledEvent;

		if (isServer) then {
			// if there is nobody to spawn, exit
			if (BLWK_AISpawnQue isEqualTo []) exitWith {};

			if (count BLWK_aliveEnemies <= BLWK_maxEnemiesAtOnce) then {
				BLWK_aliveEnemies deleteAt (BLWK_aliveEnemies findIf {_x isEqualTo _unitKilled});
				// needs to spawn the unit and then pushBack the new one into BLWK_aliveEnemies
				call BLWK_fnc_updateAIQue;
			};
		};
		if (local _instigator AND {isPlayer _instigator}) then {
			[_unitKilled,BLWK_pointsForKill] call BLWK_fnc_createHitMarker;
			[_points] call BLWK_fnc_addPoints;
		};

		// need to remove the hit eventhandler of the unit too (on all machines)
		// possibly needs to be stored in the unit's namespace to get in the function

		// don't forget to pass _thisEventHandler to the function
		// mp events need to be removed on the unit where they are local
		if (local _unitKilled) then {
			removeMPEventHandler ["mpKilled",_thisEventHandler];
		};

		// needs to update que
		// need to give points to the local person
		// need to create hit marker
		// need to make sure the instigator is actually a player before adding points
	}];
	// need to add all the units eventhandlers
	// hit event for points
	// killed event for points and to spawn another AI if there are ones present in que
};


/*
	- Base number of enemies is 2
	- We start with a multiplier of 1
	- Each round adds 0.5 to that multiplier
	- - So, round 3, the multiplier would be 2.5 ((0.5 * 3) + 1)

	- Lastly we multiply it by the base, so 2.5*2 = 5
*/


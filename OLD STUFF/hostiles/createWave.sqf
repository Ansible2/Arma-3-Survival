/**
*  createWave
*
*  Creates all the hostiles for the given round
*
*  Domain: Server
**/


if (BLWK_currentWaveNumber < (BLWK_vehicleStartWave + 5)) then {
	ArmourChance = 0;
	ArmourMaxSince = 0;
	ArmourCount = 0;
	carChance = 3;
	carMaxSince = 2;
	carCount = 1;
};

if (BLWK_currentWaveNumber >= (BLWK_vehicleStartWave + 5) && BLWK_currentWaveNumber < (BLWK_vehicleStartWave + 10)) then {
	ArmourChance = 4;
	ArmourMaxSince = 4;
	ArmourCount = 1;
	carChance = 3;
	carMaxSince = 3;
	carCount = 1 + (floor (playersNumber west / 4));
};

if (BLWK_currentWaveNumber >= (BLWK_vehicleStartWave + 10) && BLWK_currentWaveNumber < (BLWK_vehicleStartWave + 15)) then {
	ArmourChance = 3;
	ArmourMaxSince = 3;
	ArmourCount = 1 + (floor (playersNumber west / 4));
	carChance = 2;
	carMaxSince = 2;
	carCount = 2 + (floor (playersNumber west / 4));
};

if (BLWK_currentWaveNumber >= (BLWK_vehicleStartWave + 15) && BLWK_currentWaveNumber < (BLWK_vehicleStartWave + 20)) then {
	ArmourChance = 2;
	ArmourMaxSince = 2;
	ArmourCount = 2 + (floor (playersNumber west / 4));
	carChance = 1;
	carMaxSince = 2;
	carCount = 2 + (floor (playersNumber west / 4));
};

if (BLWK_currentWaveNumber >= (BLWK_vehicleStartWave + 20)) then {
	ArmourChance = 2;
	ArmourMaxSince = 1;
	ArmourCount = 3 + (floor (playersNumber west / 4));
	carChance = 1;
	carMaxSince = 1;
	carCount = 3 + (floor (playersNumber west / 4));
};

if ((BLWK_currentWaveNumber >= BLWK_vehicleStartWave && (floor random ArmourChance) == 1) || (BLWK_currentWaveNumber >= BLWK_vehicleStartWave && wavesSinceArmour >= ArmourMaxSince)) then {
	_spwnVec = execVM "hostiles\spawnVehicle.sqf";
	waitUntil {scriptDone _spwnVec};
	wavesSinceArmour = 0;
}else{
	if (BLWK_currentWaveNumber >= BLWK_vehicleStartWave) then {
		wavesSinceArmour = wavesSinceArmour + 1;
	};
};

if ((BLWK_currentWaveNumber >= BLWK_vehicleStartWave && (floor random carChance) == 1) || (BLWK_currentWaveNumber >= BLWK_vehicleStartWave && wavesSinceArmour >= carMaxSince)) then {
	_spwnVec = execVM "hostiles\spawnCar.sqf";
	waitUntil {scriptDone _spwnVec};
	wavesSinceCar = 0;
}else{
	if (BLWK_currentWaveNumber >= BLWK_vehicleStartWave) then {
		wavesSinceCar = wavesSinceCar + 1;
	};
};

_noOfPlayers = 1 max floor ((playersNumber west) * BLWK_enemiesPerPlayerMultiplier);
_multiplierBase = BLWK_enemiesPerWaveMultiplier;
_SoldierMulti = BLWK_currentWaveNumber / 5;

if (BLWK_currentWaveNumber <= 2) then {
	_multiplierBase = 1
};

_squadCount = floor (BLWK_currentWaveNumber * _multiplierBase);
for ("_i") from 1 to (floor (BLWK_currentWaveNumber * _multiplierBase)) do {
	_script = [BLWK_enemyClasses_level_1, BLWK_currentWaveNumber, _noOfPlayers, BLWK_pointMulti_men_level1] execVM "hostiles\spawnSquad.sqf";
	waitUntil {scriptDone _script};
};

if (BLWK_currentWaveNumber > 6) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [BLWK_enemyClasses_level_2, BLWK_currentWaveNumber, _noOfPlayers, BLWK_pointMulti_men_level2] execVM "hostiles\spawnSquad.sqf";
		waitUntil {scriptDone _script};
	};
};

if (BLWK_currentWaveNumber > 12) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [BLWK_enemyClasses_level_3, BLWK_currentWaveNumber, _noOfPlayers, BLWK_pointMulti_men_level3] execVM "hostiles\spawnSquad.sqf";
		waitUntil {scriptDone _script};
	};
};

//Cipher Comment: why is this here? Why not just return true?
waveSpawned = true;
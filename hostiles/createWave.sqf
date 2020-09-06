/**
*  createWave
*
*  Creates all the hostiles for the given round
*
*  Domain: Server
**/


if (attkWave < (BLWK_vehicleStartWave + 5)) then {
	ArmourChance = 0;
	ArmourMaxSince = 0;
	ArmourCount = 0;
	carChance = 3;
	carMaxSince = 2;
	carCount = 1;
};

if (attkWave >= (BLWK_vehicleStartWave + 5) && attkWave < (BLWK_vehicleStartWave + 10)) then {
	ArmourChance = 4;
	ArmourMaxSince = 4;
	ArmourCount = 1;
	carChance = 3;
	carMaxSince = 3;
	carCount = 1 + (floor (playersNumber west / 4));
};

if (attkWave >= (BLWK_vehicleStartWave + 10) && attkWave < (BLWK_vehicleStartWave + 15)) then {
	ArmourChance = 3;
	ArmourMaxSince = 3;
	ArmourCount = 1 + (floor (playersNumber west / 4));
	carChance = 2;
	carMaxSince = 2;
	carCount = 2 + (floor (playersNumber west / 4));
};

if (attkWave >= (BLWK_vehicleStartWave + 15) && attkWave < (BLWK_vehicleStartWave + 20)) then {
	ArmourChance = 2;
	ArmourMaxSince = 2;
	ArmourCount = 2 + (floor (playersNumber west / 4));
	carChance = 1;
	carMaxSince = 2;
	carCount = 2 + (floor (playersNumber west / 4));
};

if (attkWave >= (BLWK_vehicleStartWave + 20)) then {
	ArmourChance = 2;
	ArmourMaxSince = 1;
	ArmourCount = 3 + (floor (playersNumber west / 4));
	carChance = 1;
	carMaxSince = 1;
	carCount = 3 + (floor (playersNumber west / 4));
};

if ((attkWave >= BLWK_vehicleStartWave && (floor random ArmourChance) == 1) || (attkWave >= BLWK_vehicleStartWave && wavesSinceArmour >= ArmourMaxSince)) then {
	_spwnVec = execVM "hostiles\spawnVehicle.sqf";
	waitUntil {scriptDone _spwnVec};
	wavesSinceArmour = 0;
}else{
	if (attkWave >= BLWK_vehicleStartWave) then {
		wavesSinceArmour = wavesSinceArmour + 1;
	};
};

if ((attkWave >= BLWK_vehicleStartWave && (floor random carChance) == 1) || (attkWave >= BLWK_vehicleStartWave && wavesSinceArmour >= carMaxSince)) then {
	_spwnVec = execVM "hostiles\spawnCar.sqf";
	waitUntil {scriptDone _spwnVec};
	wavesSinceCar = 0;
}else{
	if (attkWave >= BLWK_vehicleStartWave) then {
		wavesSinceCar = wavesSinceCar + 1;
	};
};

_noOfPlayers = 1 max floor ((playersNumber west) * BLWK_enemiesPerPlayerMultiplier);
_multiplierBase = BLWK_enemiesPerWaveMultiplier;
_SoldierMulti = attkWave / 5;

if (attkWave <= 2) then {
	_multiplierBase = 1
};

_squadCount = floor (attkWave * _multiplierBase);
for ("_i") from 1 to (floor (attkWave * _multiplierBase)) do {
	_script = [BLWK_enemyClasses_level_1, attkWave, _noOfPlayers, BLWK_pointMulti_men_level1] execVM "hostiles\spawnSquad.sqf";
	waitUntil {scriptDone _script};
};

if (attkWave > 6) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [BLWK_enemyClasses_level_2, attkWave, _noOfPlayers, BLWK_pointMulti_men_level2] execVM "hostiles\spawnSquad.sqf";
		waitUntil {scriptDone _script};
	};
};

if (attkWave > 12) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [BLWK_enemyClasses_level_3, attkWave, _noOfPlayers, BLWK_pointMulti_men_level3] execVM "hostiles\spawnSquad.sqf";
		waitUntil {scriptDone _script};
	};
};

//Cipher Comment: why is this here? Why not just return true?
waveSpawned = true;
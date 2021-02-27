#include "..\..\..\Headers\Vehicle Class Indexes.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stdEnemyVehicles

Description:
	Roles for the chance of vehicles spawning during a wave.
	Automatically sifts through available classes based on levels/wave number.

	Will not spawn more then two vehicles which is already rare.

Parameters:
	0: _availableInfantry : <ARRAY> - An array of units to choose from to crew the vehicles
	1: _isDefectorWave : <BOOL> - Creates vehicles from friendly vehicle classes if used

Returns:
	ARRAY - The spawned vehicles

Examples:
    (begin example)

		_vehiclesArray = [myUnits,false] call BLWK_fnc_stdEnemyVehicles;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define VEHICLE_TYPES [LIGHT_CAR,HEAVY_CAR,LIGHT_ARMOR,HEAVY_ARMOR,TRANSPORT_HELI,ATTACK_HELI]
#define VEHICLE_LIKELIHOODS [BLWK_lightCarLikelihood,BLWK_heavyCarLikelihood,BLWK_lightArmorLikelihood,BLWK_heavyArmorLikelihood,BLWK_transportHeliLikelihood,BLWK_attackHeliLikelihood]

scriptName "BLWK_fnc_stdEnemyVehicles";

if !(BLWK_currentWaveNumber >= BLWK_vehicleStartWave) exitWith {[]};

#define VEHICLE_SPAWN_INCREMENT 0.05 // how much to increase likelihood by each round

params [
	"_availableInfantry",
	["_isDefectorWave",false,[true]]
];

if (!local BLWK_theAIHandlerEntity) exitWith {[]};

// special waves will not contribute to this count
private _roundsSinceVehicleSpawned = missionNamespace getVariable ["BLWK_roundsSinceVehicleSpawned",1];
// wait until it has been at least one round since a vehicle spawn to get another one
if (_roundsSinceVehicleSpawned < BLWK_minRoundsSinceVehicleSpawned) exitWith {
	BLWK_roundsSinceVehicleSpawned = _roundsSinceVehicleSpawned + 1;
	[]
};


// each round increases the likelihood of a vehicle spawn by 5%
private _howLikelyIsAVehicleToSpawn = (_roundsSinceVehicleSpawned * VEHICLE_SPAWN_INCREMENT) + (BLWK_baseVehicleSpawnLikelihood / 10);
if (_howLikelyIsAVehicleToSpawn > 1) then {
	_howLikelyIsAVehicleToSpawn = 1;
};

[["Vehicle spawn likelihood is ",_howLikelyIsAVehicleToSpawn],false] call KISKA_fnc_log;
private _howLikelyIsAVehicleNOTToSpawn = 1 - _howLikelyIsAVehicleToSpawn;

private _vehicleWillSpawn = selectRandomWeighted [true,_howLikelyIsAVehicleToSpawn,false,_howLikelyIsAVehicleNOTToSpawn];
if !(_vehicleWillSpawn) exitWith {
	BLWK_roundsSinceVehicleSpawned = _roundsSinceVehicleSpawned + 1;
	[]
};

missionNamespace setVariable ["BLWK_roundsSinceVehicleSpawned",0];


// decide what type of vehicles can spawn
private _vehicleTypeHash = createHashMap;
private _likelihoodWeights = [];
private _vehicleTypeValues = [];
{	
	private _vehicleClasses = [];
	if (_isDefectorWave) then {
		_vehicleClasses = BLWK_friendly_vehicleClasses select _x;
	} else {
		_vehicleClasses = [_x,false] call BLWK_fnc_getEnemyVehicleClasses;
	};

	if (_vehicleClasses isNotEqualTo []) then {
		_vehicleTypeHash set [_x,_vehicleClasses];
		_likelihoodWeights pushBack (VEHICLE_LIKELIHOODS select _forEachIndex);
		_vehicleTypeValues pushBack _x;
	};
} forEach VEHICLE_TYPES;

if (_likelihoodArray isEqualTo []) exitWith {
	["No vehicles to spawn for enemy factions, exiting",false] call KISKA_fnc_log;
	[]
};


private _returnedVehicles = [];
private _fn_spawnAVehicle = {
	[str _likelihoodWeights,false,true,false] call KISKA_fnc_log;
	[str _vehicleTypeValues,false,true,false] call KISKA_fnc_log;
	private _vehicleType = _vehicleTypeValues selectRandomWeighted _likelihoodWeights;
	[["Selected vehicle type: ",_vehicleType],false] call KISKA_fnc_log;

	// don't want doubling of two types of helicopters
	// so delete index from _likelihoodWeights
	private _isHelicopter = false;
	private "_vehicleClass";
	if (_vehicleType isEqualTo TRANSPORT_HELI OR {_vehicleType isEqualTo ATTACK_HELI}) then {
		["Selected vehicle type is helicopter",false] call KISKA_fnc_log;
		_isHelicopter = true;
		_vehicleClass = (_vehicleTypeHash get _vehicleType) select 0;
	} else {
		_vehicleClass = selectRandom (_vehicleTypeHash get _vehicleType);
	};

	private "_vehicle";
	if (_isHelicopter) then {
		_defaultAircraft = ["O_Heli_Attack_02_dynamicLoadout_F","B_Heli_Transport_01_F"] select (_vehicleType isEqualTo TRANSPORT_HELI);
		private _vehicleArray = [
			BLWK_playAreaCenter,
			BLWK_playAreaRadius,
			_vehicleClass,
			99999,
			10,
			random [40,50,60],
			-1,
			_defaultAircraft,
			"",
			OPFOR
		] call BLWK_fnc_passiveHelicopterGunner;

		_vehicle = _vehicleArray select 0;
		// loop through crew
		(_vehicleArray select 1) apply {
			[_x] remoteExecCall ["BLWK_fnc_addToMustKillArray",2];
			[_x] call BLWK_fnc_addStdEnemyManEHs;
			_x allowDamage true;
		};
	} else {
		private _spawnPosition = selectRandom BLWK_vehicleSpawnPositions;
		_vehicle = _vehicleClass createVehicle _spawnPosition;

		private _crew = _availableInfantry select [0,3];
		_availableInfantry deleteRange [0,3];

		private _group = createGroup (side (_crew select 0));
		_group deleteGroupWhenEmpty true;
		_group allowFleeing 0;

		// CIPHER COMMENT: May need to clear the crews previous waypoints
		_crew joinSilent _group;
		[_group,_vehicle] call KISKA_fnc_setCrew;
		[_group, BLWK_mainCrate, 20, "SAD", "AWARE", "RED"] call CBAP_fnc_addWaypoint;

		[BLWK_zeus, [[_vehicle],false]] remoteExecCall ["addCuratorEditableObjects",2];	
	};

	_returnedVehicles pushBack _vehicle;
	_vehicle addEventHandler ["KILLED",{
		_this call BLWK_fnc_stdVehicleKilledEvent;
	}];
};



call _fn_spawnAVehicle;
// do a role for a second vehicle
private _howLikelyIsASecondVehicleToSpawn = _howLikelyIsAVehicleToSpawn / 1.5;

private _secondVehicleWillSpawn = selectRandomWeighted [true,_howLikelyIsASecondVehicleToSpawn,false,1 - _howLikelyIsASecondVehicleToSpawn];
if (_secondVehicleWillSpawn) then {
	call _fn_spawnAVehicle;
};


_returnedVehicles
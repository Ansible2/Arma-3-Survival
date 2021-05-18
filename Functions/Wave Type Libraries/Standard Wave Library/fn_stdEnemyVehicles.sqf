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
#define VEHICLE_TYPES [LIGHT_CAR,HEAVY_CAR,LIGHT_ARMOR,HEAVY_ARMOR]
#define VEHICLE_LIKELIHOODS [BLWK_lightCarLikelihood,BLWK_heavyCarLikelihood,BLWK_lightArmorLikelihood,BLWK_heavyArmorLikelihood]
#define SECOND_VEHICLE_DIVIDER 1.35

scriptName "BLWK_fnc_stdEnemyVehicles";

if !(BLWK_currentWaveNumber >= BLWK_vehicleStartWave) exitWith {[]};

#define VEHICLE_SPAWN_INCREMENT 0.05 // how much to increase likelihood by each round

params [
	"_availableInfantry",
	["_isDefectorWave",false,[true]]
];

if (clientOwner isNotEqualTo BLWK_theAIHandlerOwnerID) exitWith {[]};

if (count _availableInfantry < 2) exitWith {
	["There is less than 2 infantry available to crew a vehicle"] call KISKA_fnc_log;
	[]
};

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

private _vehicleWillSpawn = [true,false] selectRandomWeighted [_howLikelyIsAVehicleToSpawn,_howLikelyIsAVehicleNOTToSpawn];
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

	// Don't duplicate vehicles if possible for the sake of variety
	if (count _vehicleTypeValues > 1) then {
		private _index = _vehicleTypeValues find _vehicleType;
		_vehicleTypeValues deleteAt _index;
		_likelihoodWeights deleteAt _index;
	};

	[["Selected vehicle type: ",_vehicleType],false] call KISKA_fnc_log;

	private _vehicleClass = selectRandom (_vehicleTypeHash get _vehicleType);
	private _spawnPosition = selectRandom BLWK_vehicleSpawnPositions;
	private _vehicle = _vehicleClass createVehicle _spawnPosition;

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


	_returnedVehicles pushBack _vehicle;
	_vehicle addEventHandler ["KILLED",{
		_this call BLWK_fnc_stdVehicleKilledEvent;
	}];
};



call _fn_spawnAVehicle;

// do a role for a second vehicle
// make sure there are enough AI to even crew a ground vehicle
if (count _availableInfantry > 1) then {
	private _howLikelyIsASecondVehicleToSpawn = _howLikelyIsAVehicleToSpawn / SECOND_VEHICLE_DIVIDER;
	private _secondVehicleWillSpawn = [true,false] selectRandomWeighted [_howLikelyIsASecondVehicleToSpawn,1 - _howLikelyIsASecondVehicleToSpawn];
	if (_secondVehicleWillSpawn) then {
		call _fn_spawnAVehicle;
	};
};


_returnedVehicles

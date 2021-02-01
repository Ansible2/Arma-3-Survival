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
scriptName "BLWK_fnc_stdEnemyVehicles";

if !(BLWK_currentWaveNumber >= BLWK_vehicleStartWave) exitWith {[]};

//#define BASE_VEHICLE_SPAWN_LIKELIHOOD 0.30
#define VEHICLE_SPAWN_INCREMENT 0.05 // how much to increase likelihood by each round

params [
	"_availableInfantry",
	["_isDefectorWave",false,[true]]
];

if (!local BLWK_theAIHandlerEntity) exitWith {[]};

// special waves will not contribute to this count
private _roundsSinceVehicleSpawned = missionNamespace getVariable ["BLWK_roundsSinceVehicleSpawned",2];
// wait until it has been at least one round since a vehicle spawn to get another one
if (_roundsSinceVehicleSpawned < 1) exitWith {
	BLWK_roundsSinceVehicleSpawned = _roundsSinceVehicleSpawned + 1;
	[]
};


// each round increases the likelihood of a vehicle spawn by 5%
private _howLikelyIsAVehicleToSpawn = (_roundsSinceVehicleSpawned * VEHICLE_SPAWN_INCREMENT) + (BLWK_baseVehicleSpawnLikelihood / 100);
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
private _lightCarsArray = [];
private _heavyCarsArray = [];
private _lightArmourArray = [];
private _heavyArmourArray = [];
private _fn_checkLevelsClasses = {
	params ["_levelsVehicleArray"];

	private _fn_handleVehicleArray = {
		params ["_array"];

		private _return = "";
		if !(_array isEqualTo []) then {
			_return = selectRandom _array;
		};

		_return
	};

	private ["_class","_vehicleTypeArray"];
	{
		_vehicleTypeArray = _x;
		_class = [_vehicleTypeArray] call _fn_handleVehicleArray; 

		if !(_class isEqualTo "") then {
			// if the vehicle type is not empty
			switch (_forEachIndex) do {
				case 0:{
					_lightCarsArray pushBack _class
				};
				case 1:{
					_heavyCarsArray pushBack _class
				};
				case 2:{
					_lightArmourArray pushBack _class
				};
				case 3:{
					_heavyArmourArray pushBack _class
				};
				default {};
			};
		};
	} forEach _levelsVehicleArray;
};

// get all available vehicle types depending on round
if !(_isDefectorWave) then {
	[BLWK_level1_vehicleClasses] call _fn_checkLevelsClasses;
	if (BLWK_currentWaveNumber > 5) then {
		[BLWK_level2_vehicleClasses] call _fn_checkLevelsClasses;
	};
	if (BLWK_currentWaveNumber > 10) then {
		[BLWK_level3_vehicleClasses] call _fn_checkLevelsClasses;
	};
	if (BLWK_currentWaveNumber > 15) then {
		[BLWK_level4_vehicleClasses] call _fn_checkLevelsClasses;
	};
	if (BLWK_currentWaveNumber > 20) then {
		[BLWK_level5_vehicleClasses] call _fn_checkLevelsClasses;
	};
} else {
	[BLWK_friendly_vehicleClasses] call _fn_checkLevelsClasses;
};


// get all available classes for each vehicle type
private _vehicleTypeSelection = [];
if !(_lightCarsArray isEqualTo []) then {
	_vehicleTypeSelection append [_lightCarsArray,BLWK_lightCarLikelihood];
};
if !(_heavyCarsArray isEqualTo []) then {
	_vehicleTypeSelection append [_heavyCarsArray,BLWK_heavyCarLikelihood];
};
if !(_lightArmourArray isEqualTo []) then {
	_vehicleTypeSelection append [_lightArmourArray,BLWK_lightArmorLikelihood];
};
if !(_heavyArmourArray isEqualTo []) then {
	_vehicleTypeSelection append [_heavyArmourArray,BLWK_heavyArmorLikelihood];
};

if (_vehicleTypeSelection isEqualTo []) exitWith {
	diag_log "No vehicles to spawn for enemy factions, exiting";
	[]
};

private _returnedVehicles = [];
private _fn_spawnAVehicle = {
	private _selectedTypeArray = selectRandomWeighted _vehicleTypeSelection;
	private _selectedVehicleClass = selectRandom _selectedTypeArray;
	private _spawnPosition = selectRandom BLWK_vehicleSpawnPositions;
	private _createdVehicle = _selectedVehicleClass createVehicle _spawnPosition;

	_createdVehicle addEventHandler ["KILLED",{
		_this call BLWK_fnc_stdVehicleKilledEvent;
	}];

	private _crew = _availableInfantry select [0,3];
	_availableInfantry deleteRange [0,3];

	private _group = createGroup (side (_crew select 0));
	_group deleteGroupWhenEmpty true;
	_group allowFleeing 0;

	// CIPHER COMMENT: May need to clear the crews previous waypoints
	_crew joinSilent _group;
	[_group,_createdVehicle] call KISKA_fnc_setCrew;
	[_group, BLWK_mainCrate, 20, "SAD", "AWARE", "RED"] call CBAP_fnc_addWaypoint;

	[BLWK_zeus, [[_createdVehicle],false]] remoteExecCall ["addCuratorEditableObjects",2];

	_returnedVehicles pushBack _createdVehicle
};


call _fn_spawnAVehicle;
// do a role for a second vehicle
private _howLikelyIsASecondVehicleToSpawn = _howLikelyIsAVehicleToSpawn / 2;
diag_log "second vehicle likelihood";
diag_log _howLikelyIsASecondVehicleToSpawn;
private _secondVehcileWillSpawn = selectRandomWeighted [true,_howLikelyIsASecondVehicleToSpawn,false,1 - _howLikelyIsASecondVehicleToSpawn];
if (_secondVehcileWillSpawn) then {
	call _fn_spawnAVehicle;
};


_returnedVehicles

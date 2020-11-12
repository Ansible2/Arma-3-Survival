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
if !(BLWK_currentWaveNumber >= BLWK_vehicleStartWave) exitWith {[]};

#define LIKELIHOOD_HEAVY_ARMOUR 0.10
#define LIKELIHOOD_LIGHT_ARMOUR 0.15
#define LIKELIHOOD_HEAVY_CAR 0.25
#define LIKELIHOOD_LIGHT_CAR 0.50
#define BASE_VEHICLE_SPAWN_LIKELIHOOD 0.25
#define VEHICLE_SPAWN_INCREMENT 0.05 // how much to increase likelihood by each round
#define ROUNDS_SINCE_MINUS_TWO(TOTAL_ROUNDS_SINCE) TOTAL_ROUNDS_SINCE - 2

params [
	"_availableInfantry",
	["_isDefectorWave",false,[true]]
];

if (!local BLWK_theAIHandlerEntity) exitWith {[]};

// special waves will not contribute to this count
private _roundsSinceVehicleSpawned = missionNamespace getVariable ["BLWK_roundsSinceVehicleSpawned",2];
// wait until it has been at least two rounds since a vehicle spawn to get another one
if (_roundsSinceVehicleSpawned <= 1) exitWith {
	BLWK_roundsSinceVehicleSpawned = _roundsSinceVehicleSpawned + 1;
	[]
};


// only the rounds after the two will contribute to the LIKELIHOOD percentage (5% per round, with a starting percentage of 35%)
private _howLikelyIsAVehicleToSpawn = (ROUNDS_SINCE_MINUS_TWO(_roundsSinceVehicleSpawned) * VEHICLE_SPAWN_INCREMENT) + BASE_VEHICLE_SPAWN_LIKELIHOOD;
private _howLikelyIsAVheicleNOTToSpawn = 1 - _howLikelyIsAVehicleToSpawn;

private _vehicleWillSpawn = selectRandomWeighted [true,_howLikelyIsAVehicleToSpawn,false,_howLikelyIsAVheicleNOTToSpawn];
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
	{
		// if the vehicle type is not empty
		if !(_x isEqualTo "") then {
			switch (_forEachIndex) do {
				case 0:{
					_lightCarsArray pushBack _x
				};
				case 1:{
					_heavyCarsArray pushBack _x
				};
				case 2:{
					_lightArmourArray pushBack _x
				};
				case 3:{
					_heavyArmourArray pushBack _x
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
	_vehicleTypeSelection append [_lightCarsArray,LIKELIHOOD_LIGHT_CAR];
};
if !(_heavyCarsArray isEqualTo []) then {
	_vehicleTypeSelection append [_heavyCarsArray,LIKELIHOOD_HEAVY_CAR];
};
if !(_lightArmourArray isEqualTo []) then {
	_vehicleTypeSelection append [_lightArmourArray,LIKELIHOOD_LIGHT_ARMOUR];
};
if !(_heavyArmourArray isEqualTo []) then {
	_vehicleTypeSelection append [_heavyArmourArray,LIKELIHOOD_HEAVY_ARMOUR];
};

private _returnedVehicles = [];
private _fn_spawnAVehicle = {
	private _selectedTypeArray = selectRandomWeighted _vehicleTypeSelection;
	private _selectedVehicleClass = selectRandom _selectedTypeArray;
	private _spawnPosition = selectRandom BLWK_vehicleSpawnPositions;
	private _createdVehicle = _selectedVehicleClass createVehicle _spawnPosition;

	_createdVehicle addMPEventHandler ["MPKILLED",{
		[_this,_thisEventHandler] call BLWK_fnc_stdVehicleKilledEvent;
	}];

	private _crew = _availableInfantry select [0,3];
	_availableInfantry deleteRange [0,3];

	private _group = createGroup (side (_crew select 0));
	_group deleteGroupWhenEmpty true;
	_group allowFleeing 0;

	// CIPHER COMMENT: May need to clear the crews previous waypoints
	_crew joinSilent _group;
	[_group,_createdVehicle] call BLWK_fnc_setCrew;
	[_group, bulwarkBox, 20, "SAD", "AWARE", "RED"] call CBAP_fnc_addWaypoint;

	[BLWK_zeus, [[_createdVehicle],false]] remoteExec ["addCuratorEditableObjects",2];

	_returnedVehicles pushBack _createdVehicle
};


call _fn_spawnAVehicle;
// do a role for a second vehicle
private _howLikelyIsASecondVehicleToSpawn = _howLikelyIsAVehicleToSpawn / 2;
private _secondVehcileWillSpawn = selectRandomWeighted [true,_howLikelyIsASecondVehicleToSpawn,false,1 - _howLikelyIsASecondVehicleToSpawn];
if (_secondVehcileWillSpawn) then {
	call _fn_spawnAVehicle;
};


_returnedVehicles

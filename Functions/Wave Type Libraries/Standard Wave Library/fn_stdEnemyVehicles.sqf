#define LIKELIHOOD_HEAVY_ARMOUR 0.10
#define LIKELIHOOD_LIGHT_ARMOUR 0.15
#define LIKELIHOOD_HEAVY_CAR 0.25
#define LIKELIHOOD_LIGHT_CAR 0.50
#define BASE_VEHICLE_SPAWN_LIKELIHOOD 0.10
#define VEHICLE_SPAWN_INCRIMENT 0.05
#define ROUNDS_SINCE_MINUS_TWO(TOTAL_ROUNDS_SINCE) TOTAL_ROUNDS_SINCE - 2 

params ["_availableInfantry"];

if (!local BLWK_theAIHandler) exitWith {false};

if !(BLWK_currentWaveNumber >= BLWK_vehicleStartWave) exitWith {false};

// special waves will not contriubute to this count
private _roundsSinceVehicleSpawned = missionNamespace getVariable ["BLWK_roundsSinceVehicleSpawned",2];
// wait until it has been at least two rounds since a vehicle spawn to get another one
if (_roundsSinceVehicleSpawned >= 2) exitWith {
	BLWK_roundsSinceVehicleSpawned = _roundsSinceVehicleSpawned + 1;
	false
};
	
// only the rounds after the two will contribute to the LIKELIHOOD percentage (5% per round, with a starting percentage of 10%)
private _howLikelyIsAVehicleToSpawn = (ROUNDS_SINCE_MINUS_TWO(_roundsSinceVehicleSpawned) * VEHICLE_SPAWN_INCRIMENT) + BASE_VEHICLE_SPAWN_LIKELIHOOD;
private _howLikelyIsAVheicleNOTToSpawn = 1 - _howLikelyIsAVehicleToSpawn;

private _vehcileWillSpawn = selectRandomWeighted [true,_howLikelyIsAVehicleToSpawn,false,_howLikelyIsAVheicleNOTToSpawn];
if !(_vehicleWillSpawn) exitWith {
	BLWK_roundsSinceVehicleSpawned = _roundsSinceVehicleSpawned + 1;
	false
};



missionNamespace setVariable ["BLWK_roundsSinceVehicleSpawned",0];
private _lightCarsArray = [];
private _heavyCarsArray = [];
private _lightArmourArray = [];
private _heavyArmourArray = [];
private _fn_checkLevelsClasses = {
	params ["_levelToCheck"];
	{
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
	} forEach _levelToCheck;
};

// get all available vehicle types depending on round
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

// get all available vehicle types
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
	
	private _group = createGroup (side (_crew select 0))
	_group deleteGroupWhenEmpty true;
	_group allowFleeing false;
	
	// CIPHER COMMENT: May need to clear the crews previous waypoints
	_crew joinSilent _group;
	[_group,_createdVehicle] call BLWK_fnc_setCrew;
	[_group, bulwarkBox, 20, "SAD", "AWARE", "RED"] call CBAP_fnc_addWaypoint;

	[BLWK_zeus, [[_createdVehicle],false]] remoteExec ["addCuratorEditableObjects",2];
};

call _fn_spawnAVehicle;

private _howLikelyIsASecondVehicleToSpawn = _howLikelyIsAVehicleToSpawn / 2;
private _secondVehcileWillSpawn = selectRandomWeighted [true,_howLikelyIsASecondVehicleToSpawn,false,1 - _howLikelyIsASecondVehicleToSpawn];
if (_secondVehcileWillSpawn) then {
	call _fn_spawnAVehicle;
};


true
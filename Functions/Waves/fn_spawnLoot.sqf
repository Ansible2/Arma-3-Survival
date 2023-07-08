/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnLoot

Description:
	Creates loot for a wave.

	It is executed from the "initServer.sqf".

Parameters:
	NONE

Returns:
	BOOL

Examples:
    (begin example)
		call BLWK_fnc_spawnLoot;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define RANDOM_WEAPON_BOX_CLASS "Land_WoodenBox_F"
#define SUPPORT_SATT_CLASS "Land_SatelliteAntenna_01_F"
#define MONEY_PILE_CLASS "Land_Money_F"
#define LOOT_REVEAL_BOX_CLASS "Box_C_UAV_06_Swifd_F"
#define LOOT_HOLDER_CLASS "GroundWeaponHolder_Scripted"
#define NUMBER_OF_IMPACTED_UNIQUES 2
#define MAX_SPAWNS_PLUS_UNIQUES (BLWK_maxLootSpawns + NUMBER_OF_IMPACTED_UNIQUES)
#define MAX_SPAWNS_MINUS_UNIQUES ((BLWK_maxLootSpawns - NUMBER_OF_IMPACTED_UNIQUES) max 0)
#define LOOT_HOLDER_Z_BUFFER 0.1

#define LOOT_TYPE_BACKPACK 0
#define LOOT_TYPE_WEAPONS 1
#define LOOT_TYPE_ITEMS 2
#define LOOT_TYPE_VESTS 3
#define LOOT_TYPE_UNIFORMS 4
#define LOOT_TYPE_EXPLOSIVES 5
#define LOOT_TYPE_MAGAZINES 6
#define LOOT_TYPE_HEADGEAR 7

if (!isServer) exitWith {false};


/* ----------------------------------------------------------------------------
	Delete Previous Loot Markers
---------------------------------------------------------------------------- */
BLWK_lootMarkers apply { deleteMarker _x };


/* ----------------------------------------------------------------------------
	Prepare Spawn Positions
---------------------------------------------------------------------------- */
// Add a bool variable to this in the future to check if the play area size changed
if (isNil "BLWK_playAreaBuildings" /*OR {playAreaSizeWasChanged}*/) then {
	// get ALL buildings in area
	private _buildingsInPlayArea = nearestTerrainObjects [
		BLWK_playAreaCenter,
		["House"], 
		BLWK_playAreaRadius, 
		false, 
		true
	];

	// make sure the building has configed positions to spawn stuff at
	BLWK_playAreaBuildings = _buildingsInPlayArea select {
		private _allBuildingPositions = _x buildingPos -1;
		(_allBuildingPositions isNotEqualTo [])
	};

	//playAreaSizeWasChanged = false;
};

// randomize buildings because the forEach loop below will be the same every time then
// shuffles array in place
[BLWK_playAreaBuildings,true] call CBAP_fnc_shuffle;


/* ----------------------------------------------------------------------------
	Sort through all available buildings and positions
---------------------------------------------------------------------------- */
private _sortedPositions = [];
private _exit = false;
{
	if (_exit) then { break };

	private _currentBuilding = _x;
	private _buildingIndex = _forEachIndex;
	// to distribute to every building, every other building, every 3rd, etc.
	if ((_buildingIndex mod BLWK_loot_cityDistribution) isNotEqualTo 0) then { continue };

	private _buildingsPositions = _currentBuilding buildingPos -1;
	{
		if (count _sortedPositions >= MAX_SPAWNS_PLUS_UNIQUES) then {
			_exit = true; 
			break;
		};

		private _positionMatchesBuildingLootDistribution = (_forEachIndex mod BLWK_loot_roomDistribution) isEqualTo 0;
		private _isFirstPositionInBuilding = _forEachIndex isEqualTo 0;
		if (_isFirstPositionInBuilding OR _positionMatchesBuildingLootDistribution) then {
			// mitigate loot from sometimes being in the ground
			private _buildingPositionWithHeightIncrease = _x vectorAdd [0,0,LOOT_HOLDER_Z_BUFFER];
			_sortedPositions pushBack (AGLToASL _buildingPositionWithHeightIncrease);
		};
	} forEach _buildingsPositions;
	
} forEach BLWK_playAreaBuildings;

// if there are less available positions in the area then the max allowed, just readjust
private _positionsCount = count _sortedPositions;
if (_positionsCount < MAX_SPAWNS_PLUS_UNIQUES) then {
	BLWK_maxLootSpawns = _positionsCount;
};


/* ----------------------------------------------------------------------------
	Prepare BLWK_lootHolders (make sure the count is still proper)
---------------------------------------------------------------------------- */
if (isNil "BLWK_lootHolders") then {
	BLWK_lootHolders = [];
};
// just in case a holder was deleted
BLWK_lootHolders = BLWK_lootHolders select {
	!(isNull _x)
};

private _addToZeusArray = [];

private _lootHolderCount = count BLWK_lootHolders;
private _numberOfOptionalSpawnPositions = MAX_SPAWNS_MINUS_UNIQUES;
if (_lootHolderCount isNotEqualTo _numberOfOptionalSpawnPositions) then {

	if (_lootHolderCount < _numberOfOptionalSpawnPositions) then {
		for "_i" from 1 to (_numberOfOptionalSpawnPositions - _lootHolderCount) do {
			["Found need for loot holder, adding...",false] call KISKA_fnc_log;
			private _holder = createVehicle [LOOT_HOLDER_CLASS, [0,0,1000], [], 0, "FLY"];
			_holder allowDamage false;

			BLWK_lootHolders pushBack _holder;
			_addToZeusArray pushBack _holder;
		};

	} else {
		for "_i" from 1 to (_lootHolderCount - _numberOfOptionalSpawnPositions) do {
			["Found excess loot holder, deleteing...",false] call KISKA_fnc_log;
			private _holder = BLWK_lootHolders deleteAt 0;
			deleteVehicle _holder;
		};

	};

};



private _fn_getASpawnPosition = {

	private _spawnPosition = selectRandom _sortedPositions;
	private _positionIndex = _sortedPositions find _spawnPosition;
	// delete so we don't get repeat spawns
	_sortedPositions deleteAt _positionIndex;


	_spawnPosition
};



/* ----------------------------------------------------------------------------

	Unique Items

---------------------------------------------------------------------------- */

/* ----------------------------------------------------------------------------
	Loot Reveal Box
---------------------------------------------------------------------------- */
// these are global for future endeavors
if (!(isNil "BLWK_lootRevealerBox") AND {!(isNull BLWK_lootRevealerBox)}) then {
	deleteVehicle BLWK_lootRevealerBox;
};
BLWK_lootRevealerBox = createVehicle [LOOT_REVEAL_BOX_CLASS, ASLToATL (call _fn_getASpawnPosition), [], 0, "CAN_COLLIDE"];
BLWK_lootRevealerBox allowDamage false;

publicVariable "BLWK_lootRevealerBox";
_addToZeusArray pushBack BLWK_lootRevealerBox;

[BLWK_lootRevealerBox] remoteExec ["BLWK_fnc_addRevealLootAction",BLWK_allClientsTargetID,BLWK_lootRevealerBox];


/* ----------------------------------------------------------------------------
	Support Unlock Dish
---------------------------------------------------------------------------- */
if (!BLWK_supportDishFound) then {
	if (!(isNil "BLWK_supportDish") AND {!(isNull BLWK_supportDish)}) then {
		deleteVehicle BLWK_supportDish;
	};

	BLWK_supportDish = createVehicle [SUPPORT_SATT_CLASS, ASLToATL (selectRandom _sortedPositions), [], 0, "CAN_COLLIDE"];
	publicVariable "BLWK_supportDish";
	BLWK_supportDish allowDamage false;
	_addToZeusArray pushBack BLWK_supportDish;

	[BLWK_supportDish] remoteExecCall ["BLWK_fnc_addUnlockSupportAction",BLWK_allClientsTargetID,BLWK_supportDish];
};


/* ----------------------------------------------------------------------------
	Random Weapon Box
---------------------------------------------------------------------------- */
if !(missionNamespace getVariable ["BLWK_randomWeaponBoxFound",false]) then {
	if (!(isNil "BLWK_randomWeaponBox") AND {!(isNull BLWK_randomWeaponBox)}) then {
		deleteVehicle BLWK_randomWeaponBox;
	};

	BLWK_randomWeaponBox = createVehicle [RANDOM_WEAPON_BOX_CLASS, ASLToATL (selectRandom _sortedPositions), [], 4, "NONE"];
	BLWK_randomWeaponBox allowDamage false;
	publicVariable "BLWK_randomWeaponBox";
	_addToZeusArray pushBack BLWK_randomWeaponBox;

	[BLWK_randomWeaponBox] remoteExecCall ["BLWK_fnc_addBuildableObjectActions",BLWK_allClientsTargetID,true];
	[BLWK_randomWeaponBox] remoteExecCall ["BLWK_fnc_addWeaponBoxSpinAction",BLWK_allClientsTargetID,true];
};


/* ----------------------------------------------------------------------------
	Money Pile
---------------------------------------------------------------------------- */
if (!(isNil "BLWK_moneyPile") AND {!(isNull BLWK_moneyPile)}) then {
	deleteVehicle BLWK_moneyPile;
};

BLWK_moneyPile = createVehicle [MONEY_PILE_CLASS, ASLToATL (call _fn_getASpawnPosition), [], 0, "CAN_COLLIDE"];
publicVariable "BLWK_moneyPile";
BLWK_moneyPile allowDamage false;
_addToZeusArray pushBack BLWK_moneyPile;

[BLWK_moneyPile] remoteExecCall ["BLWK_fnc_addMoneyPileAction",BLWK_allClientsTargetID,BLWK_moneyPile];



/* ----------------------------------------------------------------------------

	Everything else

---------------------------------------------------------------------------- */
private _fn_findAMagazine = {
	params ["_weaponClass"];

	private _magArray = [configFile >> "CfgWeapons" >> _weaponClass >> "magazines"] call BIS_fnc_getCfgDataArray;
	// if no mags are found
	if (_magArray isEqualTo []) exitWith {""};

	_magArray = [_magArray] call CBAP_fnc_shuffle;

	private _index = _magArray findIf {
		!((toLowerANSI _x) in BLWK_lootBlacklist)
	};

	// if a mag is found
	if (_index != -1) then {
		_magArray select _index
	} else { // if a mag is not found
		""
	};
};

private _lootTypeWeights = [
	LOOT_TYPE_BACKPACK,localNamespace getVariable ["BLWK_lootWeight_backpack",1],
	LOOT_TYPE_EXPLOSIVES,localNamespace getVariable ["BLWK_lootWeight_explosives",1],
	LOOT_TYPE_HEADGEAR,localNamespace getVariable ["BLWK_lootWeight_headgear",1],
	LOOT_TYPE_ITEMS,localNamespace getVariable ["BLWK_lootWeight_items",1],
	LOOT_TYPE_MAGAZINES,localNamespace getVariable ["BLWK_lootWeight_magazines",1],
	LOOT_TYPE_UNIFORMS,localNamespace getVariable ["BLWK_lootWeight_uniforms",1],
	LOOT_TYPE_VESTS,localNamespace getVariable ["BLWK_lootWeight_vests",1],
	// selectRandomWeighted requires at least one weigh be above zero
	LOOT_TYPE_WEAPONS,(localNamespace getVariable ["BLWK_lootWeight_weapons",1]) max 1 
];

private _fn_addLoot = {
	params ["_holder"];

	clearWeaponCargoGlobal _holder;
	clearMagazineCargoGlobal _holder;
	clearItemCargoGlobal _holder;
	clearBackpackCargoGlobal _holder;

	private _typeToSpawn = selectRandomWeighted _lootTypeWeights;

	private ["_selectedItemClass","_magazineClass"];

	if (_typeToSpawn isEqualTo LOOT_TYPE_BACKPACK) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_backpackClasses;
		_holder addBackpackCargoGlobal [_selectedItemClass,1];

		_selectedItemClass
	};

	if (_typeToSpawn isEqualTo LOOT_TYPE_VESTS) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_vestClasses;
		_holder addItemCargoGlobal [_selectedItemClass,1];

		_selectedItemClass
	};

	if (_typeToSpawn isEqualTo LOOT_TYPE_UNIFORMS) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_uniformClasses;
		_holder addItemCargoGlobal [_selectedItemClass,1];

		_selectedItemClass
	};

	if (_typeToSpawn isEqualTo LOOT_TYPE_ITEMS) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_itemClasses;
		_holder addItemCargoGlobal [_selectedItemClass,1];

		_selectedItemClass
	};
	
	if (_typeToSpawn isEqualTo LOOT_TYPE_EXPLOSIVES) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_explosiveClasses;
		_holder addMagazineCargoGlobal [_selectedItemClass,round random [1,2,3]];

		_selectedItemClass
	};

	if (_typeToSpawn isEqualTo LOOT_TYPE_WEAPONS) exitWith { // there are three numbers here to encourage more weapon spawns
		_selectedItemClass = selectRandom BLWK_loot_weaponClasses;
		_holder addWeaponCargoGlobal [_selectedItemClass,1];

		_magazineClass = [_selectedItemClass] call _fn_findAMagazine;
		// if weapon has mags capable of spawning
		if (_magazineClass != "") then {
			_holder addMagazineCargoGlobal [_magazineClass,round random [1,2,3]];
		};

		_selectedItemClass
	};

	if (_typeToSpawn isEqualTo LOOT_TYPE_MAGAZINES) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_weaponClasses;
		_magazineClass = [_selectedItemClass] call _fn_findAMagazine;
		// if weapon has mags capable of spawning
		if (_magazineClass isNotEqualTo "") then {
			_holder addMagazineCargoGlobal [_magazineClass,round random [1,2,3]];
		};

		_magazineClass
	};

	if (_typeToSpawn isEqualTo LOOT_TYPE_HEADGEAR) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_headGearClasses;
		_holder addItemCargoGlobal [_selectedItemClass,1];

		_selectedItemClass
	};
};

BLWK_lootHolders apply {
	_x setPosASL (call _fn_getASpawnPosition);

	private _primaryLootClass = [_x] call _fn_addLoot;
	// used for displaying loot markers in BLWK_fnc_createLootMarkers
	_x setVariable ["BLWK_primaryLootClass",_primaryLootClass];

};

BLWK_zeus addCuratorEditableObjects [_addToZeusArray,true];


true

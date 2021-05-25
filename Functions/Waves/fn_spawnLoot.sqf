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
#define MAX_SPAWNS_MINUS_UNIQUES (BLWK_maxLootSpawns - NUMBER_OF_IMPACTED_UNIQUES)
#define LOOT_HOLDER_Z_BUFFER 0.1

if (!isServer) exitWith {false};


/* ----------------------------------------------------------------------------
	Delete Previous Loot Markers
---------------------------------------------------------------------------- */
if !((missionNamespace getVariable ["BLWK_lootMarkers",[]]) isEqualTo []) then {
	BLWK_lootMarkers apply {
		deleteMarker _x;
	};
};


/* ----------------------------------------------------------------------------
	Prepare Spawn Positions
---------------------------------------------------------------------------- */
// Add a bool variable to this in the future to check if the play area size changed
if (isNil "BLWK_playAreaBuildings" /*OR {playAreaSizeWasChanged}*/) then {
	// get ALL buildings in area
	private _buildingsInPlayArea = nearestTerrainObjects [BLWK_playAreaCenter,["House"], BLWK_playAreaRadius, false, true];

	// make sure the building has configed positions to spawn stuff at
	BLWK_playAreaBuildings = _buildingsInPlayArea select {
		((_x buildingPos -1) isNotEqualTo [])
	};

	BLWK_playAreaBuildings = [BLWK_playAreaBuildings,true] call CBAP_fnc_shuffle;
	//playAreaSizeWasChanged = false;
} else {
	// randomize buildings because the forEach loop below will be the same every time then
	BLWK_playAreaBuildings = [BLWK_playAreaBuildings,true] call CBAP_fnc_shuffle;
};



/* ----------------------------------------------------------------------------
	Sort through all available buildings and positions
---------------------------------------------------------------------------- */
private _sortedPositions = [];
private _exit = false;
{
	if (_exit) then {break};

	private _currentBuilding = _x;
	private _buildingIndex = _forEachIndex;
	// to distribute to every building, every other building, every 3rd, etc.
	if ((_buildingIndex mod BLWK_loot_cityDistribution) isEqualTo 0) then {
		private _buildingsPositions = _currentBuilding buildingPos -1;

		{
			if (count _sortedPositions >= MAX_SPAWNS_PLUS_UNIQUES) then {_exit = true; break};

			if (_forEachIndex isEqualTo 0 OR {(_forEachIndex mod BLWK_loot_roomDistribution) isEqualTo 0}) then {
				_sortedPositions pushBack (_x vectorAdd [0,0,LOOT_HOLDER_Z_BUFFER]);
			};
		} forEach _buildingsPositions;
	};
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
if (_lootHolderCount isNotEqualTo MAX_SPAWNS_MINUS_UNIQUES) then {

	if (_lootHolderCount < MAX_SPAWNS_MINUS_UNIQUES) then {
		for "_i" from 1 to (MAX_SPAWNS_MINUS_UNIQUES - _lootHolderCount) do {
			["Found need for loot holder, adding...",false] call KISKA_fnc_log;
			private _holder = createVehicle [LOOT_HOLDER_CLASS, [0,0,1000], [], 0, "FLY"];
			_holder allowDamage false;

			BLWK_lootHolders pushBack _holder;
			_addToZeusArray pushBack _holder;
		};

	} else {
		for "_i" from 1 to (_lootHolderCount - MAX_SPAWNS_MINUS_UNIQUES) do {
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
BLWK_lootRevealerBox = createVehicle [LOOT_REVEAL_BOX_CLASS, call _fn_getASpawnPosition, [], 0, "CAN_COLLIDE"];
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

	BLWK_supportDish = createVehicle [SUPPORT_SATT_CLASS, selectRandom _sortedPositions, [], 0, "CAN_COLLIDE"];
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

	BLWK_randomWeaponBox = createVehicle [RANDOM_WEAPON_BOX_CLASS, selectRandom _sortedPositions, [], 4, "NONE"];
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

BLWK_moneyPile = createVehicle [MONEY_PILE_CLASS, call _fn_getASpawnPosition, [], 0, "CAN_COLLIDE"];
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

private _fn_addLoot = {
	params ["_holder"];

	clearWeaponCargoGlobal _holder;
	clearMagazineCargoGlobal _holder;
	clearItemCargoGlobal _holder;
	clearBackpackCargoGlobal _holder;

	private _typeToSpawn = round random 9;

	private ["_selectedItemClass","_magazineClass"];
	// backpack
	if (_typeToSpawn isEqualTo 0) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_backpackClasses;
		_holder addBackpackCargoGlobal [_selectedItemClass,1];

		_selectedItemClass
	};
	// vest
	if (_typeToSpawn isEqualTo 1) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_vestClasses;
		_holder addItemCargoGlobal [_selectedItemClass,1];

		_selectedItemClass
	};
	// uniforms
	if (_typeToSpawn isEqualTo 2) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_uniformClasses;
		_holder addItemCargoGlobal [_selectedItemClass,1];

		_selectedItemClass
	};
	// items
	if (_typeToSpawn isEqualTo 3) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_itemClasses;
		_holder addItemCargoGlobal [_selectedItemClass,1];

		_selectedItemClass
	};
	// explosives
	if (_typeToSpawn isEqualTo 4) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_explosiveClasses;
		_holder addMagazineCargoGlobal [_selectedItemClass,round random [1,2,3]];

		_selectedItemClass
	};
	// weapons
	if (_typeToSpawn isEqualTo 5 OR {_typeToSpawn isEqualTo 8} OR {_typeToSpawn isEqualTo 9}) exitWith { // there are three numbers here to encourage more weapon spawns
		_selectedItemClass = selectRandom BLWK_loot_weaponClasses;
		_holder addWeaponCargoGlobal [_selectedItemClass,1];

		_magazineClass = [_selectedItemClass] call _fn_findAMagazine;
		// if weapon has mags capable of spawning
		if (_magazineClass != "") then {
			_holder addMagazineCargoGlobal [_magazineClass,round random [1,2,3]];
		};

		_selectedItemClass
	};
	// magazines
	if (_typeToSpawn isEqualTo 6) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_weaponClasses;
		_magazineClass = [_selectedItemClass] call _fn_findAMagazine;
		// if weapon has mags capable of spawning
		if (_magazineClass != "") then {
			_holder addMagazineCargoGlobal [_magazineClass,round random [1,2,3]];
		};

		_magazineClass
	};
	// headgear
	if (_typeToSpawn isEqualTo 7) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_headGearClasses;
		_holder addItemCargoGlobal [_selectedItemClass,1];

		_selectedItemClass
	};
};

BLWK_lootHolders apply {
	_x setPos (call _fn_getASpawnPosition);

	private _primaryLootClass = [_x] call _fn_addLoot;
	// used for displaying loot markers in BLWK_fnc_createLootMarkers
	_x setVariable ["BLWK_primaryLootClass",_primaryLootClass];

};

BLWK_zeus addCuratorEditableObjects [_addToZeusArray,true];


true

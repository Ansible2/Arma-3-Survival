/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnLoot

Description:
	Creates loot for a wave
	
	It is executed from the "initServer.sqf".
	
Parameters:
	NONE

Returns:
	Nothing

Examples:
    (begin example)

		call BLWK_fnc_spawnLoot;

    (end)
---------------------------------------------------------------------------- */
//////////////////////////////////////////////////////////////////////////////////
///////////////////////////Prepare Spawn Positions////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

// get ALL buildings in area
private _buildingsInPlayArea = BLWK_playAreaCenter nearObjects ["House", BLWK_playAreaRadius];
// sort buildings that actually have cfg positions to spawn stuff
// AND those that are NOT built by players
//// this is done every wave because buildings are destroyed and can have different models and therefore positions
BLWK_playAreaBuildings = _buildingsInPlayArea select {
	!((_x buildingPos -1) isEqualTo []) AND
	{!(_x getVariable ["BLWK_isABuiltObject",false])}
};


private _buildings = BLWK_playAreaBuildings;
// sort through all available buildings and positions
// to distribute to every building, every other building, every 3rd, etc.
private _sortedPositions = [];
{
	private _currentBuilding = _x;
	private _buildingIndex = _forEachIndex;

	if ((_buildingIndex mod BLWK_loot_cityDistribution) isEqualTo 0) then {
		private _buildingsPositions = _currentBuilding buildingPos -1;
		
		{
			if ((_forEachIndex mod BLWK_loot_distributionInBuildings) isEqualTo 0) then {
				_sortedPositions pushBack _x
			};
		} forEach _buildingsPositions;
	};
} forEach _buildings;


private _fn_getASpawnPosition = {
	private _spawnPosition = selectRandom _sortedPositions;
	_positionIndex = _sortedPositions findIf {_x isEqualTo _spawnPosition};
	// delete so we don't get repeat spawns
	_sortedPositions deleteRange [_positionIndex,_positionIndex + 1];

	_spawnPosition
};


private _addToZeusArray = [];

//////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////Unique Items///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

// LOOT REVEAL BOX
// these are global for future endeavors
BLWK_lootRevealerBox = createVehicle ["Box_C_UAV_06_Swifd_F", (call _fn_getASpawnPosition), [], 0, "CAN_COLLIDE"];
publicVariable "BLWK_lootRevealerBox";
_addToZeusArray pushBack BLWK_lootRevealerBox;

[BLWK_lootRevealerBox] remoteExec ["BLWK_fnc_addRevealLootAction",BLWK_allPlayersTargetID,true];
// add to list to for cleanup
BLWK_spawnedLoot pushBack BLWK_lootRevealerBox;


// SUPPORT UNLOCK DISH
if (!BLWK_supportDishFound) then {
	BLWK_supportDish = createVehicle ["Land_SatelliteAntenna_01_F", (call _fn_getASpawnPosition), [], 0, "CAN_COLLIDE"];
	publicVariable "BLWK_supportDish";
	BLWK_supportDish allowDamage false;
	_addToZeusArray pushBack BLWK_supportDish;

	[BLWK_supportDish] remoteExec ["BLWK_fnc_addUnlockSupportAction",BLWK_allPlayersTargetID,true];
	BLWK_spawnedLoot pushBack BLWK_supportDish;
};

// RANDOM WEAPON BOX
if (!BLWK_randomWeaponBoxFound) then {
	BLWK_randomWeaponBox = createVehicle ["Land_WoodenBox_F", (call _fn_getASpawnPosition), [], 4];
	publicVariable "BLWK_randomWeaponBox";
	BLWK_randomWeaponBox allowDamage false;
	_addToZeusArray pushBack BLWK_randomWeaponBox;

	[BLWK_randomWeaponBox] remoteExec ["BLWK_fnc_addBuildObjectActions",BLWK_allPlayersTargetID,true];
	BLWK_spawnedLoot pushBack BLWK_randomWeaponBox;
};

// MONEY PILE
BLWK_moneyPile = createVehicle ["Box_C_UAV_06_Swifd_F", (call _fn_getASpawnPosition), [], 0, "CAN_COLLIDE"];
publicVariable "BLWK_moneyPile";
BLWK_moneyPile allowDamage false;
_addToZeusArray pushBack BLWK_moneyPile;

[BLWK_moneyPile] remoteExec ["BLWK_fnc_addMoneyPileAction",BLWK_allPlayersTargetID,true];
BLWK_spawnedLoot pushBack BLWK_moneyPile;

// CIPHER COMMENT:
// items should probably never repeat themselves in a round
// things such as compasses and GPSs will be annoying to find often, but, givent the amount of randomization
// it may not be needed actually
//////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////Everything else////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
private _fn_addLoot = {
	params ["_holder"];
	
	private _typeToSpawn = round random 6;
	
	private "_selectedItemClass";
	// backpack
	if (_typeToSpawn isEqualTo 0) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_backpackClasses;
		_holder addBackpackCargoGlobal [_selectedItemClass,1];
	};
	// vest
	if (_typeToSpawn isEqualTo 1) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_vestClasses;
		_holder addItemCargoGlobal [_selectedItemClass,1]; 
	};
	// clothes
	if (_typeToSpawn isEqualTo 2) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_clothingClasses;
		_holder addItemCargoGlobal [_selectedItemClass,1]; 
	};
	// items
	if (_typeToSpawn isEqualTo 3) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_itemClasses;
		_holder addItemCargoGlobal [_selectedItemClass,1]; 
	};
	// explosives
	if (_typeToSpawn isEqualTo 4) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_explosiveClasses;
		_holder addMagazineCargoGlobal [_selectedItemClass,round random [1,2,3]]; 
	};
	// weapons
	if (_typeToSpawn isEqualTo 5) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_weaponClasses;
		private _magazineClass = selectRandom (getArray (configFile >> "CfgWeapons" >> _selectedItemClass >> "magazines"));
		_holder addWeaponCargoGlobal [_selectedItemClass,1];
		_holder addMagazineCargoGlobal [_magazineClass,round random [1,2,3]];  
	};
	// magazines
	if (_typeToSpawn isEqualTo 6) exitWith {
		_selectedItemClass = selectRandom BLWK_loot_weaponClasses;
		private _magazineClass = selectRandom (getArray (configFile >> "CfgWeapons" >> _selectedItemClass >> "magazines"));
		_holder addMagazineCargoGlobal [_magazineClass,round random [1,2,3]]; 
	};
};


_sortedPositions apply {
	// in order to spawn stuff like weapons on the ground, we create holders
	// CIPHER COMMENT: See if this is needed
	private _spawnPosition = _x vectorAdd [0,0,0.1];

	private _holder = createVehicle ["WeaponHolderSimulated_Scripted", _position, [], 0, "CAN_COLLIDE"];
	[_holder] call _fn_addLoot;
	
	_addToZeusArray pushBack _holder;
	BLWK_spawnedLoot pushBack _holder;
};

BLWK_zeus addCuratorEditableObjects [_addToZeusArray, true];
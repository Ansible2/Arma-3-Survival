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

BLWK_loot_backpackClasses
BLWK_loot_explosiveClasses
BLWK_loot_itemClasses
BLWK_loot_clothingClasses
BLWK_loot_vestClasses
BLWK_loot_weaponClasses

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
//private _numberOfBuildings = count _buildings;

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
// loot revealer spawn
// need a function for reveal loot
// this is a global for future endeavors
BLWK_lootRevealerBox = createVehicle ["Box_C_UAV_06_Swifd_F", (call _fn_getASpawnPosition), [], 0, "CAN_COLLIDE"];
_addToZeusArray pushBack BLWK_lootRevealerBox;














BLWK_zeus addCuratorEditableObjects [_addToZeusArray, true];
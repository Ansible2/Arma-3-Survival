/* ----------------------------------------------------------------------------
Function: BLWK_fnc_selectPlayArea

Description:
	Searches through a maps's locations for a suitable 
	 play area that is within the player's parameters.

	Will end mission if none exist.

	Executed from "BLWK_fnc_preparePlayArea"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_selectPlayArea;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer OR {!canSuspend}) exitWith {};

// get all location positions on the map and shuffle them
private _shuffledLocations = [BLWK_locations,false] call CBAP_fnc_shuffle;
private _mapLocationPositions = [];
_shuffledLocations apply {
	_mapLocationPositions pushBack (locationPosition _x);
};


private _isSuitable = false;
private _locationPosition = [0,0,0];
private _return = [];
private _positionChosen = [0,0,0];
private _buildingsNearLocation = [];
private _buildingsNearLocationShuffled = [];
private _playAreaBuildings = [];

private _fn_selectBuildings = {
	params ["_positionToCheck","_checkDouble"];
	private _multiplier = [1,2] select _checkDouble;

	_return = (_positionToCheck nearObjects ["House", BLWK_playAreaRadius * _multiplier]) select {
		// check that the building has cfg building positions to spawn stuff
		!((_x buildingPos -1) isEqualTo []) AND 
		// And check that it doesn't have water directly beneath it (avoid being too far out on a dock)
		{!(	surfaceIsWater (((lineIntersectsSurfaces [AGLToASL(_x buildingPos 0),AGLToASL(_x buildingPos 0) vectorDiff [0,0,20]]) select 0) select 0))}
	};

	_return
};
private _fn_checkLocation = {
	_locationPosition = _this select 0;

	// get all buildings in play area * 2
	_buildingsNearLocation = [_locationPosition,true] call _fn_selectBuildings;
	
	// check if there are even enough buildings in that double the radius
	if (count _buildingsNearLocation >= BLWK_minNumberOfHousesInArea) then {

		// nearObjects is not totally random, so we shuffle
		_buildingsNearLocationShuffled = [_buildingsNearLocation,false] call CBA_fnc_shuffle;


		// cycle through all buildings near the location which is within (BLWK_playAreaRadius * 2)
		_buildingsNearLocationShuffled findIf {
			// get all the building's positions
			_buildingsPositions = _x buildingPos -1;

			// at the current building, check if there are enough within the radius to satisfy BLWK_minNumberOfHousesInArea
			_playAreaBuildings = [_buildingsPositions select 0,false] call _fn_selectBuildings;

			if (count _playAreaBuildings >= BLWK_minNumberOfHousesInArea) then {
				_positionChosen = selectRandom _buildingsPositions;
				_isSuitable = true;
			};

		};
	};

	_isSuitable
};

// actually loop through the locations
_mapLocationPositions findIf {
	[_x] call _fn_checkLocation
};


// exit if nothing found
if (_mapLocationPositions isEqualTo -1)  exitWith {
	["No locations on map are within your selection parameters for building numbers"] remoteExecCall ["hint",0,true];

	sleep 10;

	call BIS_fnc_endMissionServer;
} else {

sleep 1;

BLWK_playAreaCenter = _positionChosen;
publicVariable "BLWK_playAreaCenter";

};
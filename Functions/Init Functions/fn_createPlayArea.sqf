if (!isServer) exitWith {};

// get all location positions on map and shuffle
private _mapLocations = nearestlocations [[0,0,0],["nameVillage","nameCity","nameCityCapital","nameMarine"/*,"nameLocal"*/,"Airport"],worldsize * sqrt 2]; 
private _shuffledLocations = [_mapLocations,false] call CBAP_fnc_shuffle;
private _mapLocationPositions = [];
_shuffledLocations apply {
	_mapLocationPositions pushBack (locationPosition _x);
};

_isSuitable = false;
_positionChosen = [];
_mapLocationPositions findIf {
	_location = _x;

	_buildingsInArea = _location nearObjects ["House", BLWK_playAreaRadius * 2];

	if (count _buildingsInArea >= BLWK_minNumberOfHousesInArea) then {
		_buildingsInArea findIf {
			_buildingsPositions = _x buildingPos -1;
			if !(_buildingsPositions isEqualTo []) then {
				_buildingsInTempRadius = (_buildingsPositions select 0) nearObjects ["House", BLWK_playAreaRadius];

				if (count _buildingsInTempRadius >= BLWK_minNumberOfHousesInArea) then {
					//check volume crap
					_positionChosen = _buildingsPositions select 0;
					_isSuitable = true;
				};
			};
		};
	};

	_isSuitable
};












// nearObjects does need some kind of randomization, it will return the same order every time

private _mapLocations = nearestlocations [[0,0,0],["nameVillage","nameCity","nameCityCapital","nameMarine","Airport"],worldsize * sqrt 2]; 
private _shuffledLocations = [_mapLocations,false] call CBA_fnc_shuffle;
private _mapLocationPositions = [];
_shuffledLocations apply {
	_mapLocationPositions pushBack (locationPosition _x);
};

_isSuitable = false;
_positionChosen = [];
_buildingsInArea = [];
_buildingsInTempRadius = [];
_mapLocationPositions findIf {
	_location = _x;

	_buildingsInArea = (_location nearObjects ["House", 250 * 2]) select {
		!((_x buildingPos -1) isEqualTo []) AND 
		{!(
			surfaceIsWater (((lineIntersectsSurfaces [AGLToASL(_x buildingPos 0),AGLToASL(_x buildingPos 0) vectorDiff [0,0,20]]) select 0) select 0)
		)}
		
		};

	if (count _buildingsInArea >= 10) then {
		_buildingsInArea findIf {
			_buildingsPositions = _x buildingPos -1;

			_buildingsInTempRadius = ((_buildingsPositions select 0) nearObjects ["House", 250]) select {
			!((_x buildingPos -1) isEqualTo []) AND 
			{!(
				surfaceIsWater (((lineIntersectsSurfaces [AGLToASL(_x buildingPos 0),AGLToASL(_x buildingPos 0) vectorDiff [0,0,20]]) select 0) select 0)
			)}
			
			};

			if (count _buildingsInTempRadius >= 10) then {
				//check volume crap
				_positionChosen = _buildingsPositions select 0;
				_isSuitable = true;
			};

		};
	};

	_isSuitable
};

player setPosATL _positionChosen;

private _marker1 = createMarker [(str theCount), _positionChosen];
_marker1 setMarkerShape "ELLIPSE";
_marker1 setMarkerSize [250, 250];
_marker1 setMarkerColor "ColorWhite";

(_buildingsInTempRadius) apply {
_markerName = "marker" + (str theCount);
    _marker = createMarker [_markerName, getpos _x];
  _marker setMarkerType "hd_dot";
theCount = theCount + 1;
};




















/*
1. Get all locations on map
2. get all the positions of these locations
4. Shuffle these positions
5. On the first position:
	- check if within the BLWK_playArea * 2 that there are enough buildings
	- find a building in that area
	- search the BLWK_playAreaRadius to see if there are enough buildings around the center buildingPos
5. get the

*/



private ["_location","_buildingsInArea","_currentBuilding","_isSuitable"];

_mapLocationPositions findIf {
	_location = _x;

	_buildingsInArea = _location nearObjects ["House", BLWK_playAreaRadius];

	if (count _buildingsInArea >= BLWK_minNumberOfHousesInArea) then {
		_buildingsInArea findIf {
			if !((_x buildingPos -1) isEqualTo []) then {

			};	
		};
		_isSuitable
	} else {
		false
	};
};


BLWK_minNumberOfHousesInArea

_buildingsInPlayArea = [BLWK_playAreaCenter, ["house"], 300];








private _marker1 = createMarker ["Mission Area", BLWK_playAreaCenter];
_marker1 setMarkerShape "ELLIPSE";
_marker1 setMarkerSize [BLWK_playAreaRadius, BLWK_playAreaRadius];
_marker1 setMarkerColor "ColorWhite";
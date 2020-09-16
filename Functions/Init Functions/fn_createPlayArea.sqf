if (!isServer) exitWith {};

private _mapLocations = nearestlocations [[0,0,0],["nameVillage","nameCity","nameCityCapital","Airport"],worldsize * sqrt 2]; 
private _shuffledLocations = [_mapLocations,false] call CBAP_fnc_shuffle;
private _mapLocationPositions = [];
_shuffledLocations apply {
	_mapLocationPositions pushBack (locationPosition _x);
};



private ["_location","_buildingsInArea","_currentBuilding","_isSuitable"];

_mapLocationPositions findIf {
	_location = _x;

	_buildingsInArea = _location nearObjects ["House", BLWK_playAreaRadius];

	if (count _buildingsInArea >= BLWK_minNumberOfHousesInArea) then {
		_buildingsInArea findIf {
			_currentBuilding = _x;

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
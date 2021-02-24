/* ----------------------------------------------------------------------------
Function: BLWK_fnc_selectCustomPlayArea

Description:
	Adds the eventhandlers that allow a host or admin to select a cutom spot on
	 the map to play in.

	Executed from "BLWK_fnc_selectPlayArea"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		[] spawn BLWK_fnc_selectCustomPlayArea;
    (end)

Author(s):
	Ansible2 // Cipher,
	Hilltop(Willtop) & omNomios
---------------------------------------------------------------------------- */
#define M_KEY_CODE 50
#define REQ_NUMBER_OF_LOOT_POSITIONS 6
#define MAIN_DISPLAY (findDisplay 46)

disableSerialization;

waituntil {!isNull MAIN_DISPLAY};

openMap true;

hint "Just click on the map to select a custom area. Press ctrl+M to initiate the mission with an area selected.";

BLWK_customAreaDisplayEH = MAIN_DISPLAY displayAddEventHandler ["KeyDown",{
	// if the pressed keys are ctrl+M
	private _keysPressed = ((_this select 1) isEqualTo M_KEY_CODE) AND {_this select 3};
	if (_keysPressed AND {call BLWK_fnc_checkLocation}) then {
		openMap false;
		
		// display 46 is not always active and therefore need to wait for it to be in a scheduled environment
		[] spawn {
			waituntil {!isNull MAIN_DISPLAY};
			
			MAIN_DISPLAY displayRemoveEventHandler ["KeyDown",BLWK_customAreaDisplayEH];
			missionNamespace setVariable ["BLWK_customAreaDisplayEH",nil];
		};
		removeMissionEventHandler ["MapSingleClick",BLWK_customPlayAreaMapEH];
		
		// transmit position to server
		missionNamespace setVariable ["BLWK_playAreaCenter",BLWK_missionAreaInfo_temp select 0,2];

		// clear globals
		missionNamespace setVariable ["BLWK_customPlayAreaMapEH",nil];
		missionNamespace setVariable ["BLWK_missionAreaInfo_temp",nil];
		// delete markers
		deleteMarker BLWK_centerMarker_temp;
		missionNamespace setVariable ["BLWK_centerMarker_temp",nil];
		deleteMarker BLWK_areaMarker_temp;
		missionNamespace setVariable ["BLWK_areaMarker_temp",nil];
		deleteMarker BLWK_numBuildingsInfoMarker_temp;
		missionNamespace setVariable ["BLWK_numBuildingsInfoMarker_temp",nil];
		deleteMarker BLWK_numBuildingPositionsInfoMarker_temp;
		missionNamespace setVariable ["BLWK_numBuildingPositionsInfoMarker_temp",nil];
	};
}];

// make sure selected area will work
BLWK_fnc_checkLocation = {
	private _missionAreaInfo = missionNamespace getVariable ["BLWK_missionAreaInfo_temp",[]];
	// if no selection has been made
	if (_missionAreaInfo isEqualTo []) exitWith {
		hint "You neeed to click on the map to select a mission area";
		false
	};

	_missionAreaInfo params ["","_numBuildings","_numLootPositions"];
	if (_numBuildings isEqualTo 0) exitWith {
		hint parseText "<t color='#ff0000'>You need an area with buildings to spawn stuff</t>"; 
		false
	};
	// some of the mandatory items like the weapon box, loot revealer and satellite dish require unique positions
	if (_numLootPositions < REQ_NUMBER_OF_LOOT_POSITIONS) exitWith {
		hint parseText "<t color='#ff0000'>You need at least SIX positions to spawn loot</t>"; 
		false
	};
	 
	true
};

BLWK_fnc_getBuildingsInfo = {
	params ["_positionToCheck"];

	private _buildingsThatMeetCriteria = (_positionToCheck nearObjects ["House", BLWK_playAreaRadius]) select {
		// check that the building has cfg building positions to spawn stuff
		!((_x buildingPos -1) isEqualTo []) AND 
		// And check that it doesn't have water directly beneath it (avoid being too far out on a dock)
		{!(	surfaceIsWater (((lineIntersectsSurfaces [AGLToASL(_x buildingPos 0),AGLToASL(_x buildingPos 0) vectorDiff [0,0,20]]) select 0) select 0))}
	};	
	private _numberOfBuildings = count _buildingsThatMeetCriteria;

	// if no buildings are found
	if (_numberOfBuildings isEqualTo 0) then {
		[0,0] // return no buildings and no positions to spawn loot in area
	} else {
		private _numBuildingPositions = 0;
		_buildingsThatMeetCriteria apply {
			_numBuildingPositions = _numBuildingPositions + (count (_x buildingPos -1));
		};
		// return the number of buildings an loot spawn locations
		[_numberOfBuildings,_numBuildingPositions]
	};
};

BLWK_customPlayAreaMapEH = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];

	// create center marker or move it
	if (isNil "BLWK_centerMarker_temp") then {
		BLWK_centerMarker_temp = createMarker ["centerMarker_temp",_pos];
		
		BLWK_centerMarker_temp setMarkerTextLocal "Center";
		BLWK_centerMarker_temp setMarkerTypeLocal "hd_dot";
		BLWK_centerMarker_temp setMarkerColor "ColorRed";
		//BLWK_centerMarker_temp setMarkerSize 0.5;
	} else {
		BLWK_centerMarker_temp setMarkerPos _pos;
	};
	
	// create radius marker or move it
	if (isNil "BLWK_areaMarker_temp") then {
		BLWK_areaMarker_temp = createMarker ["areaMarker_temp",_pos];

		BLWK_areaMarker_temp setMarkerShapeLocal "ELLIPSE";
		BLWK_areaMarker_temp setMarkerSizeLocal [BLWK_playAreaRadius, BLWK_playAreaRadius];
		BLWK_areaMarker_temp setMarkerColorLocal "ColorWhite";
		BLWK_areaMarker_temp setMarkerAlpha 0.5;
	} else {
		BLWK_areaMarker_temp setMarkerPos _pos;
	};

	// create marker for number of buildings in location
	private _markerPosition_1 = _pos getPos [BLWK_playAreaRadius + 25,80];// put the marker to the side
	if (isNil "BLWK_numBuildingsInfoMarker_temp") then {	
		BLWK_numBuildingsInfoMarker_temp = createMarker ["numBuildingsInfoMarker_temp",_markerPosition_1];

		BLWK_numBuildingsInfoMarker_temp setMarkerTypeLocal "hd_dot";
		BLWK_numBuildingsInfoMarker_temp setMarkerSizeLocal [0.5,0.5];
		BLWK_numBuildingsInfoMarker_temp setMarkerColorLocal "ColorBLUFOR";
		BLWK_numBuildingsInfoMarker_temp setMarkerAlpha 1;
	} else {
		BLWK_numBuildingsInfoMarker_temp setMarkerPos _markerPosition_1;
	};

	// create marker for number of loot spawn locations
	private _markerPosition_2 = _pos getPos [BLWK_playAreaRadius + 25,100];// put the marker to the side
	if (isNil "BLWK_numBuildingPositionsInfoMarker_temp") then {
		BLWK_numBuildingPositionsInfoMarker_temp = createMarker ["numBuildingPositionsInfoMarker_temp",_markerPosition_2];

		BLWK_numBuildingPositionsInfoMarker_temp setMarkerTypeLocal "hd_dot";
		BLWK_numBuildingPositionsInfoMarker_temp setMarkerSizeLocal [0.5,0.5];
		BLWK_numBuildingPositionsInfoMarker_temp setMarkerColorLocal "ColorBLUFOR";
		BLWK_numBuildingPositionsInfoMarker_temp setMarkerAlpha 1;
	} else {
		BLWK_numBuildingPositionsInfoMarker_temp setMarkerPos _markerPosition_2;
	};

	// print out marker texts 
	private _buildingsInfo = [_pos] call BLWK_fnc_getBuildingsInfo;
	private _numberOfBuildings = _buildingsInfo select 0;
	BLWK_numBuildingsInfoMarker_temp setMarkerText (format ["There are %1 buildings in the area",_numberOfBuildings]);
	private _numberOfLootPositions = _buildingsInfo select 1;
	BLWK_numBuildingPositionsInfoMarker_temp setMarkerText (format ["There are %1 possible loot spawn locations",_numberOfLootPositions]);
	
	// inform the player of poor positions
	if (_numberOfLootPositions < 10 OR {_numberOfBuildings < 10}) then {
		hint "There is a very limited amount of buildings and/or loot spawns here. Maybe pick another location...";
	}; 
	
	// save for checking in BLWK_fnc_checkLocation
	BLWK_missionAreaInfo_temp = [_pos,_numberOfBuildings,_numberOfLootPositions];
}];
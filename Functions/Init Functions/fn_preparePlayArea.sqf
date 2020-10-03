/* ----------------------------------------------------------------------------
Function: BLWK_fnc_preparePlayArea

Description:
	Creates the marker for the play area on the map and 
	 sets the center starting point for the mission.

	Executed from "initServer.sqf"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_preparePlayArea;

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer OR {!canSuspend}) exitWith {};

#define NUMBER_OF_INFANTRY_SPAWN_POSITIONS 15
#define NUMBER_OF_VEHICLE_SPAWN_POSITIONS 5


// find the location the mission will take place
private _playAreaSelectionScript = [] spawn BLWK_fnc_selectPlayArea;

waitUntil {scriptDone _playAreaSelectionScript};

// create map marker for play radius
private _marker = createMarker ["Mission Area", BLWK_playAreaCenter];
missionNamespace setVariable ["BLWK_playAreaMarker",_marker,true];
BLWK_playAreaMarker setMarkerShape "ELLIPSE";
BLWK_playAreaMarker setMarkerSize [BLWK_playAreaRadius, BLWK_playAreaRadius];
BLWK_playAreaMarker setMarkerColor "ColorWhite";


// cache enemy infantry spawn positions
private _AISpawnPositionsArray = [];
private _positionToPushBack = [];
while {count _AISpawnPositionsArray < NUMBER_OF_INFANTRY_SPAWN_POSITIONS} do {
	_positionToPushBack = [BLWK_playAreaCenter, BLWK_playAreaRadius + 50, BLWK_playAreaRadius + 150, 0, 0] call BIS_fnc_findSafePos;
	_AISpawnPositionsArray pushBackUnique _positionToPushBack;
};
// give the spawn positions to whomever will be handling AI (server or headless client)
missionNamespace setVariable ["BLWK_infantrySpawnPositions",_AISpawnPositionsArray,BLWK_theAIHandlerOwnerID];


// cache enemy vehicle spawn positions
private _vehicleSpawnPositions = [];
while {count _vehicleSpawnPositions < NUMBER_OF_VEHICLE_SPAWN_POSITIONS} do {
	_positionToPushBack = [BLWK_playAreaCenter, BLWK_playAreaRadius + 100, BLWK_playAreaRadius + 200, 10] call BIS_fnc_findSafePos;
	_vehicleSpawnPositions pushBackUnique _positionToPushBack;
};
missionNamespace setVariable ["BLWK_vehicleSpawnPositions",_vehicleSpawnPositions,BLWK_theAIHandlerOwnerID];


// create and setup the actual box
bulwarkBox = call BLWK_fnc_prepareBulwarkServer;
bulwarkBox setVehiclePosition [BLWK_playAreaCenter,[],2,"NONE"];

// push player relavent actions and the loop to show the bulwark icon
null = [bulwarkBox] remoteExec ["BLWK_fnc_prepareBulwarkPlayer",BLWK_allClientsTargetID,true];
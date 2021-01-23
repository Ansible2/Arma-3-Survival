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

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define NUMBER_OF_INFANTRY_SPAWN_POSITIONS 15
#define NUMBER_OF_VEHICLE_SPAWN_POSITIONS 5

#define SCRIPT_NAME "BLWK_fnc_preparePlayArea"
scriptName SCRIPT_NAME;

if (!isServer) exitWith {};

if (!canSuspend) exitWith {
	[SCRIPT_NAME,"Needs to executed in scheduled, now running in scheduled...",false,true,true] call KISKA_fnc_log;
	null = [] spawn BLWK_fnc_preparePlayArea;
};


// find the location the mission will take place
private _playAreaSelectionScript = [] spawn BLWK_fnc_selectPlayArea;

waitUntil {scriptDone _playAreaSelectionScript};

// create map marker for play radius
private _marker = createMarker ["Mission Area", BLWK_playAreaCenter];
missionNamespace setVariable ["BLWK_playAreaMarker",_marker,true];
// every marker command will send a global update of all marker properties
// use the local versions first and lastly use a global command to send all changes across the network
BLWK_playAreaMarker setMarkerShapeLocal "ELLIPSE";
BLWK_playAreaMarker setMarkerSizeLocal [BLWK_playAreaRadius, BLWK_playAreaRadius];
BLWK_playAreaMarker setMarkerColor "ColorWhite";


// cache enemy infantry spawn positions
private _AISpawnPositionsArray = [];
private _positionToPushBack = [];
private _minRadius = BLWK_playAreaRadius + 50;
private _maxRadius = BLWK_playAreaRadius + 100;
while {count _AISpawnPositionsArray < NUMBER_OF_INFANTRY_SPAWN_POSITIONS} do {
	_positionToPushBack = [BLWK_playAreaCenter, _minRadius, _maxRadius, 0, 0] call BIS_fnc_findSafePos;
	_AISpawnPositionsArray pushBackUnique _positionToPushBack;
};
// give the spawn positions to whomever will be handling AI (server or headless client)
missionNamespace setVariable ["BLWK_infantrySpawnPositions",_AISpawnPositionsArray,BLWK_theAIHandlerOwnerID];


// cache enemy vehicle spawn positions
private _vehicleSpawnPositions = [];
_minRadius = BLWK_playAreaRadius + 100;
_maxRadius = BLWK_playAreaRadius + 200;
while {count _vehicleSpawnPositions < NUMBER_OF_VEHICLE_SPAWN_POSITIONS} do {
	_positionToPushBack = [BLWK_playAreaCenter, _minRadius, _maxRadius, 10] call BIS_fnc_findSafePos;
	_vehicleSpawnPositions pushBackUnique _positionToPushBack;
};
missionNamespace setVariable ["BLWK_vehicleSpawnPositions",_vehicleSpawnPositions,BLWK_theAIHandlerOwnerID];


// create and setup the actual box
BLWK_mainCrate = call BLWK_fnc_prepareTheCrateServer;
private _theCrateSpawn = [BLWK_playAreaCenter,3,20,1] call BIS_fnc_findSafePos;
waitUntil {
	BLWK_mainCrate setVehiclePosition [_theCrateSpawn,[],3,"NONE"]
};

// push player relavent actions and the loop to show The Crate icon
null = [BLWK_mainCrate] remoteExec ["BLWK_fnc_prepareTheCratePlayer",BLWK_allClientsTargetID,true];
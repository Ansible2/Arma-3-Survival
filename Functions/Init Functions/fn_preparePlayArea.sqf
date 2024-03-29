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
		[] spawn BLWK_fnc_preparePlayArea;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_preparePlayArea";

#define NUMBER_OF_VEHICLE_SPAWN_POSITIONS 5
#define MIN_VEHICLE_SPAWN_AREA 20

if (!isServer) exitWith {};

if (!canSuspend) exitWith {
	["Needs to executed in scheduled, now running in scheduled...",true] call KISKA_fnc_log;
	[] spawn BLWK_fnc_preparePlayArea;
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


call BLWK_fnc_cacheEnemyMenSpawnPositions;


// cache enemy vehicle spawn positions
private _vehicleSpawnPositions = [];
_minRadius = BLWK_playAreaRadius + 100;
_maxRadius = BLWK_playAreaRadius + 200;
while {count _vehicleSpawnPositions < NUMBER_OF_VEHICLE_SPAWN_POSITIONS} do {
	_positionToPushBack = [BLWK_playAreaCenter, _minRadius, _maxRadius, MIN_VEHICLE_SPAWN_AREA] call BIS_fnc_findSafePos;
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
[BLWK_mainCrate] remoteExec ["BLWK_fnc_prepareTheCratePlayer",BLWK_allClientsTargetID,true];

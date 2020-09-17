/* ----------------------------------------------------------------------------
Function: BLWK_fnc_preparePlayArea

Description:
	Creates the marker for the play area on the map and sets the center starting point for the mission

	Executed from ""

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_preparePlayArea;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

// find the location the mission will take place
private _playAreaSelectionScript = [] spawn BLWK_fnc_selectPlayArea;

waitUntil {scriptDone _playAreaSelectionScript};

// create map marker for play radius
// CIPHER COMMENT: may make publicVariable at some point, but for now...
BLWK_playAreaMarker = createMarker ["Mission Area", BLWK_playAreaCenter];
BLWK_playAreaMarker setMarkerShape "ELLIPSE";
BLWK_playAreaMarker setMarkerSize [BLWK_playAreaRadius, BLWK_playAreaRadius];
BLWK_playAreaMarker setMarkerColor "ColorWhite";


// create and setup the actual box
call BLWK_fnc_prepareBulwarkServer;

bulwarkBox setVehiclePosition [BLWK_playAreaCenter,[],2,"NONE"];

// push player relavent actions and the loop to show the bulwark icon
null = [bulwarkBox] remoteExec ["BLWK_fnc_prepareBulwarkPlayer",BLWK_allPlayersTargetID,true];
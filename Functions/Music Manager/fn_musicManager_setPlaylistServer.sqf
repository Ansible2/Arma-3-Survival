#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManager_setPlaylistServer

Description:
	Takes the current public array for tracks in the "KISKA_musicManager_currentPlaylist"
	 on the server and commits them to the random music pool of "KISKA_randomMusic_tracks".

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		remoteExecCall ["BLWK_fnc_musicManager_setPlaylistServer",2];
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManager_setPlaylistServer";

if (!isServer) exitWith {
	["Needs to be run on the server! This is not the server!",true] call KISKA_fnc_log;
	nil
};

// copying playlist by value not reference, otherwise they will be deleted out of the current playlist box
private _publicPlaylist = +GET_PUBLIC_ARRAY_DEFAULT;
missionNamespace setVariable ["KISKA_randomMusic_tracks",_publicPlaylist];

// reset used tracks so we don't get duplicate tracks
missionNamespace setVariable ["KISKA_randomMusic_usedTracks",[]];

// if random music system was already running, start a new instance
if (missionNamespace getVariable ["KISKA_musicSystemIsRunning",false]) then {
	[] spawn KISKA_fnc_randomMusic;
};


nil

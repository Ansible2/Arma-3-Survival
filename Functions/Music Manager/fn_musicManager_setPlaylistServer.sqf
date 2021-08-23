#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
#include "..\..\KISKA Systems\KISKA Music Functions\Headers\Music Common Defines.hpp"
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
SET_MUSIC_VAR(MUSIC_RANDOM_UNUSED_TRACKS_VAR_STR,_publicPlaylist);

// reset used tracks so we don't get duplicate tracks
SET_MUSIC_VAR( MUSIC_RANDOM_USED_TRACKS_VAR_STR,[] );

// if random music system was already running, start a new instance
if (GET_MUSIC_RANDOM_MUSIC_SYS_RUNNING) then {
	[] spawn KISKA_fnc_randomMusic;
};


nil

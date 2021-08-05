#include "Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_musicStartEvent

Description:
	The function that should be activated when music starts playing.

Parameters:
	0: _trackClassname <STRING> - The classname of the track that started playing

Returns:
	NOTHING

Examples:
    (begin example)
		["trackThatStarted"] call KISKA_fnc_musicStartEvent;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_musicStartEvent";

if (!hasInterface) exitWith {};

params [
	["_trackClassname","",[""]]
];


SET_MUSIC_VAR(MUSIC_IS_PLAYING_VAR_STR,true);
SET_MUSIC_VAR(MUSIC_CURRENT_TRACK_VAR_STR,_trackClassName);
// clear out any track. Any new MUSIC_CURRENT_RANDOM_TRACK_VAR_STR will be set to the new track in KISKA_fnc_playMusic after this event has fired
// this is to avoid a track random music track not being cleared
//[""] call KISKA_fnc_setCurrentRandomMusicTrack;


[["Started playing track: ", _trackClassname],false] call KISKA_fnc_log;


nil

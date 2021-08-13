#include "Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_setCurrentRandomMusicTrack

Description:
	Sets the current random track from the random music system.

Parameters:
	0: _trackClass <STRING> - a classname to check the duration of or its config path

Returns:
	<BOOL> - True when set

Examples:
    (begin example)
		["Some_Music_Track"] call KISKA_fnc_setCurrentRandomMusicTrack;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_setCurrentRandomMusicTrack";

params [
	["_trackClass","",[""]]
];

SET_MUSIC_VAR(MUSIC_CURRENT_RANDOM_TRACK_VAR_STR,_trackClass);
[["Set Current Random Track ",_trackClass]] call KISKA_fnc_log;

true

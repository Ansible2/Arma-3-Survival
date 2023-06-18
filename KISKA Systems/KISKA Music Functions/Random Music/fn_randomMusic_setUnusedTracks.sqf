#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_setUnusedTracks

Description:
    Sets the current tracks in the random music system that could play.

Parameters:
    0: _musicTracks <ARRAY> - An array of strings (music tracks) to use

Returns:
    NOTHING

Examples:
    (begin example)
        [["someTrack","anotherTrack"]] call KISKA_fnc_randomMusic_setUnusedTracks;
       (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_setUnusedTracks";

if (!isServer) exitWith {
    ["The random music system only runs on the server",true] call KISKA_fnc_log;
    nil
};

params [
    ["_musicTracks",call KISKA_fnc_randomMusic_getUnusedTracks,[[]]]
];

SET_MUSIC_VAR(MUSIC_RANDOM_UNUSED_TRACKS_VAR_STR,_musicTracks);


nil

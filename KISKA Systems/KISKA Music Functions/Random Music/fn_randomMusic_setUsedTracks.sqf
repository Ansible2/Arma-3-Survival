#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_setUsedTracks

Description:
    Sets the tracks in the random music system that have already been played

Parameters:
    0: _usedMusicTracks <ARRAY> - An array of already used music tracks

Returns:
    NOTHING

Examples:
    (begin example)
        [["SomeTrack","AnotherTrack"]] call KISKA_fnc_randomMusic_setUsedTracks;
       (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_setUsedTracks";

if (!isServer) exitWith {
    ["The random music system only runs on the server",true] call KISKA_fnc_log;
    nil
};

params [
    ["_usedMusicTracks",call KISKA_fnc_randomMusic_getUsedTracks,[[]]]
];

SET_MUSIC_VAR(MUSIC_RANDOM_USED_TRACKS_VAR_STR,_usedMusicTracks);


nil

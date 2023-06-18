#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_setCurrentTrack

Description:
    Sets the current random track from the random music system.

Parameters:
    0: _trackClass <STRING> - a classname to check the duration of or its config path

Returns:
    <BOOL> - True when set

Examples:
    (begin example)
        ["Some_Music_Track"] call KISKA_fnc_randomMusic_setCurrentTrack;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_setCurrentTrack";

if (!isServer) exitWith {
    ["Must be executed on the server, exiting...",true] call KISKA_fnc_log;
    false
};

params [
    ["_trackClass","",[""]]
];

SET_MUSIC_VAR(MUSIC_CURRENT_RANDOM_TRACK_VAR_STR,_trackClass);
[["Set Current Random Track ",_trackClass]] call KISKA_fnc_log;


true

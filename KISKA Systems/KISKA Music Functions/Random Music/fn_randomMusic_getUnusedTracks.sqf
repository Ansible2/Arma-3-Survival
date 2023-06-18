#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_getUnusedTracks

Description:
    Retrieves the current tracks in the random music system that could play.

Parameters:
    NONE

Returns:
    <ARRAY> - An array of strings of the unused classnames of tracks

Examples:
    (begin example)
        private _arrayOfTracks = call KISKA_fnc_randomMusic_getUnusedTracks;
       (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_getUnusedTracks";

if (!isServer) then {
    ["The random music system only runs on the server",true] call KISKA_fnc_log;
    []
};

GET_MUSIC_RANDOM_UNUSED_TRACKS

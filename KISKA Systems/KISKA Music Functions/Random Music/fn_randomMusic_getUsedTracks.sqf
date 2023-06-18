#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_getUsedTracks

Description:
    Retrieves the tracks in the random music system that have already been played

Parameters:
    NONE

Returns:
    <ARRAY> - An array of strings of the used classnames of tracks

Examples:
    (begin example)
        private _arrayOfTracks = call KISKA_fnc_randomMusic_getUsedTracks;
       (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_getUsedTracks";

if (!isServer) then {
    ["The random music system only runs on the server",true] call KISKA_fnc_log;
    []
};

GET_MUSIC_RANDOM_USED_TRACKS

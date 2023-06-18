#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_getTrackInterval

Description:
    Retrieves the current tracks in the random music system that could play.

    Possible Values:
        [NUMBER,NUMBER,NUMBER] - used with the "random" command's [min,mid,max]
            to get a uniform random space between tracks.
        [NNUMBER] - used with denotes that the space between tracks can be UP TO this number.
        NUMBER - the exact time between tracks that will be the same every time.

Parameters:
    NONE

Returns:
    <ARRAY or NUMBER> - see Description for details

Examples:
    (begin example)
        private _interval = call KISKA_fnc_randomMusic_getTrackInterval;
       (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_getTrackInterval";

if (!isServer) then {
    ["The random music system only runs on the server",true] call KISKA_fnc_log;
    -1
};

GET_MUSIC_RANDOM_TIME_BETWEEN

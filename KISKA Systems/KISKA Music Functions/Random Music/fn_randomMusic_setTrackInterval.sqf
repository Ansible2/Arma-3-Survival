#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_setTrackInterval

Description:
    Sets the dwell time variable that handles the time between random music tracks
     being played.

Parameters:
    0: _interval <ARRAY or NUMBER> - A random or set time between tracks.
        Formats are [min,mid,max] & [max] for random numbers and just a single
         number for a set time between.

Returns:
    <BOOL> - true if updated, false if not

Examples:
    (begin example)
        [20] remoteExecCall ["KISKA_fnc_randomMusic_setTrackInterval",2];
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_setTrackInterval";

if (!isServer) exitWith {
    ["Needs to be executed on the server, exiting...",true] call KISKA_fnc_log;
    false
};

params [
    ["_interval",3,[123,[]]]
];


if (
    (_interval isEqualType []) AND
    {
        !((count _interval) isEqualTo 1) AND
        {
            !((count _interval) isEqualTo 3) OR !(_interval isEqualTypeParams [1,2,3])
        }
    }
) exitWith {
    [[_interval," is not the correct format for _interval"],true] call KISKA_fnc_log;
    false

};


// update to new timebetween if needed
if ((GET_MUSIC_RANDOM_TIME_BETWEEN) isNotEqualTo _interval) then {
    SET_MUSIC_VAR(MUSIC_RANDOM_TIME_BETWEEN_VAR_STR,_interval);
};


true

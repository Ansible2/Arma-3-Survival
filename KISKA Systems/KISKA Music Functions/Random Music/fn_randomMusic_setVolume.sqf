#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_setVolume

Description:
    Changes the volume at which random music specifically will play at (on all clients).

    Only executes on server.

Parameters:
    0: _volume <NUMBER> - volume to set

Returns:
    NOTHING

Examples:
    (begin example)
        [1] remoteExecCall ["KISKA_fnc_randomMusic_setVolume",2];
    (end)

Authors:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_setVolume";

if (!isServer) exitWith {
    ["Needs to be executed on the server. There is no affect on clients.",true] call KISKA_fnc_log;
    nil
};

params [
    ["_volume",0.5,[123]]
];

SET_MUSIC_VAR(MUSIC_RANDOM_VOLUME_VAR_STR,_volume)

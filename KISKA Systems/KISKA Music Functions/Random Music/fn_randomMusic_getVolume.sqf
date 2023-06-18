#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_getVolume

Description:
    Retrieves the current volume that random music system plays tracks at

Parameters:
    NONE

Returns:
    <NUMBER> - the volume

Examples:
    (begin example)
        private _volume = call KISKA_fnc_randomMusic_getVolume;
       (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_getVolume";

if (!isServer) then {
    ["The random music system only runs on the server",true] call KISKA_fnc_log;
    -1
};


GET_MUSIC_RANDOM_VOLUME

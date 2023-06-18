#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_isSystemRunning

Description:
    Retrieves whether or not the random music system is currently running

Parameters:
    NONE

Returns:
    <BOOL> - True for running, false for not

Examples:
    (begin example)
        private _isRunning = call KISKA_fnc_randomMusic_isSystemRunning;
       (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_isSystemRunning";

if (!isServer) then {
    ["The random music system only runs on the server",true] call KISKA_fnc_log;
    false
};


GET_MUSIC_RANDOM_SYS_RUNNING

#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_setSystemRunning

Description:
    Sets the boolean for determining if the random music system is running.

Parameters:
    0: _setting <BOOL> - True for running, false for not

Returns:
    NOTHING

Examples:
    (begin example)
        // set to running
        [true] call KISKA_fnc_randomMusic_setSystemRunning;
       (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_setSystemRunning";

if (!isServer) exitWith {
    ["The random music system only runs on the server",true] call KISKA_fnc_log;
    nil
};

params [
    ["_setting",true,[true]]
];

SET_MUSIC_VAR(MUSIC_RANDOM_SYS_RUNNING_VAR_STR,true);


nil

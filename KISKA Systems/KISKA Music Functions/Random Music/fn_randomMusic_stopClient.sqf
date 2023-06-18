/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_stopClient

Description:
    The clientside part of stopping random music system.
    Ideally, should not be called on its own but used from KISKA_fnc_randomMusic_stopServer

Parameters:
    NONE

Returns:
    <BOOL> - True if done, false if nothing done

Examples:
    (begin example)
        call KISKA_fnc_randomMusic_stopClient;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_stopClient";

if (!hasInterface) exitWith {false};

if ((call KISKA_fnc_getPlayingMusic) == (call KISKA_fnc_randomMusic_getCurrentTrack)) then {
    /*
        there should in the future be a more robust way of determining if a track did indeed come
         from KISKA_fnc_randomMusic. As it stands, if a manual song is playing that is ALSO in the list
         and was played from random music, then it will still stop it
    */
    [] spawn KISKA_fnc_stopMusic;
    
    true
} else {
    false
};
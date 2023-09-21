/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_unitKilled

Description:
    Informs the server that a unit from the queue has died. This will either
     trigger another unit to be popped and created or to end the wave.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        [] remoteExecCall ["BLWK_fnc_spawnQueue_unitKilled",2];
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_unitKilled";

if (!isServer) exitWith {};

private _currentWaveKilledCount = localNamespace getVariable ["BLWK_spawnQueue_killedCount",0];
localNamespace setVariable ["BLWK_spawnQueue_killedCount",_currentWaveKilledCount + 1];

private _currentQueue = call BLWK_fnc_spawnQueue_popAndCreate;
private _queueIsEmpty = _currentQueue isEqualTo [];
if (_queueIsEmpty AND {call BLWK_fnc_waves_isCleared}) then {
    [
        {
            call BLWK_fnc_waves_end;
        }
    ] call CBAP_fnc_directCall;
};


nil
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_waves_onInitialized

Description:
    Activates some basic events after a wave has been fully initialized.

    Meaning that the initial set of units has been spawned.

Parameters:
    0: _waveConfig <CONFIG> - The config path of the wave that was created

Returns:
    NOTHING

Examples:
    (begin example)
        [
            missionConfigFile >> "BLWK_waveTypes" >> "normalWaves" >> "standardWave"
        ] call BLWK_fnc_waves_onInitialized;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_waves_onInitialized";

#define SPECIAL_WAVE_CONFIG missionConfigFile >> "BLWK_waveTypes" >> "specialWaves"

if (!isServer) exitWith {};

params [
    ["_waveConfigPath",configNull,[configNull]]
];


private _onInit = [
    _waveConfigPath,
    "onWaveInit"
] call BLWK_fnc_waves_getFunctionFromConfig;
call _onInit;


private _notification = [];
_notification pushBack (getText(_waveConfigPath >> "creationNotificationTemplate"));

private _notificationText = getText(_waveConfigPath >> "notificationText");
if ([_waveConfigPath >> "compileNotificationText"] call BIS_fnc_getCfgDataBool) then {
    _notificationText = call compileFinal _notificationText;
} else {
    _notificationText = [_notificationText];
};
_notification pushBack _notificationText;


private _players = call CBAP_fnc_players;
_notification remoteExec ["BIS_fnc_showNotification", _players];

// play a sound for special waves
private _isSpecialWave = [_waveConfigPath,SPECIAL_WAVE_CONFIG] call CBAP_fnc_inheritsFrom;
if (_isSpecialWave) then {
    ["Alarm"] remoteExec ["playSound", _players];
};


[["Start Wave: ",BLWK_currentWaveNumber],false] call KISKA_fnc_log;

[missionNamespace,"BLWK_onWaveStart"] remoteExecCall ["BIS_fnc_callScriptedEventHandler",0];


nil


scriptName "BLWK_fnc_wave_create";

// if (clientOwner isNotEqualTo BLWK_theAIHandlerOwnerID) exitWith {
//     private _message = [
//         "Executed BLWK_fnc_wave_create on clientOwner: ",
//         clientOwner,
//         " while BLWK_theAIHandlerOwnerID was: ",
//         BLWK_theAIHandlerOwnerID,
//         " on this machine! Defaulting to sever to handle the wave"
//     ] joinString "";
//     [_message,5] remoteExecCall ["KISKA_fnc_errorNotification",0];
// 	[_message,true] remoteExecCall ["KISKA_fnc_log",2];

// 	_this remoteExecCall ["BLWK_fnc_wave_create",2];
// };

// #define DEFAULT_ON_WAVE_SELECTED_NAME "BLWK_fnc_standardWave_onWaveSelected"
#define DEFAULT_WAVE_CONFIG_PATH missionConfigFile >> "BLWK_waveTypes" >> "normalWaves" >> "standardWave"
#define SPECIAL_WAVE_CONFIG missionConfigFile >> "BLWK_waveTypes" >> "specialWaves"
#define BASE_ENEMY_NUMBER 2

params [
    ["_waveConfig",configNull,[configNull]],
    ["_totalNumEnemiesToSpawnDuringWave",-1,[123]]
];

// private _onWaveSelectedFunction = missionNamespace getVariable [_onWaveSelectedFunctionName,{}];
// if (_waveConfig isEqualTo configNull) exitWith {
//     private _message = [
//         "Could not find onWaveSelected function with the name: ",
//         _onWaveSelectedFunction,
//         " on the server! Using standard Wave..."
//     ] joinString "";

//     [_message,10] remoteExecCall ["KISKA_fnc_errorNotification",0];
//     [_message,true] remoteExecCall ["KISKA_fnc_log",2];

//     [DEFAULT_ON_WAVE_SELECTED_NAME] call BLWK_fnc_wave_create;
// };

private _notifyOfError = {
    params ["_message"];

    [_message] remoteExec ["BLWK_fnc_notifyAdminsOrHostOfError",0];
    [_message,true] call KISKA_fnc_log;
};

private _fn_getFunctionFromWaveConfig = {
    params [
        "_configProperty",
        ["_justName",false]
    ];

    private _requestedFunctionName = getText(_waveConfig >> _configProperty);
    private _default_functionName = getText(DEFAULT_WAVE_CONFIG_PATH >> _configProperty);
    if (_requestedFunctionName isEqualTo "") then {
        _requestedFunctionName = _default_functionName
    };

    private _requestedFunction = missionNamespace getVariable [
        _requestedFunctionName,
        {}
    ];
    if (_requestedFunction isEqualTo {}) then {
        private _message = [
            "Could not find function for property: ",
            _configProperty,
            " with the name: ",
            _requestedFunctionName,
            " on the server in config: ",
            _waveConfig
        ] joinString "";
        [_message] call _notifyOfError;

        _requestedFunction = missionNamespace getVariable _default_functionName;
    };


    if (_justName) exitWith { _requestedFunctionName };
    _requestedFunction
};


/* ----------------------------------------------------------------------------
    Create Queue
---------------------------------------------------------------------------- */
private _generatManClassesFunction = ["generateMenClassnames"] call _fn_getFunctionFromWaveConfig;
private _generateSpawnPositionFunction = ["generateManSpawnPosition"] call _fn_getFunctionFromWaveConfig;

if (_totalNumEnemiesToSpawnDuringWave < BASE_ENEMY_NUMBER) then {
    _totalNumEnemiesToSpawnDuringWave = BASE_ENEMY_NUMBER * ((BLWK_enemiesPerWaveMultiplier * BLWK_currentWaveNumber) + 1);
    _totalNumEnemiesToSpawnDuringWave = _totalNumEnemiesToSpawnDuringWave + (BLWK_enemiesPerPlayerMultiplier * (count (call CBAP_fnc_players)));
    _totalNumEnemiesToSpawnDuringWave = round _totalNumEnemiesToSpawnDuringWave;
};

private _availableClassnames = call _generatManClassesFunction;
private "_spawnPosition_temp";
if (!BLWK_multipleEnemyPositions) then {
	_spawnPosition_temp = selectRandom BLWK_infantrySpawnPositions;
};

private _onManCreatedFunctionName = ["generateManSpawnPosition",true] call _fn_getFunctionFromWaveConfig;
for "_i" from 1 to _totalNumEnemiesToSpawnDuringWave do {
    if (BLWK_multipleEnemyPositions) then {
        _spawnPosition_temp = call _generateSpawnPositionFunction;
    };

    private _class = [_availableClassnames] call KISKA_fnc_selectRandom;
    [
        _class,
        _spawnPosition_temp,
        _onManCreatedFunctionName
    ] call BLWK_fnc_addToQueue;
};


/* ----------------------------------------------------------------------------
    Send wave start notification
---------------------------------------------------------------------------- */
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

// TODO:
// need to create base enemy units
// server needs to know when all units are dead to end the wave
// server needs to know that wave has started (e.g. initial enemies have spawned)


// Wave types determine how to create enemies to a point
// Things the ai owner cares about:
// 1. where is the guy spawning
// 2. what type is he
// 3. what code should I run on his creation?

// [] remoteExecCall ["BLWK_fnc_onWaveEnemiesSpawned",2];


localNamespace setVariable ["BLWK_currentWaveConfig",_waveConfigPath];

nil












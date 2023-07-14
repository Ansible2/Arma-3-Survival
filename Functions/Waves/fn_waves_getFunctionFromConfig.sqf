/* ----------------------------------------------------------------------------
Function: BLWK_fnc_waves_getFunctionFromConfig

Description:
    Intellegently finds the code for a given config property in a wave config.

    Will fill in with the standard wave defaults and notify users of certain errors.

Parameters:
    0: _waveConfig <CONFIG> - The config path of the wave to get the property from
    1: _configProperty <STRING> - The name of the code property to find in the config
    2: _justName <BOOL> - If true, only the string name of the function will be returned

Returns:
    <STRING | CODE> - either returns the name of a function or the code associated with that name

Examples:
    (begin example)
        private _code = [
            missionConfigFile >> "BLWK_waveTypes" >> "normalWaves" >> "standardWave",
            "generateMenClassnames"
        ] call BLWK_fnc_waves_getFunctionFromConfig;
    (end)

    (begin example)
        private _functionName = [
            missionConfigFile >> "BLWK_waveTypes" >> "normalWaves" >> "standardWave",
            "generateMenClassnames",
            true
        ] call BLWK_fnc_waves_getFunctionFromConfig;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_waves_getFunctionFromConfig";

#define DEFAULT_WAVE_CONFIG_PATH missionConfigFile >> "BLWK_waveTypes" >> "normalWaves" >> "standardWave"

params [
    ["_waveConfig",configNull,[configNull]],
    ["_configProperty","",[""]],
    ["_justName",false,[true]],
    ["_allowDefault",true,[true]]
];


private _requestedConfig = _waveConfig >> _configProperty;
private _requestedFunctionName = getText(_requestedConfig);
private _functionNameIsEmpty = _requestedFunctionName isEqualTo "";
private _configIsDefinedEmpty = !(isNull _requestedConfig) AND _functionNameIsEmpty;
if (_configIsDefinedEmpty) exitWith {
    [
        [
            "found empty definition for ",
            _configProperty,
            " at config: ",
            _waveConfig
        ], 
        false
    ] call KISKA_fnc_log;

    if (_justName) then {
        ""
    } else {
        {}
    };
};


private _default_functionName = getText(DEFAULT_WAVE_CONFIG_PATH >> _configProperty);
if (_functionNameIsEmpty) then {
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

    [_message] remoteExec ["BLWK_fnc_notifyAdminsOrHostOfError",0];
    [_message,true] call KISKA_fnc_log;

    _requestedFunction = missionNamespace getVariable _default_functionName;
};


if (_justName) exitWith { _requestedFunctionName };
_requestedFunction

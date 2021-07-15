#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_getCurrentParamValue

Description:
    Returns the current parameter value for a given paramConfig.

    This can be three possible values.
    In order of hierarchy:
        1. The uncommitted changed value that the player currently has the param set to
        2. The global/public variable value the player currently has
        3. The configed default value

Parameters:
	0: _paramConfig : <CONFIG> - The config path of param to add to the params control group
    1: _returnStagedChange : <BOOL> - Should a staged change be considered over the other options

Returns:
	<STRING, NUMBER, or BOOL> - The "current" value

Examples:
    (begin example)
        [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam"
        ] call KISKA_fnc_paramsMenu_getCurrentParamValue
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_getCurrentParamValue";

params [
    ["_paramConfig",configNull,[configNull]],
    ["_returnStagedChange",true,[true]]
];

if (isNull _paramConfig) exitWith {
    ["A null config was passed",true] call KISKA_fnc_log;
    nil
};

private "_currentValue";
private _changedVarsHash = GET_STAGED_CHANGE_PARAMS_HASH;
if (_returnStagedChange AND {_paramConfig in _changedVarsHash}) then {
    _currentValue = _changedVarsHash get _paramConfig;

} else {
    private _defaultValue = [_paramConfig] call KISKA_fnc_paramsMenu_getDefaultParamValue;
    private _paramVarName = [_paramConfig] call KISKA_fnc_paramsMenu_getParamVarName;
    _currentValue = ([_paramConfig] call KISKA_fnc_paramsMenu_getParamNamespace) getVariable [_paramVarName,_defaultValue];

};


_currentValue

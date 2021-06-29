#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_getParamVarName

Description:
    Returns the variable name associated with a specific param config.
    This is either a custom string or the configName of the param config.

Parameters:
	0: _paramConfig : <CONFIG> - The config path of param to add to the params control group

Returns:
	<STRING> - The global space variable name

Examples:
    (begin example)
        [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam"
        ] call KISKA_fnc_paramsMenu_getParamVarName
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_getParamVarName";

params [
    ["_paramConfig",configNull,[configNull]]
];

if (isNull _paramConfig) exitWith {
    ["A null config was passed",true] call KISKA_fnc_log;
    nil
};

private _paramVarName = getText(_paramConfig >> "varName");
if (_paramVarName isEqualTo "") then {
    _paramVarName = configName _paramConfig;
};


(toLowerANSI _paramVarName)

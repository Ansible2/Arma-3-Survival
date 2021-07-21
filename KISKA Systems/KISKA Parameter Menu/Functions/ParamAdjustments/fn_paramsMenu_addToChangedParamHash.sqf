#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_addToChangedParamHash

Description:
    Adds the given string to a list of localNamespace variables that are set to nil
     after the menu is closed.

Parameters:
    0: _paramConfig : <CONFIG> - The config path of param to add to the params control group
    1: _newValue : <STRING, NUMBER, or ARRAY> - The new value that the parm was changed to

Returns:
	NOTHING

Examples:
    (begin example)
        [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam",
            1
        ] call KISKA_fnc_paramsMenu_addToChangedParamHash;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_addToChangedParamHash";

params [
    ["_paramConfig",configNull,[configNull]],
    ["_newValue",0,[123,"",true]]
];

if (isNull _paramConfig) exitWith {
    ["A null config was passed",true] call KISKA_fnc_log;
    nil
};

private _changedVarsHash = GET_STAGED_CHANGE_PARAMS_HASH;
if (isNil {localNamespace getVariable STAGED_CHANGE_VAR_HASH_VAR_STR}) then {
    localNamespace setVariable [STAGED_CHANGE_VAR_HASH_VAR_STR,_changedVarsHash];
    [STAGED_CHANGE_VAR_HASH_VAR_STR] call KISKA_fnc_paramsMenu_addToUnloadMissionList;
};

_changedVarsHash set [_paramConfig,_newValue];


nil

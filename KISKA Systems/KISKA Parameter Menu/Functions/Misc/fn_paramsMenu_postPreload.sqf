#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_postPreload

Description:
    inits default values if needs for variables

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_postPreload";

if (localNamespace getVariable ["KISKA_missionParams_preloadFinished",false]) exitWith {
    ["Preload is already finished",false] call KISKA_fnc_log;
    nil
};

if (call KISKA_fnc_isMainMenu) exitWith {
    ["Main menu detected, will not init",false] call KISKA_fnc_log;
    nil
};


call KISKA_fnc_paramsMenu_cacheConfig;
private ["_varName","_defaultValue","_namespace","_initScript","_currentValue"];
(GET_PARAM_CONFIGS_FULL) apply {
    _varName = [_x] call KISKA_fnc_paramsMenu_getParamVarName;
    _namespace = [_x] call KISKA_fnc_paramsMenu_getParamNamespace;

    // don't overwrite variables that were changed in briefing or loaded from save
    _currentValue = _namespace getVariable [_varName,nil];
    if (isNil {_currentValue}) then {
        _defaultValue = [_x] call KISKA_fnc_paramsMenu_getDefaultParamValue;
        _namespace setVariable [_varName,_defaultValue];
        _currentValue = _defaultValue;
    };

    _initScript = getText(_x >> "initScript");
    if (_initScript isNotEqualTo "") then {
        [_currentValue,_varName,_x] call (compileFinal _initScript);
    };
};

[
	[
		"Mission Parameters",
		"<execute expression='[] spawn KISKA_fnc_paramsMenu_open'>Open Mission Parameter Menu</execute>"
	]
] call KISKA_fnc_addKiskaDiaryEntry;


localNamespace setVariable ["KISKA_missionParams_preloadFinished",true];
remoteExec ["KISKA_fnc_paramsMenu_dedicatedPreload",2];


nil

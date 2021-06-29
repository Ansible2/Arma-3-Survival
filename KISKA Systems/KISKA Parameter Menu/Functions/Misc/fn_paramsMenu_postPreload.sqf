#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_postPreload

Description:


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

//if (!hasInterface) exitWith {};

if (call KISKA_fnc_isMainMenu) exitWith {
    ["Main menu detected, will not init",false] call KISKA_fnc_log;
    nil
};

call KISKA_fnc_paramsMenu_cacheConfig;
private ["_varName","_defaultValue"];
(GET_PARAM_CONFIGS_FULL) apply {
    _varName = [_x] call KISKA_fnc_paramsMenu_getParamVarName;

    if (isNil _varName) then {
        _defaultValue = [_x] call KISKA_fnc_paramsMenu_getDefaultParamValue;
        missionNamespace setVariable [_varName,_defaultValue];
    };
};


localNamespace setVariable ["KISKA_missionParams_preloadFinished",true];

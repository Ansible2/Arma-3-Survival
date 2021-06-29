#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_cacheConfig

Description:
    Caches the KISKA mission params config paths for easier references.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
        call KISKA_fnc_paramsMenu_cacheConfig;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_cacheConfig";

disableSerialization;

private _categoryConfigs = GET_PARAMS_CATEGORY_CONFIGS;
if (_categoryConfigs isEqualTo [] OR {!(GET_ARE_PARAMS_CACHED)}) then {
    ["Found that params were not cached or empty category array exits, proceeding..."] call KISKA_fnc_log;

    _categoryConfigs = "true" configClasses (missionConfigFile >> "KISKA_missionParams");
    localNamespace setVariable [PARAMS_CONFIG_CATEGORIES_VAR_STR,_categoryConfigs];
    //[PARAMS_CONFIG_CATEGORIES_VAR_STR] call KISKA_fnc_paramsMenu_addToUnloadMissionList;

    private _missionParamsConfigCache = [];
    _categoryConfigs apply {
        _missionParamsConfigCache append ("true" configClasses _x);
    };
    localNamespace setVariable [PARAMS_CONFIG_FULL_VAR_STR,_missionParamsConfigCache];
    //[PARAMS_CONFIG_FULL_VAR_STR] call KISKA_fnc_paramsMenu_addToUnloadMissionList;

    private _configVarNamesHashMap = createHashMap;
    _missionParamsConfigCache apply {
        _configVarNamesHashMap set [[_x] call KISKA_fnc_paramsMenu_getParamVarName,_x];
    };
    localNamespace setVariable [PARAMS_VAR_NAMES_CONFIG_HASH_VAR_STR,_configVarNamesHashMap];
    //[PARAMS_VAR_NAMES_CONFIG_HASH_VAR_STR] call KISKA_fnc_paramsMenu_addToUnloadMissionList;


    localNamespace setVariable [ARE_PARAMS_CACHED_VAR_STR,true];
    //[ARE_PARAMS_CACHED_VAR_STR] call KISKA_fnc_paramsMenu_addToUnloadMissionList;

} else {
    ["Params have been cached, will not reCache..."] call KISKA_fnc_log;

};


nil

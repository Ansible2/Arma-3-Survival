#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_serializeConfig

Description:
    Translates a Kiska mission param config entry into a number for lighter load
     when transfering over the network. Configs are used to be able to call events
     when settings are changed.

Parameters:
	0: _paramConfig : <CONFIG> - The config path of param to serialize

Returns:
	<NUMBER> - The corresponding parameter config serialized

Examples:
    (begin example)
        _serial = [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam"
        ] call KISKA_fnc_paramsMenu_serializeConfig;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_serializeConfig";

params [
    ["_paramConfig",configNull,[configNull]]
];

if !(GET_ARE_PARAMS_CACHED) then {
    call KISKA_fnc_paramsMenu_cacheConfig;
};


(GET_PARAM_CONFIGS_FULL) find _paramConfig;

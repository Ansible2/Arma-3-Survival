#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_deserializeConfig

Description:
    Translates a number index into a Kiska mission param config entry.

Parameters:
	0: _serial : <NUMBER> - The index number (serial) of the config

Returns:
	<CONFIG> - The indexed config

Examples:
    (begin example)
        _config = [someSerialNumber] call KISKA_fnc_paramsMenu_deserializeConfig;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_deserializeConfig";

params [
    ["_serial",0,[123]]
];

if !(GET_ARE_PARAMS_CACHED) then {
    call KISKA_fnc_paramsMenu_cacheConfig;
};


(GET_PARAM_CONFIGS_FULL) select _serial;

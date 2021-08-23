#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_getJIPQueueId

Description:
    Returns the JIP Id name associated with a specific param config for when
     it is transmitted over the network.

Parameters:
	0: _paramConfig : <CONFIG or NUMBER> - The config path of param to get the ID of or its serialized version

Returns:
	<STRING> - The JIP Queue Id that will be or has been used to broadcast the param change over the network

Examples:
    (begin example)
        _id = [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam"
        ] call KISKA_fnc_paramsMenu_getJIPQueueId
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_getJIPQueueId";

params [
    ["_paramConfig",configNull,[configNull,123]]
];


if (_paramConfig isEqualType configNull) then {
    private _serial = [_paramConfig] call KISKA_fnc_paramsMenu_serializeConfig;

    JIP_QUEUE_PREFIX + (str _serial)
} else {
    JIP_QUEUE_PREFIX + (str _paramConfig)

};

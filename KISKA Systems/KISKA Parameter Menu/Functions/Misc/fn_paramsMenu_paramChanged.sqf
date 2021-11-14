#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_paramChanged

Description:
    Transmits any changes to the mission params on the current maching to all
     others on the network.

    Adds message to the JIP Queue.

Parameters:
	0: _paramSerial : <NUMBER> - The serialized param config
    1: _newValue : <NUMBER, STRING, or BOOL> - The updated value to set
    2: _runOnChanged : <BOOL> - Should the event for "onChanged" of the param run

Returns:
	NOTHING

Examples:
    (begin example)
        [_serialConfig,_newValue] remoteExecCall ["KISKA_fnc_paramsMenu_paramChanged", 0, [_serialConfig] call KISKA_fnc_paramsMenu_getJIPQueueId];
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_paramChanged";

params [
    ["_paramSerial",-1,[123]],
    ["_newValue",-1,[123,"",true]],
    ["_runOnChanged",true,[true]]
];


private _paramConfig = [_paramSerial] call KISKA_fnc_paramsMenu_deserializeConfig;
private _paramVarName = [_paramConfig] call KISKA_fnc_paramsMenu_getParamVarName;

([_paramConfig] call KISKA_fnc_paramsMenu_getParamNamespace) setVariable [_paramVarName, _newValue];

if (localNamespace getVariable ["KISKA_missionParams_preloadFinished",false] AND _runOnChanged) then {

    private _onChangedCode = getText(_paramConfig >> "onChanged");
    if (_onChangedCode isNotEqualTo "") then {
        [_newValue,_paramVarName,_paramConfig] call (compileFinal _onChangedCode);
    };

};


nil

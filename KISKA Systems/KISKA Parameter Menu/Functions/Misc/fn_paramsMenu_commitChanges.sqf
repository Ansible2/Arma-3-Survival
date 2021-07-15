#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_commitChanges

Description:
    Transmits any changes to the mission params on the current maching to all
     others on the network.

    Adds message to the JIP Queue.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
        call KISKA_fnc_paramsMenu_commitChanges
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_commitChanges";


if !(call KISKA_fnc_isAdminOrHost) exitWith {};

["Sending Changes..."] call KISKA_fnc_paramsMenu_logMessage;
private _preloadFinished = localNamespace getVariable ["KISKA_missionParams_preloadFinished",false];
if (isServer) then {
    {
        if (!_preloadFinished OR {!([_x >> "requiresRestart"] call BIS_fnc_getCfgDataBool)}) then {
            _serialConfig = [_x] call KISKA_fnc_paramsMenu_serializeConfig;
            [_serialConfig,_y] remoteExecCall ["KISKA_fnc_paramsMenu_paramChanged", 0, [_serialConfig] call KISKA_fnc_paramsMenu_getJIPQueueId];
        };
    } forEach (GET_STAGED_CHANGE_PARAMS_HASH);

} else {
    {
        if (!_preloadFinished OR {!([_x >> "requiresRestart"] call BIS_fnc_getCfgDataBool)}) then {
            _serialConfig = [_x] call KISKA_fnc_paramsMenu_serializeConfig;
            [_serialConfig,_y] remoteExecCall ["KISKA_fnc_paramsMenu_paramChangedRemote", 2];
        };
    } forEach (GET_STAGED_CHANGE_PARAMS_HASH);
};

localNamespace setVariable [STAGED_CHANGE_VAR_HASH_VAR_STR,createHashMap];
["Changes sent, wait for complete notice..."] call KISKA_fnc_paramsMenu_logMessage;

nil

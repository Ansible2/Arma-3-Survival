#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_paramChangedRemote

Description:
    Acts as a go between for any admin that is setting parameters remotely on a server.

Instead of the admin sending the networked info, it first is sent to the server and then
     sent to all other machines.

Parameters:
	0: _paramSerial : <NUMBER> - The serialized param config
    1: _newValue : <NUMBER, STRING, or BOOL> - The updated value to set

Returns:
	NOTHING

Examples:
    (begin example)
        [_paramSerial,_newValue] remoteExecCall ["KISKA_fnc_paramsMenu_paramChangedRemote", 2];
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_paramChangedRemote";


params [
    ["_paramSerial",-1,[123]],
    ["_newValue",-1,[123,"",true]]
];

[_paramSerial,_newValue] remoteExec ["KISKA_fnc_paramsMenu_paramChanged", 0, [_paramSerial] call KISKA_fnc_paramsMenu_getJIPQueueId];


nil

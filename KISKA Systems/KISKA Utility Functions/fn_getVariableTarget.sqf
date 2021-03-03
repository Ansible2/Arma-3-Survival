/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getVariableTarget

Description:
	Gets a variable from a remote target object, id, group, or string (uses remoteExec targets)

	Takes a bit of time and therefore needs to be scheduled.

Parameters:
	0: _variableName : <STRING> - The string name of the varaible to get
	1: _namespace : <NAMESPACE, OBJECT, STRING, GROUP, CONTROL, or LOCATION> - The namespace to get the variable from
	2: _defaultValue : <ANY> - If the variable does not exist for the target, what should be returned instead
	3: _target : <NUMBER, OBJECT, GROUP, or STRING> - Where the _target is local will be where the variable is taken from

Returns:
	<ANY> - Whatever the variable is, nil otherwise

Examples:
    (begin example)
		[] spawn {
			// need to call for direct return
			_serversSomeVariable = ["someVariable",missionNamespace,"",2] call KISKA_fnc_getVariableTarget;
		};
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_getVariableTarget";

if (!canSuspend) exitWith {
	["Must be run in scheduled environment",true] call KISKA_fnc_log;
	nil
};

params [
	["_variableName","",[""]],
	["_namespace",missionNamespace,[missionNamespace,objNull,grpNull,"",controlNull,locationNull]],
	["_defaultValue",-1],
	["_target",2,[123,objNull,grpNull,""]]
];

if (_variableName isEqualTo "") exitWith {
	["_variableName is empty",true] call KISKA_fnc_log;
	nil
};


// create a unique variable ID for network tranfer
private _messageNumber = missionNamespace getVariable ["KISKA_getVarTargetQueue_count",0];
_messageNumber = _messageNumber + 1;
missionNamespace setVariable ["KISKA_getVarTargetQueue_count",_messageNumber];
private _saveVariable = ["KISKA_GVT",clientOwner,"_",_messageNumber] joinString "";


[_namespace,_variableName,_saveVariable,_defaultValue,clientOwner] remoteExecCall ["KISKA_fnc_getVariableTarget_sendBack",_target];

waitUntil {
	if (!isNil {missionNamespace getVariable _saveVariable}) exitWith {
		[["Got variable ",_saveVariable," from target ",_target],false] call KISKA_fnc_log;
		true
	};
	sleep 0.25;
	[["Waiting for variable from target: ",_target],false] call KISKA_fnc_log;
	false
};

private _return = missionNamespace getVariable _saveVariable;
missionNamespace setVariable [_saveVariable,nil]; 


_return
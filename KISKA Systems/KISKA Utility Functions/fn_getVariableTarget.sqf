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
	4: _saveVariable : <STRING> - A unique string name for the variable to be saved in 
	 (this is available only to machine where this function was called) 
	 if nothing is defined, a unique one is generated

Returns:
	<ANY> - Whatever the variable is

Examples:
    (begin example)
		null = [] spawn {
			// need to call for direct return
			_serversSomeVariable = ["someVariable",missionNamespace,"",2] call KISKA_fnc_getVariableTarget;
		};

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_getVariableTarget";

if (!canSuspend) exitWith {
	"KISKA_fnc_getVariableTarget: must be run scheduled" call BIS_fnc_error;
	-1
};

params [
	["_variableName","",[""]],
	["_namespace",missionNamespace,[missionNamespace,objNull,grpNull,"",controlNull,locationNull]],
	["_defaultValue",-1],
	["_target",2,[123,objNull,grpNull,""]],
	["_saveVariable","",[""]]
];

if (_variableName isEqualTo "") exitWith {
	"KISKA_fnc_getVariableTarget: _variableName is empty string ''" call BIS_fnc_error;
};
if (_saveVariable isEqualTo "") then {
	_saveVariable = "KISKA_getVariableTarget_" + _variableName;
};

[_namespace,_variableName,_saveVariable,_defaultValue,clientOwner] remoteExecCall ["KISKA_fnc_getVariableTarget_sendBack",_target];

waitUntil {
	if (!isNil {missionNamespace getVariable _saveVariable}) exitWith {
		diag_log ("KISKA_fnc_getVariableTarget: Got variable " + _saveVariable + " from target");
		true
	};
	sleep 0.25;
	diag_log "KISKA_fnc_getVariableTarget: Waiting for variable from target";
	false
};

private _return = missionNamespace getVariable _saveVariable;
missionNamespace setVariable [_saveVariable,nil]; // set to nil so that any other requesters don't get a duplicate

_return
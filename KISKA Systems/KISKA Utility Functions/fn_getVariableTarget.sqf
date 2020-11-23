if (!canSuspend) exitWith {
	"KISKA_fnc_getVariableTarget: must be run scheduled" call BIS_fnc_error;
};

params [
	["_variableName","",[""]],
	["_namespace",missionNamespace,[missionNamespace,objNull,grpNull,"",controlNull,locationNull]],
	["_target",2,[123,objNull,grpNull,""]],
	["_defaultValue",nil],
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
		diag_log "KISKA_fnc_getVariableTarget: Got variable " + _saveVariable + " from target";
		true
	};
	sleep 0.5;
	diag_log "KISKA_fnc_getVariableTarget: Waiting for variable from target";
	false
};

private _return = missionNamespace getVariable _saveVariable;
missionNamespace setVariable [_saveVariable,nil];


_return
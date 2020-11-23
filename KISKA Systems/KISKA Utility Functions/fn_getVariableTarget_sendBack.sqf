params ["_namespace","_variableName","_saveVariable","_defaultValue","_sendBackTarget"];

private _variable = _namespace getVariable [_variableName,_defaultValue];

if (_sendBackTarget isEqualTo 0) then {
	if (remoteExecutedOwner isEqualTo 0) then { // never broadcast to all clients
		missionNamespace setVariable [_saveVariable,_variable];
		
		diag_log "KISKA_fnc_getVariableTarget_sendBack: Did not send back to 0 target, saved locally";
		diag_log "_saveVariable" + (str _saveVariable);
		diag_log "_variable" + (str _variable);
	} else {
		missionNamespace setVariable [_saveVariable,_variable,remoteExecutedOwner];
		
		diag_log "KISKA_fnc_getVariableTarget_sendBack: Sent variable back";
		diag_log "_saveVariable" + (str _saveVariable);
		diag_log "_variable" + (str _variable);
		diag_log "remoteExecutedOwner" + (str remoteExecutedOwner);
	};
} else {
	missionNamespace setVariable [_saveVariable,_variable,_sendBackTarget];

	diag_log "KISKA_fnc_getVariableTarget_sendBack: Sent variable back";
	diag_log "_saveVariable" + (str _saveVariable);
	diag_log "_variable" + (str _variable);
	diag_log "_sendBackTarget" + (str _sendBackTarget);
};
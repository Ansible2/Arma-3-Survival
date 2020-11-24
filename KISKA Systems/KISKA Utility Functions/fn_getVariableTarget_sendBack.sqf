params ["_namespace","_variableName","_saveVariable","_defaultValue","_sendBackTarget"];
private _getVariableValue = _namespace getVariable [_variableName,_defaultValue];

if (_sendBackTarget isEqualTo 0) then {
	if (remoteExecutedOwner isEqualTo 0) then { // never broadcast to all clients
		missionNamespace setVariable [_saveVariable,_getVariableValue];
		
		diag_log "KISKA_fnc_getVariableTarget_sendBack: Did not send back to 0 target, saved locally";
		diag_log ("_saveVariable: " + _saveVariable);
		diag_log ("_getVariableValue: " + (str _getVariableValue));
	} else {
		missionNamespace setVariable [_saveVariable,_getVariableValue,remoteExecutedOwner];
		
		diag_log "KISKA_fnc_getVariableTarget_sendBack: Sent variable back";
		diag_log ("_saveVariable: " + _saveVariable);
		diag_log ("_getVariableValue: " + (str _getVariableValue));
		diag_log ("remoteExecutedOwner: " + (str remoteExecutedOwner));
	};
} else {
	// setVariable with a public flag of 2 in singleplayer does not work
	if (!isMultiplayer AND {_sendBackTarget isEqualTo 2}) then { 
		_sendBackTarget = 0;
	};
	missionNamespace setVariable [_saveVariable,_getVariableValue,_sendBackTarget];

	diag_log "KISKA_fnc_getVariableTarget_sendBack: Sent variable back";
	diag_log ("_saveVariable: " + _saveVariable);
	diag_log ("_getVariableValue: " + (str _getVariableValue));
	diag_log ("_sendBackTarget: " + _sendBackTarget);
};
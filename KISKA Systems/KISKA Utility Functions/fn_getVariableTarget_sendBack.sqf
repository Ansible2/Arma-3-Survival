/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getVariableTarget

Description:
	The send back component of KISKA_fnc_getVariableTarget that is executed on the target.

	Shouldn't be called on its own

Parameters:
	0: _namespace : <NAMESPACE, OBJECT, STRING, GROUP, CONTROL, or LOCATION> - The namespace to get the variable from 
	1: _variableName : <STRING> - The string name of the varaible to get
	2: _saveVariable : <STRING> - A unique string name for the variable to be saved in on the sender's machine
	3: _defaultValue : <ANY> - If the variable does not exist for the target, what should be returned instead
	4: _sendBackTarget : <ANY> - The clientOwner id of whoever sent the request

Returns:
	NOTHING

Examples:
    (begin example)
		[_namespace,_variableName,_saveVariable,_defaultValue,clientOwner] remoteExecCall ["KISKA_fnc_getVariableTarget_sendBack",_target];
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_getVariableTarget_sendBack";

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
	diag_log ("_sendBackTarget: " + (str _sendBackTarget));
};
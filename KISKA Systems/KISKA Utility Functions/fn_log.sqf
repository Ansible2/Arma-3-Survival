/* ----------------------------------------------------------------------------
Function: KISKA_fnc_log

Description:
	Prints a log with a script name to console

Parameters:
	0: _scriptName <STRING> - The name of the script from where this message is being called
	1: _message <ANY> - The message to send. If array and _joinString is true, will be used with the joinString command
	2: _joinString <BOOL> - Should this message joined into a string if an array

Returns:
	<ANY> - The message sent

Examples:
    (begin example)
		private _myvar = 1;
		["myScript",["Hello Number",_myvar]] call KISKA_fnc_updateRespawnMarker;

		- prints "Hello Number 1" to console
    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_scriptName","",[""]],
	["_message","",[]],
	["_joinString",true,[true]]
];

diag_log ("KISKA Log......: " + _scriptName);
if (_message isEqualType [] AND {_joinString}) then {
	_message = _message joinString " ";
};

diag_log _message;


_message
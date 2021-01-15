/* ----------------------------------------------------------------------------
Function: KISKA_fnc_log

Description:
	Prints a log with a script name to console.

	Whether or not something is logged depends on whether the script is set in
	 the KISKA_logScripts array. If the script name (or "all") is found in the array
	 a log is printed.

Parameters:
	0: _scriptName <STRING> - The name of the script from where this message is being called
	1: _message <ANY> - The message to send. If array and _joinString is true, will be used with the joinString command
	2: _joinString <BOOL> - Should this message joined into a string if an array
	3: _logWithError <BOOL> - Show error message on screen (BIS_fnc_error)
	4: _forceLog <BOOL> - Print log regardless of KISKA_logScripts content

Returns:
	<ANY> - The message sent

Examples:
    (begin example)
		missionNamespace setVariable ["KISKA_doLog",true];
		private _myvar = 1;
		["myScript",["Hello Number",_myvar],true,false,true] call KISKA_fnc_log;

		- prints "Hello Number 1" to console
    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(missionNamespace getVariable ["KISKA_doLog",false]) exitWith {};

params [
	["_scriptName","",[""]],
	["_message","",[]],
	["_joinString",true,[true]],
	["_logWithError",missionNamespace getVariable ["KISKA_logWithError",false],[true]],
	["_forceLog",false,[true]]
];

if !(_forceLog) then {
	// set _forceLog to true if the scripts name is in the log array KISKA_logScripts
	_forceLog = [
		missionNamespace getVariable ["KISKA_logScripts",["all"]],
		{
			_x == "all" OR {_x == (_thisArgs select 0)}
		},
		[_scriptName]
	] call KISKA_fnc_findIfBool;
};

if !(_forceLog) exitWith {};

// only start a new header message with script name when another script interrupts
private _currentLoggedScript = missionNamespace getVariable ["KISKA_currentLoggedScript",""];
if (_currentLoggedScript != _scriptName) then {
	missionNamespace setVariable ["KISKA_currentLoggedScript",_scriptName];
	diag_log ("KISKA Start Logging Script......................: " + _scriptName);
};

if (_message isEqualType [] AND {_joinString}) then {
	_message = _message joinString " ";
};

diag_log _message;

if (_logWithError) then {
	(_scriptName + " : " + _message) call BIS_fnc_error;
};


_message
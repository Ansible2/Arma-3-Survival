/* ----------------------------------------------------------------------------
Function: KISKA_fnc_log

Description:
	Prints a log with a script name to console.

	Whether or not something is logged depends on whether the script is set in
	 the KISKA_logScripts array. If the script name (or "all") is found in the array
	 a log is printed.

Parameters:
	0: _message <ANY> - The message to send. If array and _joinString is true, will be used with the joinString command
	1: _logWithError <BOOL> - Show error message on screen (BIS_fnc_error)
	2: _forceLog <BOOL> - Print log regardless of KISKA_logScripts content
	3: _joinString <BOOL> - Should this message joined into a string if an array
	4: _scriptName <STRING> - The name of the script from where this message is being called

Returns:
	<ANY> - The message sent

Examples:
    (begin example)
		missionNamespace setVariable ["KISKA_doLog",true];
		scriptName "My Script";
		private _myvar = 1;
		[["Hello Number",_myvar]] call KISKA_fnc_log;

		- prints ["My Script"] "Hello Number 1" to console
    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(missionNamespace getVariable ["KISKA_doLog",true]) exitWith {};

params [
	["_message","",[]],
	["_logWithError",missionNamespace getVariable ["KISKA_logWithError",false],[true]],
	["_forceLog",true,[true]],
	["_joinString",true,[true]],
	["_scriptName","",[""]]
];

if (_scriptName == "" AND {!isNil "_fnc_scriptNameParent"}) then {
	_scriptName = _fnc_scriptNameParent;
};

if !(_forceLog) then {
	// set _forceLog to true if the scripts name is in the log array KISKA_logScripts
	private _scripts = missionNamespace getVariable ["KISKA_logScripts",["all"]];
	if ("all" in _scripts OR {(toLowerANSI _scriptName) in _scripts}) then {
		_forceLog = true;
	};
};

if !(_forceLog) exitWith {};

// only start a new header message with script name when another script interrupts
private _currentLoggedScript = missionNamespace getVariable ["KISKA_currentLoggedScript",""];
if (_currentLoggedScript != _scriptName) then {
	missionNamespace setVariable ["KISKA_currentLoggedScript",_scriptName];
	diag_log ("--------- KISKA Log " + _scriptName + " ---------");
};

if (_message isEqualType [] AND {_joinString}) then {
	_message = _message joinString "";
};

diag_log ("[" + _scriptName + "] " + _message);

if (_logWithError) then {
	(_scriptName + " : " + _message) call BIS_fnc_error;
};


_message
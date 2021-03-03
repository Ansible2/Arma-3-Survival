/* ----------------------------------------------------------------------------
Function: KISKA_fnc_stopMusic

Description:
	Stops the currently playing music with a fade if desired.

Parameters:
	0: _fadeTime <NUMBER> - How long to fade out

Returns:
	NOTHING

Examples:
    (begin example)

		call KISKA_fnc_stopMusic;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "KISKA_fnc_stopMusic"
scriptName SCRIPT_NAME;

if (!hasInterface) exitWith {};

if (!canSuspend) exitWith {
	["Was not run in scheduled environment, executing in scheduled...",true] call KISKA_fnc_log;
	_this spawn KISKA_fnc_stopMusic;
};

params [
	["_fadeTime",3,[123]]
];

if !(call KISKA_fnc_isMusicPlaying) exitWith {};

if (_fadeTime > 0) then {
	_fadeTime fadeMusic 0;
};
playMusic "";

// reset event handler values as playMusic "" does not activate music events
call KISKA_fnc_musicStopEvent;
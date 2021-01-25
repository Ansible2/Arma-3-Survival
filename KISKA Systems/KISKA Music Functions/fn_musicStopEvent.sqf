/* ----------------------------------------------------------------------------
Function: KISKA_fnc_musicStopEvent

Description:
	The function that should be activated when music stops playing.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call KISKA_fnc_musicStopEvent;
    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "KISKA_fnc_musicStopEvent"
scriptName SCRIPT_NAME;

if (!hasInterface) exitWith {};

["Music stopped",false] call KISKA_fnc_log;

missionNamespace setVariable ["KISKA_musicPlaying",false];
missionNamespace setVariable ["KISKA_currentTrack",""];
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
scriptName "KISKA_fnc_musicStopEvent";

if (!hasInterface) exitWith {};

diag_log "music stop";

KISKA_musicPlaying = false;
KISKA_currentTrack = "";
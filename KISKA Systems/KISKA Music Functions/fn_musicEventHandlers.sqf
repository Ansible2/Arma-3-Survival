/* ----------------------------------------------------------------------------
Function: KISKA_fnc_musicEventHandlers

Description:
	A preInit function to create the required music event handlers for 
	 KISKA music functions

Parameters:
	NONE

Returns:
	NONE

Examples:
    (begin example)

		PREINIT FUNCTION

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "KISKA_fnc_musicEventHandlers"
scriptName SCRIPT_NAME;

if (!hasInterface) exitWith {};

["Added KISKA music event handlers",false] call KISKA_fnc_log;

addMusicEventHandler ["MusicStart", {
	_this call KISKA_fnc_musicStartEvent;
}];


addMusicEventHandler ["MusicStop", {
	call KISKA_fnc_musicStopEvent;
}];
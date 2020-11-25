/* ----------------------------------------------------------------------------
Function: KISKA_fnc_musicEventHandlers

Description:
	A preInit function to create the required music event handlers for KISKA music functions

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
if (!hasInterface) exitWith {};

addMusicEventHandler ["MusicStart", {
	_this call KISKA_fnc_musicStartEvent;
}];


addMusicEventHandler ["MusicStop", {
	call KISKA_fnc_musicStopEvent;
}];
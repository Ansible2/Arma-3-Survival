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
	params [
		["_trackClassName","",[""]]
	];
	diag_log "music start";

	KISKA_musicPlaying = true;
	KISKA_currentTrack = _trackClassName;
}];


addMusicEventHandler ["MusicStop", {
	diag_log "music stop";
	KISKA_musicPlaying = false;
	KISKA_currentTrack = "";
}];
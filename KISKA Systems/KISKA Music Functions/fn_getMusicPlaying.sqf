/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getMusicPlaying

Description:
	Returns the current playing tracks class name. 

Parameters:
	NONE

Returns:
	<STRING> - The class name of music. Will be "" if nonthing is playing.

Examples:
    (begin example)

		call KISKA_fnc_getMusicPlaying;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
private _track = missionNamespace getVariable ["KISKA_currentTrack",""];

_track
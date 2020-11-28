/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getCurrentRandomMusicTrack

Description:
	Returns the most recent track selected by the random music system.
	Will be an empty string "" if none is defined.

	This is regardless of whether the song is actually playing.

Parameters:
	NONE

Returns:
	<STRING> - The current randomly selected track

Examples:
    (begin example)

		_mostRecentRandomTrack = call KISKA_fnc_getCurrentRandomMusicTrack;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_getCurrentRandomMusicTrack";

private _return = missionNamespace getVariable ["KISKA_currentRandomTrack",""];

_return
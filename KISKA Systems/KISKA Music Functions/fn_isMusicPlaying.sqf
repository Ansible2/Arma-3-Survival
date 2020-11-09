/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getMusicPlaying

Description:
	Returns the classname of the music that is currently playing

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call KISKA_fnc_getMusicPlaying;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
private _musicPlaying = missionNameSpace getVariable ["KISKA_musicPlaying",false];

_musicPlaying
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_setCurrentRandomMusicTrack

Description:
	Sets the current random track from the random music system.

Parameters:
	0: _trackClass <STRING> - a classname to check the duration of or its config path

Returns:
	<STRING> - The current randomly selected track

Examples:
    (begin example)

		_mostRecentRandomTrack = call KISKA_fnc_setCurrentRandomMusicTrack;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_setCurrentRandomMusicTrack";

params [
	["_trackClass","",[""]]
];

missionNamespace setVariable ["KISKA_currentRandomTrack",_trackClass];


true
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_musicStartEvent

Description:
	The function that should be activated when music starts playing.

Parameters:
	0: _trackClassname <STRING> - The classname of the track that started playing

Returns:
	NOTHING

Examples:
    (begin example)

		["trackThatStarted"] call KISKA_fnc_musicStartEvent;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_musicStartEvent";

if (!hasInterface) exitWith {};

params [
	["_trackClassname","",[""]]
];

diag_log "music start";

missionNamespace setVariable ["KISKA_musicPlaying",true];
missionNamespace setVariable ["KISKA_currentTrack",_trackClassName];
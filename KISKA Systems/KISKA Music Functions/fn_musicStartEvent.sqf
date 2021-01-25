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
#define SCRIPT_NAME "KISKA_fnc_musicStartEvent"
scriptName SCRIPT_NAME;

if (!hasInterface) exitWith {};

params [
	["_trackClassname","",[""]]
];

["Music Started",false] call KISKA_fnc_log;

missionNamespace setVariable ["KISKA_musicPlaying",true];
missionNamespace setVariable ["KISKA_currentTrack",_trackClassName];
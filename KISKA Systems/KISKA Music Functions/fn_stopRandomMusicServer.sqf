/* ----------------------------------------------------------------------------
Function: KISKA_fnc_stopRandomMusicServer

Description:
	Stops the random music system either abrubtly or allows the last song to play.

Parameters:
	0: _playLastSong <BOOL> - Should the last song play or not

Returns:
	<BOOL> - True if done, false if nothing done

Examples:
    (begin example)

		call KISKA_fnc_stopRandomMusicServer;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "KISKA_fnc_stopRandomMusicServer"
scriptName SCRIPT_NAME;

if (!isServer) exitWith {
	["Needs to only be run on server, exiting...",true] call KISKA_fnc_log;
	false
};

params [
	["_playLastSong",false,[true]]
];

missionNamespace setVariable ["KISKA_musicSystemIsRunning",false];
if (!_playLastSong) then {
	remoteExecCall ["KISKA_fnc_stopRandomMusicClient",[0,-2] select isDedicated];
};

true
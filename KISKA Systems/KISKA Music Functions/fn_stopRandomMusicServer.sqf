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
scriptName "KISKA_fnc_stopRandomMusicServer";

if (!isServer) exitWith {
	"Random music system needs to be stopped on the server" call BIS_fnc_error;
	false
};

params [
	["_playLastSong",false,[true]]
];

missionNamespace setVariable ["KISKA_musicSystemIsRunning",false];
if (!_playLastSong) then {
	null = remoteExec ["KISKA_fnc_stopRandomMusicClient",[0,-2] select isDedicated];
};

true
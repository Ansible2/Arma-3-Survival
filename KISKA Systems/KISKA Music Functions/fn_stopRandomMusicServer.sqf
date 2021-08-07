#include "Headers\Music Common Defines.hpp"
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
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_stopRandomMusicServer";

if (!isServer) exitWith {
	["Needs to only be run on server, exiting...",true] call KISKA_fnc_log;
	false
};

params [
	["_playLastSong",false,[true]]
];

SET_MUSIC_VAR(MUSIC_RANDOM_SYS_RUNNING_VAR_STR,false);
SET_MUSIC_VAR(GET_MUSIC_RANDOM_START_TIME,nil);
if (!_playLastSong) then {
	remoteExecCall ["KISKA_fnc_stopRandomMusicClient",[0,-2] select isDedicated];
};

true

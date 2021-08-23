#include "Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_setRandomMusicTime

Description:
	Sets the dwell time variable that handles the time between random music tracks
     being played.

Parameters:
    0: _timeBetween <ARRAY or NUMBER> - A random or set time between tracks.
        Formats are [min,mid,max] & [max] for random numbers and just a single
         number for a set time between.

Returns:
	NOTHING

Examples:
    (begin example)
		[20] call KISKA_fnc_setRandomMusicTime;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_setRandomMusicTime";

if (!isServer) exitWith {
    ["Needs to be executed on the server, remoting to server...",true] call KISKA_fnc_log;
    _this remoteExecCall ["KISKA_fnc_setRandomMusicTime",2];
    nil
};

params [
	["_timeBetween",3,[123,[]]]
];

SET_MUSIC_VAR(MUSIC_RANDOM_TIME_BETWEEN_VAR_STR,_timeBetween);


nil

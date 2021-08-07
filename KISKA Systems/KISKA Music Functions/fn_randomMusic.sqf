#include "Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic

Description:
	Starts playing a random assortment of curated music tracks to all players on a server.
	This is essentially a multipleyer jukebox. Should only be executed on the server.

	All songs will be played in a random order and then loop back to play in another random order infinitely.

	It will not interrupt music commanded to play by other means.

	You can define quiet time space between tracks.

Parameters:
	0: _playedFromLoop <BOOL> - Used to check if this was just called from the random music loop (won't interrupt the current iteration if so)
	//1: _lastPlayedTrack <STRING> - The track that was last being played. Used to be able to interrupt a song if the random music is out of sync
	2: _musicTracks <ARRAY> - An array of strings (music tracks) to use
	3: _timeBetween <ARRAY or NUMBER> - A random or set time between tracks. Formats are [min,mid,max] & [max] for random numbers and just a single number for a set time between (see example)
	4: _usedMusicTracks <ARRAY> - An array of already used music tracks, don't bother manually entering anyhting, this is for looping purposes

Returns:
	NOTHING

Examples:
    (begin example)
		// space tracks by 20 seconds exactly each
		[-1,"",arrayOfTracks,20] spawn KISKA_fnc_randomMusic;
   	(end)

	(begin example)
		// space tracks by UP TO 20 seconds each
		[-1,"",arrayOfTracks,[20]] spawn KISKA_fnc_randomMusic;
   	(end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic";

#define SLEEP_BUFFER 3

if !(isServer) exitWith {
	["Was not executed on server, exiting...",true] call KISKA_fnc_log;
	nil
};

if (!canSuspend) exitWith {
	["Was not executed in a scheduled environment, exiting...",true] call KISKA_fnc_log;
	nil
};


/* ----------------------------------------------------------------------------
	Params
---------------------------------------------------------------------------- */
params [
	["_tickId",-1,[123]],
	//["_lastPlayedTrack","",[""]],
	["_musicTracks",GET_MUSIC_RANDOM_UNUSED_TRACKS,[[]]],
	["_timeBetween",GET_MUSIC_RANDOM_TIME_BETWEEN,[[],123]],
	["_usedMusicTracks",GET_MUSIC_RANDOM_USED_TRACKS,[[]]]
];

private _latestTickID = GET_MUSIC_RANDOM_START_TIME;
private _isNewLoop = _tickId isEqualTo -1;
if ((!_isNewLoop) AND (_tickId < _latestTickID)) exitWith {
	[["Tick ID: ",_tickId," was thrown out in favor of ID: ",_latestTickID],false] call KISKA_fnc_log;
	nil
};


if (_musicTracks isEqualTo [] AND {_usedMusicTracks isEqualTo []}) exitWith {
	["No music tracks were passed! Can't start.",true] call KISKA_fnc_log;
	nil
};

// check if _timeBetween is an array AND if it is the correct formats OR if it is just a single number
if (
		(_timeBetween isEqualType []) AND
		{
			!((count _timeBetween) isEqualTo 1) AND
			{
				!((count _timeBetween) isEqualTo 3) OR !(_timeBetween isEqualTypeParams [1,2,3])
			}
		}
	) exitWith {
	[[_timeBetween," is not the correct format for _timeBetween"],true] call KISKA_fnc_log;
	nil
};


/* ----------------------------------------------------------------------------
	Select & Play Track
---------------------------------------------------------------------------- */
if (_musicTracks isEqualTo []) then {
	_musicTracks = +_usedMusicTracks;
	_usedMusicTracks = [];
};
private _selectedTrack = selectRandom _musicTracks;


private _targetId = [0,-2] select isDedicated;
// volume is at 0.5 because ambient tracks should be a bit less pronounced
[_selectedTrack,0,false,0.5,3,true] remoteExec ["KISKA_fnc_playMusic",_targetId];
//[_selectedTrack] remoteExecCall ["KISKA_fnc_setCurrentRandomMusicTrack",_targetId];

if !(GET_MUSIC_RANDOM_MUSIC_SYS_RUNNING) then {
	SET_MUSIC_VAR(MUSIC_RANDOM_SYS_RUNNING_VAR_STR,true);
};


/* ----------------------------------------------------------------------------
	Cleanup
---------------------------------------------------------------------------- */
// clear array of selected Track
_musicTracks deleteAt (_musicTracks find _selectedTrack);
SET_MUSIC_VAR(MUSIC_RANDOM_UNUSED_TRACKS_VAR_STR,_musicTracks);
// store track as used
_usedMusicTracks pushBackUnique _selectedTrack;
SET_MUSIC_VAR(MUSIC_RANDOM_USED_TRACKS_VAR_STR,_usedMusicTracks);


/* ----------------------------------------------------------------------------
	Get Wait Time
---------------------------------------------------------------------------- */
private _durationOfTrack = [_selectedTrack] call KISKA_fnc_getMusicDuration;
// decide how much time should be between tracks
private "_randomWaitTime";
if (_timeBetween isEqualType []) then {
	if (_timeBetween isEqualTypeArray [1,2,3]) then {
		_randomWaitTime = round (random _timeBetween);
	} else {
		_randomWaitTime = round (random (_timeBetween select 0));
	};
} else {
	_randomWaitTime = _timeBetween;
};

// update to new timebetween if needed
if ((GET_MUSIC_RANDOM_TIME_BETWEEN) isNotEqualTo _timeBetween) then {
	SET_MUSIC_VAR(MUSIC_RANDOM_TIME_BETWEEN_VAR_STR,_timeBetween);
};


// track durations are not (always) exact enough, so there needs to be a bit of a buffer
// else, if the time between tracks is something like 0 or 1, the sleep will be done,
// and music will try to play, but because it does not interrupt,
// and the previous track will not actually be done, no music will play until the next sleep is done
if (_randomWaitTime < SLEEP_BUFFER) then {
	_randomWaitTime = SLEEP_BUFFER;
};
private _waitTime = _durationOfTrack + _randomWaitTime;


/* ----------------------------------------------------------------------------
	Sleep till next track
---------------------------------------------------------------------------- */
/*
	this is used with the intention of if another random music list is started (or multiple)
	the latest one will take over this time slot forcing the others after their wait time to
	not continue their own loops
*/

if (_isNewLoop) then {
	_tickId = diag_tickTime;
	SET_MUSIC_VAR(MUSIC_RANDOM_START_TIME_VAR_STR,_tickId);
};
sleep _waitTime;

[_tickId] spawn KISKA_fnc_randomMusic;


nil

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
	1: _lastPlayedTrack <STRING> - The track that was last being played. Used to be able to interrupt a song if the random music is out of sync
	2: _musicTracks <ARRAY> - An array of strings (music tracks) to use
	3: _timeBetween <ARRAY or NUMBER> - A random or set time between tracks. Formats are [min,mid,max] & [max] for random numbers and just a single number for a set time between (see example)
	4: _usedMusicTracks <ARRAY> - An array of already used music tracks, don't bother manually entering anyhting, this is for looping purposes

Returns:
	NOTHING 

Examples:
    (begin example)
		
		// space tracks by 20 seconds exactly each
		[false,"",arrayOfTracks,20] spawn KISKA_fnc_randomMusic;

   	(end)

	(begin example)
		
		// space tracks by UP TO 20 seconds each
		[false,"",arrayOfTracks,[20]] spawn KISKA_fnc_randomMusic; 

   	(end)

	Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SLEEP_BUFFER 3
#define SCRIPT_NAME "KISKA_fnc_randomMusic"
scriptName SCRIPT_NAME;

if !(isServer) exitWith {
	["Was not executed on server, exiting...",true] call KISKA_fnc_log;
};

if (!canSuspend) exitWith {
	["Was not executed in a scheduled environment, exiting...",true] call KISKA_fnc_log;
};

params [
	["_playedFromLoop",false,[true]],
	["_lastPlayedTrack","",[""]],
	["_musicTracks",missionNamespace getVariable ["KISKA_randomMusic_tracks",[]],[[]]],
	["_timeBetween",missionNamespace getVariable ["KISKA_randomMusic_timeBetween",[300,420,540]],[[],123]],
	["_usedMusicTracks",missionNamespace getVariable ["KISKA_randomMusic_usedTracks",[]],[[]]]
];

if (_musicTracks isEqualTo [] AND {_usedMusicTracks isEqualTo []}) exitWith {
	["No music tracks were passed! Can't start.",true] call KISKA_fnc_log;
};

// check if _timeBetween is an array AND if it is the correct formats OR if it is just a single number
if ((_timeBetween isEqualType []) AND {!((count _timeBetween) isEqualTo 1) AND {!((count _timeBetween) isEqualTo 3) OR !(_timeBetween isEqualTypeParams [1,2,3])}}) exitWith {
	[[_timeBetween," is not the correct format for _timeBetween"],true] call KISKA_fnc_log;
};

if (_musicTracks isEqualTo []) then {
	_musicTracks = _usedMusicTracks;
	_usedMusicTracks = [];
};

private _selectedTrack = selectRandom _musicTracks;

/*
	if the window becomes unfocused, the sleeps can become out of sync.
	this use of _doInterrupt is used to guarantee a track starts playing on time if things are 
	slightly out of sync, since it can interrupt the previous music
*/
private _doInterrupt = !(_playedFromLoop);
if !(isDedicated) then {
	if (!_doInterrupt AND {_lastPlayedTrack == (call KISKA_fnc_getMusicPlaying)}) then {
		_doInterrupt = true;
	};
};

// play song
private _targetId = [0,-2] select isDedicated;
// volume is at 0.5 because ambient tracks should be a bit less pronounced
[_selectedTrack,0,_doInterrupt,0.5] remoteExec ["KISKA_fnc_playMusic",_targetId];
[_selectedTrack] remoteExecCall ["KISKA_fnc_setCurrentRandomMusicTrack",_targetId];

if !(missionNamespace getVariable ["KISKA_musicSystemIsRunning",false]) then {
	missionNamespace setVariable ["KISKA_musicSystemIsRunning",true];
};

// clear array of selected Track
_musicTracks deleteAt (_musicTracks find _selectedTrack);
KISKA_randomMusic_tracks = _musicTracks;
// store track as used
_usedMusicTracks pushBackUnique _selectedTrack;
KISKA_randomMusic_usedTracks = _usedMusicTracks;

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

// update timebetween if needed
if !((missionNamespace getVariable ["KISKA_randomMusic_timeBetween",[300,420,540]]) isEqualTo _timeBetween) then {
	KISKA_randomMusic_timeBetween = _timeBetween;
};

/*
	track durations are not (always) exact enough, so there needs to be a bit of a buffer
	else, if the time between tracks is something like 0 or 1, the sleep will be done, 
	and music will try to play, but because it does not interrupt,
	and the previous track will not actually be done, no music will play until the next sleep is done
*/
if (_randomWaitTime < SLEEP_BUFFER) then {
	_randomWaitTime = SLEEP_BUFFER;
};

private _waitTime = _durationOfTrack + _randomWaitTime;

[
	
	[
		"Random wait time is:",
		_randomWaitTime,
		"--- Duration of tack is:",
		_durationOfTrack,
		"--- Wait time is:",
		_waitTime
	],
	false
] call KISKA_fnc_log;

// dont play this music if the system is stopped or another random music system was started
if (missionNamespace getVariable ["KISKA_musicSystemIsRunning",true]) then {
/*	
	this is used with the intention of if another random music list is started (or multiple)
	the latest one will take over this time slot forcing the others after their wait time to
	not continue their own loops
*/
	KISKA_randomMusicStartTIme = time;
	private _startTime = KISKA_randomMusicStartTIme;

	if (!isMultiplayer OR {isMultiplayerSolo}) then {
		sleep _waitTime;
	} else {	
		uiSleep _waitTime;
	};

	if (_startTime isEqualTo KISKA_randomMusicStartTIme) then {
		["Sleep has finished, executing new randomMusic",false] call KISKA_fnc_log;
		// the globals in params are not passed to allow for changes while music is playing
		[true,_selectedTrack] spawn KISKA_fnc_randomMusic; 
	};
};
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
		[arrayOfTracks,20] spawn KISKA_fnc_randomMusic;

   	(end)

	(begin example)
		
		// space tracks by UP TO 20 seconds each
		[arrayOfTracks,[20]] spawn KISKA_fnc_randomMusic; 

   	(end)

	Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SLEEP_BUFFER 3
if !(isServer) exitWith {
	"Must be run on server" call BIS_fnc_error;
};

params [
	["_playedFromLoop",false,[true]],
	["_lastPlayedTrack","",[""]],
	["_musicTracks",missionNamespace getVariable ["KISKA_randomMusic_tracks",[]],[[]]],
	["_timeBetween",missionNamespace getVariable ["KISKA_randomMusic_timeBetween",[300,420,540]],[[],123]],
	["_usedMusicTracks",missionNamespace getVariable ["KISKA_randomMusic_usedTracks",[]],[[]]]
];

if (_musicTracks isEqualTo [] AND {_usedMusicTracks isEqualTo []}) exitWith {
	"No music tracks were passed" call BIS_fnc_error;
};

// check if _timeBetween is an array AND if it is the correct formats OR if it is just a single number
if ((_timeBetween isEqualType []) AND {!((count _timeBetween) isEqualTo 1) AND {!((count _timeBetween) isEqualTo 3) OR !(_timeBetween isEqualTypeParams [1,2,3])}}) exitWith {
	"_timeBetween array is incorrect format or types" call BIS_fnc_error;
};

if (_musicTracks isEqualTo []) then {
	_musicTracks = _usedMusicTracks;
	_usedMusicTracks = [];
};

private _selectedTrack = selectRandom _musicTracks;


private _doInterrupt = !(_playedFromLoop);
if !(isDedicated) then {
	// if the window becomes unfocused, the sleeps can become out of sync.
	// this is used to guarantee a track starts playing on time if things are out of sync
	if (!_doInterrupt AND {_lastPlayedTrack == (call KISKA_fnc_getMusicPlaying)}) then {
		_doInterrupt = true;
	};
};

// play song
null = [_selectedTrack,0,_doInterrupt,0.5] remoteExec ["KISKA_fnc_playMusic",[0,-2] select isDedicated];

// if it is the intial running of the system
if (isNil "KISKA_musicSystemIntialized") then {
	KISKA_musicSystemIntialized = true;
};


// clear array of selected Track
_musicTracks deleteAt (_musicTracks findIf {_x isEqualTo _selectedTrack});
KISKA_randomMusic_tracks = _musicTracks;
// store track as used
_usedMusicTracks pushBackUnique _selectedTrack;
KISKA_randomMusic_usedTracks = _usedMusicTracks;

// get duration of track
private _durationOfTrack = getNumber (configFile >> "cfgMusic" >> _selectedTrack >> "duration");
if (_durationOfTrack isEqualTo 0) then {
	getNumber (missionConfigFile >> "cfgMusic" >> _selectedTrack >> "duration");
};

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
KISKA_randomMusic_timeBetween = _timeBetween; // store global

/*
	track durations are not exact enough, so there always need to be a bit of a buffer
	else, if the time between tracks is something like 0 or 1, the sleep will be done, 
	and music will try to play, but because it does not interrupt,
	and the previous track will not actually be done, no music will play until the next sleep is done
*/
if (_randomWaitTime < SLEEP_BUFFER) then {
	_randomWaitTime = SLEEP_BUFFER;
};

private _waitTime = _durationOfTrack + _randomWaitTime;

diag_log format ["random wait time is: %1",_randomWaitTime];
diag_log format ["duration of track is: %1",_durationOfTrack];
diag_log format ["wait time is: %1",_waitTime];
// dont play this music if the system is stopped or another random music system was started
if (KISKA_musicSystemIntialized) then {
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
		diag_log "Sleep done";
		// the globals in params are not passed to allow for changes while music is playing
		null = [true,_selectedTrack] spawn KISKA_fnc_randomMusic; 

		diag_log "execing next song";
	};
};
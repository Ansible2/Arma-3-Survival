/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic

Description:
	Starts playing a random assortment of curated music tracks to all players on a server.
	This is essentially a multipleyer jukebox. Should only be executed on the server.

	All songs will be played in a random order and then loop back to play in another random order infinitely. 
	
	It will not interrupt music commanded to play by other means.
	
	You can define quiet time space between tracks.

Parameters:

	0: _musicTracks <ARRAY> - An array of strings (music tracks) to use
	1: _timeBetween <ARRAY or NUMBER> - A random or set time between tracks. Formats are [min,mid,max] & [max] for random numbers and just a single number for a set time between (see example)
	2: _usedMusicTracks <ARRAY> - An array of already used music tracks, don't bother manually entering anyhting, this is for looping purposes

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
if !(isServer) exitWith {
	"Must be run on server" call BIS_fnc_error;
};

params [
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

// clear array of selected Track
_musicTracks deleteAt (_musicTracks findIf {_x isEqualTo _selectedTrack});
KISKA_randomMusic_tracks = _musicTracks;

// store track as used
_usedMusicTracks pushBackUnique _selectedTrack;
KISKA_randomMusic_usedTracks = _usedMusicTracks;

// get duration of track
private _durationOfTrack = getNumber (configFile >> "cfgMusic" >> _selectedTrack >> "duration");


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
KISKA_randomMusic_timeBetween = _timeBetween;


private "_waitTime";
// if it is the intial running of the system
if (isNil "KISKA_musicSystemIntialized") then {
	_waitTime = 0;
	KISKA_musicSystemIntialized = true;
} else {
	_waitTime = _durationOfTrack + _randomWaitTime;
};


// this is used with the intention of if another random music list is started (or multiple)
// the latest one will take over this time slot forcing the others after their wait time to
// not continue their own loops
KISKA_randomMusicStartTIme = time;
private _startTime = KISKA_randomMusicStartTIme;

sleep _waitTime;

// dont play this music if the system is stopped or another random music system was started
if (KISKA_musicSystemIntialized AND {_startTime == KISKA_randomMusicStartTIme}) then {
	null = [_selectedTrack,0,false,0.5] remoteExec ["KISKA_fnc_playMusic",[0,-2] select isDedicated];

	null = [] spawn KISKA_fnc_randomMusic;
};
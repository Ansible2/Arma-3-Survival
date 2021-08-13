#include "Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_playMusic

Description:
	Plays music with smooth fade between tracks. Must be run in scheduled environment (spawn)

Parameters:
	0: _track <STRING> - Music to play
	1: _startTime <NUMBER> - Starting time of music. -1 for random start time
	2: _canInterrupt <BOOL> - Interrupt playing music
	3: _volume <NUMBER> - Volume to play at
	4: _fadeTime <NUMBER> - Time to fade tracks down & up

Returns:
	NOTHING

Examples:
    (begin example)
		["track", 0, true, 1, 3] spawn KISKA_fnc_playMusic;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_playMusic";

if !(hasInterface) exitWith {};

if !(canSuspend) exitWith {
	["Wasn't run in scheduled environment, executing in scheduled",true] call KISKA_fnc_log;
	_this spawn KISKA_fnc_playMusic;
};


params [
	["_track","",[""]],
	["_startTime",0,[123]],
	["_canInterrupt",true,[true]],
	["_volume",1,[1]],
	["_fadeTime",3,[1]],
	["_isRandomTrack",false,[true]]
];


private _trackConfig = [["cfgMusic",_track]] call KISKA_fnc_findConfigAny;
if (isNull _trackConfig) exitWith {
	[[_track," is not a defined track in any CfgMusic"],true] call KISKA_fnc_log;
	nil
};


private _musicPlaying = call KISKA_fnc_isMusicPlaying;
private _exit = false;
private _fadeDown = false;
if (_musicPlaying) then {
	if (_isRandomTrack) then {
		// if the current playing track is also random
		if ((call KISKA_fnc_getCurrentRandomMusicTrack) isNotEqualTo "") then {
			_fadeDown = true;

		} else {
			_exit = true;

		};

	} else {
		if (_canInterrupt) then {
			_fadeDown = true;

		} else {
			_exit = true;

		};

	};

};


if (_exit) exitWith {};


// random start time
if (_startTime < 0) then {
	private _duration = [_track] call KISKA_fnc_getMusicDuration;
	_startTIme = round (random [0, _duration / 2, _duration]);

};


if (_fadeDown) then {
	// give the previous track time to fade out if required
	_fadeTime fadeMusic 0;
	sleep (_fadeTime + 0.1);

} else {
	// only need this setting of volume to 0 if there was no fade above that already set it to 0
	0 fadeMusic 0;

};

// clear out any track. Any new MUSIC_CURRENT_RANDOM_TRACK_VAR_STR will be set to the new track in KISKA_fnc_playMusic after this event has fired
// this is to avoid a track random music track not being cleared
[] call KISKA_fnc_musicStopEvent;
playMusic [_track,_startTime];
_fadeTime fadeMusic _volume;

if (_isRandomTrack) then {
	[_track] call KISKA_fnc_setCurrentRandomMusicTrack;

};


if (GET_MUSIC_SHOW_SONG_NAMES) then {
	private _trackName = getText(_trackConfig >> "name");
	if (_trackName isNotEqualTo "") then {
		[
			parseText ("<t font='PuristaBold' size='1.6'>" + _trackName + "</t>"),
			true,
			nil,
			7,
			0.7,
			0
		] spawn BIS_fnc_textTiles;
	};
};


nil

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
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "KISKA_fnc_playMusic"
scriptName SCRIPT_NAME;

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
	["_fadeTime",3,[1]]
];

private _trackConfig = [["cfgMusic",_track]] call KISKA_fnc_findConfigAny;
if (isNull _trackConfig) exitWith {
	[[_track," is not a defined track in any CfgMusic"],true] call KISKA_fnc_log;
};

private _musicPlaying = call KISKA_fnc_isMusicPlaying;
if (_musicPlaying AND {!_canInterrupt}) exitWith {};

if (_musicPlaying) then {
	_fadeTime fadeMusic 0;
} else {
	_fadeTime = 0;
};

if (_startTime < 0) then {
	private _duration = [_track] call KISKA_fnc_getMusicDuration;

	_startTIme = round (random [0, _duration / 2, _duration]);
};

uiSleep (_fadeTime + 0.1);

playMusic [_track,_startTime];

0 fadeMusic 0;
_fadeTime fadeMusic _volume;
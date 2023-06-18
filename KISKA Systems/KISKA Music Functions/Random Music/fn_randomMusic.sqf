#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic

Description:
    Starts playing a random assortment of curated music tracks to all players on a server.
    This is essentially a multiplayer jukebox. Should only be executed on the server.

    All songs will be played in a random order and then loop back to play in another random order infinitely.

    It will not interrupt music commanded to play by other means.

    You can define quiet time space between tracks.

Parameters:
    0: _tickId <NUMBER> - Used to superceed another random music loop, passs -1 to start a new one
    1: _musicTracks <ARRAY> - An array of strings (music tracks) to use
    2: _interval <ARRAY or NUMBER> - A random or set time between tracks.
        Formats are [min,mid,max] & [max] for random numbers and
        just a single number for a set time between (see example)
    3: _usedMusicTracks <ARRAY> - An array of already used music tracks, don't bother manually entering anyhting, this is for looping purposes

Returns:
    NOTHING

Examples:
    (begin example)
        // space tracks by 20 seconds exactly each
        [-1,arrayOfTracks,20] call KISKA_fnc_randomMusic;
       (end)

    (begin example)
        // space tracks by UP TO 20 seconds each
        [-1,arrayOfTracks,[20]] call KISKA_fnc_randomMusic;
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

/* ----------------------------------------------------------------------------
    Params
---------------------------------------------------------------------------- */
params [
    ["_tickId",-1,[123]],
    ["_musicTracks",call KISKA_fnc_randomMusic_getUnusedTracks,[[]]],
    ["_interval",call KISKA_fnc_randomMusic_getTrackInterval,[[],123]],
    ["_usedMusicTracks",call KISKA_fnc_randomMusic_getUsedTracks,[[]]]
];

private _latestTickID = GET_MUSIC_RANDOM_START_TIME;
private _isNewLoop = _tickId isEqualTo -1;
if ((!_isNewLoop) AND (_tickId < _latestTickID)) exitWith {
    [["Tick ID: ",_tickId," was thrown out in favor of ID: ",_latestTickID],false] call KISKA_fnc_log;
    nil
};


if (_musicTracks isEqualTo [] AND (_usedMusicTracks isEqualTo [])) exitWith {
    ["No music tracks were passed! Can't start.",true] call KISKA_fnc_log;
    nil
};

// check if _interval is an array AND if it is the correct formats OR if it is just a single number
if !([_interval] call KISKA_fnc_randomMusic_setTrackInterval) exitWith {
    nil
};


/* ----------------------------------------------------------------------------
    Select & Play Track
---------------------------------------------------------------------------- */
if (_musicTracks isEqualTo []) then {
    _musicTracks = +_usedMusicTracks;
    _usedMusicTracks = [];
};


private _selectedTrack = [_musicTracks] call KISKA_fnc_deleteRandomIndex;
// get defined volume for random music system
private _volume = call KISKA_fnc_randomMusic_getVolume;
[_selectedTrack,0,false,_volume,3,true] remoteExec ["KISKA_fnc_playMusic",[0,-2] select isDedicated];


if !(call KISKA_fnc_randomMusic_isSystemRunning) then {
    [true] call KISKA_fnc_randomMusic_setSystemRunning;
};


/* ----------------------------------------------------------------------------
    Cleanup
---------------------------------------------------------------------------- */
[_musicTracks] call KISKA_fnc_randomMusic_setUnusedTracks;

// store track as used
_usedMusicTracks pushBackUnique _selectedTrack;
[_usedMusicTracks] call KISKA_fnc_randomMusic_setUsedTracks;

/* ----------------------------------------------------------------------------
    Get Wait Time
---------------------------------------------------------------------------- */
private _durationOfTrack = [_selectedTrack] call KISKA_fnc_getMusicDuration;
// decide how much time should be between tracks
private "_randomWaitTime";
if (_interval isEqualType []) then {
    if (_interval isEqualTypeArray [1,2,3]) then {
        _randomWaitTime = round (random _interval);

    } else {
        _randomWaitTime = round (random (_interval select 0));

    };

} else {
    _randomWaitTime = _interval;

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

[
    {
        _this call KISKA_fnc_randomMusic;
    },
    [_tickId],
    _waitTime
] call CBA_fnc_waitAndExecute;


nil

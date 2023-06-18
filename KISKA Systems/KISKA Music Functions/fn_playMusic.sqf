#include "Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_playMusic

Description:
    Plays music with smooth fade between tracks. Must be run in scheduled environment (spawn)

Parameters:
    0: _track <STRING> - Music to play
    1: _startTime <NUMBER OR ARRAY> - Starting time of music. -1 for random start time.
        If array, duration of track can also be specified (SEE EXAMPLE 2).
        THIS INCLUDES FADE TIME
    2: _canInterrupt <BOOL> - Interrupt playing music
    3: _volume <NUMBER> - Volume to play at
    4: _fadeTime <NUMBER> - Time to fade tracks down & up

Returns:
    NOTHING

Examples:
    (begin example)
        ["track", 0, true, 1, 3] spawn KISKA_fnc_playMusic;
    (end)

    (begin example)
        [
            "track",
            [10,60]    // start ten seconds into the song, and play for 60 seconds
        ] spawn KISKA_fnc_playMusic;
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
    ["_startTime",0,[123,[]]],
    ["_canInterrupt",true,[true]],
    ["_volume",1,[123]],
    ["_fadeTime",3,[123]],
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
        if ((call KISKA_fnc_randomMusic_getCurrentTrack) isNotEqualTo "") then {
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

// handle end specified track duration
private _durationToPlayTrack = -1;
if (_startTIme isEqualType []) then {
    _durationToPlayTrack = (_startTIme select 1) - (_fadeTime * 2);
    _startTIme = _startTIme select 0;
};

// random start time
if (_startTime < 0) then {
    private _totalTrackDuration = [_track] call KISKA_fnc_getMusicDuration;
    _startTIme = round (random [0, _totalTrackDuration / 2, _totalTrackDuration]);

};


if (_fadeDown) then {
    // give the previous track time to fade out if required
    _fadeTime fadeMusic 0;
    sleep (_fadeTime + 0.1);

} else {
    // only need this setting of volume to 0 if there was no fade above that already set it to 0
    0 fadeMusic 0;

};

private _previousTrackID = call KISKA_fnc_getLatestPlayedMusicID;
// clear out any track. Any new MUSIC_CURRENT_RANDOM_TRACK_VAR_STR will be set to the new track in KISKA_fnc_playMusic after this event has fired
// this is to avoid a track random music track not being cleared
[] call KISKA_fnc_musicStopEvent;
playMusic [_track,_startTime];
_fadeTime fadeMusic _volume;



if (_durationToPlayTrack > 0) then {
    // it takes more then one frame after playing music for the eventhandler to be called/complete
    // e.g. the music id will not be updated to the latest
    [
        {
            call KISKA_fnc_getLatestPlayedMusicID > (_this select 3)
        },
        {
            private _currentTrackID = call KISKA_fnc_getLatestPlayedMusicID;
            _this set [3,_currentTrackID];

            // the primary concern of needing to wait for the fade time here is
            /// to account for the fading out of the music.
            // the _durationToPlayTrack includes the time to fade out
            private _fadeTime = _this select 2;
            [
                {
                    params [
                        "_durationToPlayTrack",
                        "_track",
                        "_fadeTime",
                        "_trackID"
                    ];

                    private _currentTrackID = call KISKA_fnc_getLatestPlayedMusicID;
                    private _currentTrackName = call KISKA_fnc_getPlayingMusic;
                    if (_trackID isEqualTo _currentTrackID AND (_currentTrackName == _track)) then {
                        [
                            {
                                params [
                                    "_track",
                                    "_fadeTime",
                                    "_trackID"
                                ];

                                private _currentTrackID = call KISKA_fnc_getLatestPlayedMusicID;
                                private _currentTrackName = call KISKA_fnc_getPlayingMusic;
                                if (_trackID isEqualTo _currentTrackID AND (_currentTrackName == _track)) then {
                                    [_fadeTime] spawn {
                                        _this spawn KISKA_fnc_stopMusic;
                                    };
                                };
                            },
                            [
                                _track,
                                _fadeTime,
                                _currentTrackID
                            ],
                            _durationToPlayTrack
                        ] call CBA_fnc_waitAndExecute;
                    };
                },
                _this,
                _fadeTime
            ] call CBA_fnc_waitAndExecute;

        },
        [
            _durationToPlayTrack,
            _track,
            _fadeTime,
            _previousTrackID
        ]
    ] call CBA_fnc_waitUntilAndExecute;
};



if (_isRandomTrack) then {
    [_track] call KISKA_fnc_randomMusic_setCurrentTrack;

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

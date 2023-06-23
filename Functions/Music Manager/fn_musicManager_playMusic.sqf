/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManager_playMusic

Description:
	Starts the playing of music from the manager.

Parameters:
	0: _songToPlay : <STRING> - The track classname as defined in CfgMusic

Returns:
	NOTHING

Examples:
    (begin example)
		["myTrack",10] call BLWK_fnc_musicManager_playMusic;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManager_playMusic";

#define INTERVAL 0.01

private _songToPlay = uiNamespace getVariable ["BLWK_musicManager_selectedTrackToPlay",""];
if (_songToPlay isEqualTo "") exitWith {
	["You need to have a selection made from the songs list to play"] call KISKA_fnc_errorNotification;
	nil
};

private _musicMap = localNamespace getVariable "BLWK_musicManager_classNameToInfoMap";
private _songToPlayInfo = _musicMap get _songToPlay;
private _songDuration = _songToPlayInfo select 2;
uiNamespace setVariable ["BLWK_musicManager_songOnTimeline_duration",_songDuration];


private _startTime = 0;
private _songOnTimeline = uiNamespace getVariable ["BLWK_musicManager_songOnTimeline",""];
private _sliderControl = uiNamespace getVariable "BLWK_musicManager_control_timelineSlider";
if (_songOnTimeline != _songToPlay) then {
	_sliderControl sliderSetRange [0,_songDuration];
	_sliderControl sliderSetPosition 0;
} else {
	_startTime = sliderPosition _sliderControl;
};


uiNamespace setVariable ["BLWK_musicManager_paused",false];
uiNamespace setVariable ["BLWK_musicManager_songOnTimeline",_songToPlay];
if (_startTime <= 0) then {
	playMusic _songToPlay;
} else {
	playMusic [_songToPlay,_startTime];
};


if !(uiNamespace getVariable ["BLWK_musicManager_timelineLooping",false]) then {
	[_sliderControl] spawn {
		params ["_sliderControl"];
		// in order to switch from one track to another and not stack loops
		// we keep track of the timeline's moving state
		uiNamespace setVariable ["BLWK_musicManager_timelineLooping",true];

		while {
			(!isNull (uiNamespace getVariable "BLWK_musicManager_display")) AND
			!(uiNamespace getVariable ["BLWK_musicManager_paused",false])
		} do {
			sleep INTERVAL;
			// update slider position to mimic timeline
			private _songDuration = uiNamespace getVariable ["BLWK_musicManager_songOnTimeline_duration",0];
			private _newTimelinePosition = (sliderPosition _sliderControl) + INTERVAL;
			
			if (_newTimelinePosition >= _songDuration) then { break };
			_sliderControl sliderSetPosition _newTimelinePosition;
		};

		if !(isNull _sliderControl) then {
			_sliderControl sliderSetPosition 0;
		};
		uiNamespace setVariable ["BLWK_musicManager_timelineLooping",false];
	};
};

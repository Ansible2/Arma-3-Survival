/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManager_playMusic

Description:
	Starts the playing of music from the manager.

Parameters:
	0: _musicClass : <STRING> - The track classname as defined in CfgMusic
  	1: _startTime : <NUMBER> - The seek time to start playing music at
	  	(e.g. 1 is 1 second into the song)

Returns:
	NOTHING

Examples:
    (begin example)
		["myTrack",10] spawn BLWK_fnc_musicManager_playMusic;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManager_playMusic";

#define INTERVAL 0.01

if (!canSuspend) exitWith {
	["Needs to be run in scheduled, now running in scheduled",true] call KISKA_fnc_log;
	_this spawn BLWK_fnc_musicManager_playMusic;
};

params [
	"_musicClass",
	["_startTime",0]
];

private _sliderControl = uiNamespace getVariable "BLWK_musicManager_control_timelineSlider";
private _sliderMax = (sliderRange _sliderControl) select 1;

if (_startTime isEqualTo 0) then {
	playMusic _musicClass;
} else {
	playMusic [_musicClass,_startTime];
};

uiNamespace setVariable ["BLWK_musicManager_doPlay",true];
// set paused to false if it was true
if (uiNamespace getVariable ["BLWK_musicManager_paused",false]) then {
	uiNamespace setVariable ["BLWK_musicManager_paused",false];
};

// move timeline
if !(uiNamespace getVariable ["BLWK_musicManager_timelineLooping",false]) then {
	// in order to switch from one track to another and not stack loops
	// we keep track of the timeline's moving state
	uiNamespace setVariable ["BLWK_musicManager_timelineLooping",true];

	while {
		(!isNull (uiNamespace getVariable "BLWK_musicManager_display")) AND
		{uiNamespace getVariable ["BLWK_musicManager_doPlay",true]} AND
		// check if end of song is reached
		{sliderPosition _sliderControl < _sliderMax} }
	do {
		sleep INTERVAL;
		// update slider position to mimic timeline
	 	_sliderControl sliderSetPosition ((sliderPosition _sliderControl) + INTERVAL);
	};

	uiNamespace setVariable ["BLWK_musicManager_timelineLooping",false];
};

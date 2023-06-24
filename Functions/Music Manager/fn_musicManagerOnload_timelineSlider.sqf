/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_timelineSlider

Description:
	Adds (seeking) functionality to the timeline slider in the Music Manager.

Parameters:
	0: _timelineSliderControl : <CONTROL> - The control for the timeline slidier

Returns:
	NOTHING

Examples:
    (begin example)
		[_timelineSliderControl] call BLWK_fnc_musicManagerOnLoad_timelineSlider;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_timelineSlider";

params ["_timelineSliderControl"];

_timelineSliderControl ctrlAddEventHandler ["MouseButtonDown",{
	if !(uiNamespace getVariable ["BLWK_musicManager_paused",false]) then {
		uiNamespace setVariable ["BLWK_musicManager_resumeAfterTimelineAdjustment",true];
		uiNamespace getVariable ["BLWK_musicManager_paused",true];
		playMusic "";
		[] call KISKA_fnc_musicStopEvent;
	};
}];

_timelineSliderControl ctrlAddEventHandler ["MouseButtonUp",{
	// don't immediately play music if the music is paused
	if (uiNamespace getVariable ["BLWK_musicManager_resumeAfterTimelineAdjustment",false]) then {
		uiNamespace setVariable ["BLWK_musicManager_resumeAfterTimelineAdjustment",nil];
		[] call BLWK_fnc_musicManager_playMusic;
	};
}];


nil

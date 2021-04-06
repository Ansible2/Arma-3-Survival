/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_timelineSlider

Description:
	Adds (seeking) functionality to the timeline slider in the Music Manager.

Parameters:
	0: _control : <CONTROL> - The control for the timeline slidier

Returns:
	NOTHING

Examples:
    (begin example)
		[_control] call BLWK_fnc_musicManagerOnLoad_timelineSlider;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_timelineSlider";

params ["_control"];

_control ctrlAddEventHandler ["MouseButtonDown",{

	// if music was playing
	if (uiNamespace getVariable ["BLWK_musicManager_doPlay",false]) then {
		playMusic ""; // stop music while adjusting
		call KISKA_fnc_musicStopEvent;

		// tell music player in the mouse up event to resume
		uiNamespace setVariable ["BLWK_musicManager_doResume",true];
		// stop music player
		uiNamespace setVariable ["BLWK_musicManager_doPlay",false];
	};
}];

_control ctrlAddEventHandler ["MouseButtonUp",{
	params ["_control"];

	// don't immediately play music if the music is paused
	if (uiNamespace getVariable ["BLWK_musicManager_doResume",false]) then {
		uiNamespace setVariable ["BLWK_musicManager_doResume",nil];
		private _musicClass = uiNamespace getVariable ["BLWK_musicManager_selectedTrack",""];
		[_musicClass,sliderPosition _control] spawn BLWK_fnc_musicManager_playMusic;
	};
}];


nil

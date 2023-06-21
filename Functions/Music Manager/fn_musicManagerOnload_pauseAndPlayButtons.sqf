/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_pauseAndPlayButtons

Description:
	Adds functionality to the pause and play buttons in the Music Manager.

Parameters:
	0: _playButtonControl : <CONTROL> - The control for the play button
	1: _pauseButtonControl : <CONTROL> - The control for the pause button

Returns:
	NOTHING

Examples:
    (begin example)
		[_playButtonControl,_pauseButtonControl] call BLWK_fnc_musicManagerOnLoad_pauseAndPlayButtons;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_pauseAndPlayButtons";

params ["_playButtonControl","_pauseButtonControl"];

_playButtonControl ctrlAddEventHandler ["ButtonClick",{
	[] call BLWK_fnc_musicManager_playMusic;
}];

_pauseButtonControl ctrlAddEventHandler ["ButtonClick",{
	if !(uiNamespace getVariable ["BLWK_musicManager_paused",false]) then {
		uiNamespace setVariable ["BLWK_musicManager_paused",true];	
		playMusic "";
		[] call KISKA_fnc_musicStopEvent;
	};
}];


nil

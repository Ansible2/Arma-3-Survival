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
	params ["_control"];

	// if music is already playing
	if !(uiNamespace getVariable ["BLWK_musicManager_doPlay",false]) then {
		private _availableMusicListControl = uiNamespace getVariable "BLWK_musicManager_control_songsList";

		private _selectedIndex = lnbCurSelRow _availableMusicListControl;
		if (_selectedIndex isEqualTo -1) then {
			hint "You need to have a selection made from the songs list";
		} else {

			private _musicClass = _availableMusicListControl lnbData [_selectedIndex,0];
			// if music is paused, start from slider position
			if (uiNamespace getVariable ["BLWK_musicManager_paused",false]) then {
				private _sliderPosition = sliderPosition (uiNamespace getVariable "BLWK_musicManager_control_timelineSlider");
				[_musicClass,_sliderPosition] spawn BLWK_fnc_musicManager_playMusic;
			} else {
				[_musicClass] spawn BLWK_fnc_musicManager_playMusic;
			};

			uiNamespace setVariable ["BLWK_musicManager_doPlay",true];
			[] spawn BLWK_fnc_musicManager_moveTimeline;
		};
	};

}];

_pauseButtonControl ctrlAddEventHandler ["ButtonClick",{
	params ["_control"];

	if (uiNamespace getVariable ["BLWK_musicManager_doPlay",false]) then {
		uiNamespace setVariable ["BLWK_musicManager_doPlay",false];
		uiNamespace setVariable ["BLWK_musicManager_paused",true];
		playMusic "";
		call KISKA_fnc_musicStopEvent;
	};

}];


nil

params ["_playButtonControl","_pauseButtonControl"];

_playButtonControl ctrlAddEventHandler ["ButtonClick",{
	params ["_control"];
	
	private _availableMusicListControl = uiNamespace getVariable "BLWK_musicManager_control_songsList";

	private _selectedIndex = lnbCurSelRow _availableMusicListControl;
	systemChat str _selectedIndex;
	if (_selectedIndex isEqualTo -1) then {
		hint "You need to have a selection made from the songs list";
	} else {
		private _musicClass = _availableMusicListControl lnbData [_selectedIndex,0];
		
		if (uiNamespace getVariable ["BLWK_musicManager_paused",false]) then {
			private _sliderPosition = sliderPosition (uiNamespace getVariable "BLWK_musicManager_control_timelineSlider");
			// resume song from slider position
			playMusic [_musicClass,_sliderPosition];
		} else {
			// get song
			// play selected song from start			
		};

		uiNamespace setVariable ["BLWK_musicManager_doPlay",true];
	};
}];
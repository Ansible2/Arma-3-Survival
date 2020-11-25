params ["_playButtonControl","_pauseButtonControl"];

_playButtonControl ctrlAddEventHandler ["ButtonClick",{
	params ["_control"];
	
	private _display = ctrlParent _control;
	private _availableMusicListControl = _display displayCtrl BLWK_MUSIC_MANAGER_SONGS_LIST_IDC;

	private _selectedIndex = lnbCurSelRow _availableMusicListControl;
	systemChat str _selectedIndex;
	if (_selectedIndex isEqualTo -1) then {
		hint "You need to have a selection made from the songs list";
	} else {
		private _musicClass = _availableMusicListControl lnbData [_selectedIndex,0];
		
		if (missionNamespace getVariable ["BLWK_musicManager_paused",false]) then {

		} else {
			// get song
			private _musicClass = _availableMusicListControl lnbData [_selectedIndex,0];
			[] call KISKA_fnc_playMusic
		}			
	};
}];
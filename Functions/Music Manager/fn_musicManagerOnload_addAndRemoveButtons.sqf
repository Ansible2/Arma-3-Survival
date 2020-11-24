params ["_addButtonControl","_removeButtonControl"];

_addButtonControl ctrlAddEventHandler ["ButtonClick",{
	params ["_control"];
	
	private _display = ctrlParent _control;
	private _availableMusicListControl = _display displayCtrl BLWK_MUSIC_MANAGER_SONGS_LIST_IDC;

	private _selectedIndex = lnbCurSelRow _availableMusicListControl;
	systemChat str _selectedIndex;
	if (_selectedIndex isEqualTo -1) then {
		hint "You need to have a selection made from the songs list";
	} else {
		// class name of song is stored in its data
		[TO_STRING(BLWK_PUB_CURRENT_PLAYLIST),_control lnbData [_selectedIndex,0]] remoteExecCall ["KISKA_fnc_pushBackToGlobalArray",BLWK_allClientsTargetId,true];
	};
}];

_removeButtonControl ctrlAddEventHandler ["ButtonClick",{
	params ["_control"];
	
	private _display = ctrlParent _control;
	private _currentPlaylistControl = _display displayCtrl BLWK_MUSIC_MANAGER_CURRENT_PLAYLIST_IDC;

	private _selectedIndex = lbCurSel _currentPlaylistControl;
	systemChat str _selectedIndex;
	if (_selectedIndex isEqualTo -1) then {
		hint "You need to have a selection made from the Current Playlist";
	} else {
		// class name of song is stored in its data
		[TO_STRING(BLWK_PUB_CURRENT_PLAYLIST),_selectedIndex] remoteExecCall ["KISKA_fnc_deleteAtGlobalArray",BLWK_allClientsTargetId,true];
	};
}];
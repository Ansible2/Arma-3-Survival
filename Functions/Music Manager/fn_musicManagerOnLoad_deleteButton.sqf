params ["_control"];

_control ctrlAddEventHandler ["ButtonClick",{
	private _loadControl = uiNamespace getVariable "BLWK_musicManager_control_loadCombo";
	private _selectedIndex = lbCurSel _loadControl;
	if (!(_selectedIndex isEqualTo -1) AND {!(_selectedIndex isEqualTo 0)}) then {
		private _savedPlaylistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
		_savedPlaylistArray deleteAt (_selectedIndex - 1); // offset because of the DEFAULT in the combo box
		
		profileNamespace setVariable ["BLWK_musicManagerPlaylists",_savedPlaylistArray];
		saveProfileNamespace;

		null = [] spawn BLWK_fnc_musicManager_updateLoadCombo;
	} else {
		hint "You need a valid selection to delete";
	};
}];
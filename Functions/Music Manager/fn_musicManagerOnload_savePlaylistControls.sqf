#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"

params ["_saveButtonControl","_saveAsButtonControl"];


uiNamespace getVariable "BLWK_musicManager_control_saveEdit";


uiNamespace getVariable "BLWK_musicManager_control_saveButton";
_saveButtonControl ctrlAddEventHandler ["ButtonClick",{
	params ["_control"];
	
	// make sure a selection is made in the load drop down
	private _loadComboControl = uiNamespace getVariable "BLWK_musicManager_control_loadCombo";
	private _loadComboSelectedIndex = lbCurSel _loadComboControl;
	if !(_loadComboSelectedIndex isEqualTo -1) then {
		// make sure there is anything to overwrite the list with
		if !(GET_PUBLIC_ARRAY_DEFAULT isEqualTo []) then {
			private _savedPlaylistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
			private _playlistName = _loadComboControl lbText _loadComboSelectedIndex;
			_savedPlaylistArray set [_loadComboSelectedIndex,[_playlistName,BLWK_PUB_CURRENT_PLAYLIST]];
			saveProfileNamespace;	
		} else {
			hint parseText "There are no entries in the Current Playlist.<br/>Save an empty list with Save As or Delete the list";
		};
	} else {
		hint "You need a selection to be made in the Load Playlist drop down";
	};
}];

uiNamespace getVariable "BLWK_musicManager_control_saveAsButton";
_saveAsButtonControl ctrlAddEventHandler ["ButtonClick",{
	//params ["_control"];

	private _editBoxControl = uiNamespace getVariable "BLWK_musicManager_control_saveEdit";
	private _playlistName = ctrlText _editBoxControl;
	if !(_playlistName isEqualTo "") then {
		private _savedPlaylistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
		_savedPlaylistArray pushBack [_loadComboSelectedIndex,[_playlistName,BLWK_PUB_CURRENT_PLAYLIST]];
	};

	saveProfileNamespace;
}];
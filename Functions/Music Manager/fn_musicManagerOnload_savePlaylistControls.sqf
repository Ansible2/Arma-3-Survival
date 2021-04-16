#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_savePlaylistControls

Description:
	Adds functionality to the save and save as buttons in the Music Manager.

Parameters:
	0: _saveButtonControl : <CONTROL> - The control for the save button
	1: _saveAsButtonControl : <CONTROL> - The control for the saveAs button

Returns:
	NOTHING

Examples:
    (begin example)
		[_saveButtonControl,_saveAsButtonControl] call BLWK_fnc_musicManagerOnLoad_savePlaylistControls;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_savePlaylistControls";

params ["_saveButtonControl","_saveAsButtonControl"];

_saveButtonControl ctrlAddEventHandler ["ButtonClick",{
	//params ["_control"];

	// make sure a selection is made in the load drop down
	private _loadComboControl = uiNamespace getVariable "BLWK_musicManager_control_loadCombo";
	private _loadComboSelectedIndex = lbCurSel _loadComboControl;

	// if a selection has been made in the load playlist drop down AND it is not the DEFAULT entry
	if !(_loadComboSelectedIndex isEqualTo -1) then {

		// make sure there is anything to overwrite the list with
		if !(GET_PUBLIC_ARRAY_DEFAULT isEqualTo []) then {
			private _savedPlaylistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
			private _playlistName = _loadComboControl lbText _loadComboSelectedIndex;
			// creating a copy of BLWK_PUB_CURRENT_PLAYLIST as otherwise, any changes to BLWK_PUB_CURRENT_PLAYLIST after would
			// directly go to the profileNamespace saved array
			_savedPlaylistArray set [_loadComboSelectedIndex,[_playlistName,+BLWK_PUB_CURRENT_PLAYLIST]];
			profileNamespace setVariable ["BLWK_musicManagerPlaylists",_savedPlaylistArray];
			saveProfileNamespace;
		} else {
			hint (parseText "There are no entries in the Current Playlist.<br/>Save an empty list with Save As or Delete the list");
		};

	} else {
		hint "You need a selection to be made in the Load Playlist drop down";
	};

}];

_saveAsButtonControl ctrlAddEventHandler ["ButtonClick",{
	//params ["_control"];

	private _editBoxControl = uiNamespace getVariable "BLWK_musicManager_control_saveEdit";
	private _playlistName = ctrlText _editBoxControl;

	if !(_playlistName isEqualTo "") then {

		private _savedPlaylistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
		_savedPlaylistArray pushBack [_playlistName,BLWK_PUB_CURRENT_PLAYLIST];
		profileNamespace setVariable ["BLWK_musicManagerPlaylists",_savedPlaylistArray];
		saveProfileNamespace;

		[] spawn BLWK_fnc_musicManager_updateLoadCombo;

	} else {
		hint "Playlists require at least one character for a name";
	};

}];


nil

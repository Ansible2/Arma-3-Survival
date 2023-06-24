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
	private _loadComboControl = uiNamespace getVariable "BLWK_musicManager_control_loadCombo";
	private _loadComboSelectedIndex = lbCurSel _loadComboControl;

	private _selectionInLoadDropdownMade = _loadComboSelectedIndex isNotEqualTo -1;
	if (_selectionInLoadDropdownMade) then {

		private _currentPlaylist = localNamespace getVariable ["BLWK_musicManager_currentPlaylistMap",[]];
		private _currentPlaylistIsEmpty = (count _currentPlaylist) < 1;
		if (!_currentPlaylistIsEmpty) then {
			private _savedPlaylistsArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
			private _currentlySelectedPlaylist = _loadComboControl lbText _loadComboSelectedIndex;
			private _songs = values _currentPlaylist;
			_savedPlaylistsArray set [_loadComboSelectedIndex,[_currentlySelectedPlaylist,_songs]];
			
			profileNamespace setVariable ["BLWK_musicManagerPlaylists",_savedPlaylistsArray];
			saveProfileNamespace;

			[[_currentlySelectedPlaylist,"was saved to your profile"] joinString " "] call KISKA_fnc_notification;

		} else {
			["There are no entries in the Current Playlist.<br/>Save an empty list with Save As or Delete the list"] call KISKA_fnc_errorNotification;

		};

	} else {
		["You need a selection to be made in the Load Playlist drop down"] call KISKA_fnc_errorNotification;

	};

}];

_saveAsButtonControl ctrlAddEventHandler ["ButtonClick",{
	private _editBoxControl = uiNamespace getVariable "BLWK_musicManager_control_saveEdit";
	private _newPlaylistName = ctrlText _editBoxControl;

	if (_newPlaylistName isNotEqualTo "") then {

		private _currentPlaylist = localNamespace getVariable ["BLWK_musicManager_currentPlaylistMap",[]];
		private _savedPlaylistsArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
		_savedPlaylistsArray pushBack [_newPlaylistName,values _currentPlaylist];
		profileNamespace setVariable ["BLWK_musicManagerPlaylists",_savedPlaylistsArray];
		saveProfileNamespace;

		[[_newPlaylistName,"was saved to your profile"] joinString " "] call KISKA_fnc_notification;

		[] spawn BLWK_fnc_musicManager_updateLoadCombo;

	} else {
		["Playlists require at least one character for a name"] call KISKA_fnc_errorNotification;
		
	};

}];


nil

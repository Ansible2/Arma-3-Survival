/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_deleteButton

Description:
	Adds functionality to the delete button of the Music Manager.
	It allows you to delete saved playlists.

Parameters:
	0: _control : <CONTROL> - The control for the delete button

Returns:
	NOTHING

Examples:
    (begin example)
		[_control] call BLWK_fnc_musicManagerOnLoad_deleteButton;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_deleteButton";

params ["_control"];

_control ctrlAddEventHandler ["ButtonClick",{

	private _loadControl = uiNamespace getVariable "BLWK_musicManager_control_loadCombo";
	// index in load combo
	private _selectedIndex = lbCurSel _loadControl;

	// check if an entry in the loadCombo is selected and that it is not the DEFAULT entry in the load combo
	if !(_selectedIndex isEqualTo -1) then {

		private _savedPlaylistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
		/// BLWK_musicManagerPlaylists array
		_savedPlaylistArray deleteAt _selectedIndex;

		profileNamespace setVariable ["BLWK_musicManagerPlaylists",_savedPlaylistArray];
		saveProfileNamespace;

		// update displayed list
		[] spawn BLWK_fnc_musicManager_updateLoadCombo;
	} else {
		hint "You need a valid selection to delete";
	};

}];


nil

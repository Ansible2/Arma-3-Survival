#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_loadControls

Description:
	Adds functionality to the loadable playlist dropdown and button in the Music Manager.

Parameters:
	0: _loadComboControl : <CONTROL> - The control for the combo box
	1: _loadButtonControl : <CONTROL> - The control for "Load Playlist" button

Returns:
	NOTHING

Examples:
    (begin example)
		[_loadComboControl,_loadButtonControl] call BLWK_fnc_musicManagerOnLoad_loadControls;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_loadControls";

params ["_loadComboControl","_loadButtonControl"];

_loadComboControl ctrlAddEventHandler ["LBSelChanged",{
	// don't need _control
	params ["","_selectedIndex"];

	uiNamespace setVariable ["BLWK_musicManager_loadCombo_currentSelection",_selectedIndex];
}];

_loadButtonControl ctrlAddEventHandler ["ButtonClick",{
	// clear out any colored indexes in the available music list
	// we make a copy of BLWK_musicManager_coloredClasses because the full loop will not complete given that
	// BLWK_fnc_musicManager_adjustNameColor deletes entries from directly the array
	private _coloredClasses = +(uiNamespace getVariable ["BLWK_musicManager_coloredClasses",[]]);
	if (_coloredClasses isNotEqualTo []) then {
		_coloredClasses apply {
			[_x,false] call BLWK_fnc_musicManager_adjustNameColor;
		};
	};

	// get all the playlists the player has saved
	private _playlistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];

	private _selectedIndex = uiNamespace getVariable ["BLWK_musicManager_loadCombo_currentSelection",0];

	if (_playlistArray isNotEqualTo []) then {

		private _chosenPlaylist = _playlistArray select _selectedIndex;
		private _musicClassesInList = _chosenPlaylist select 1;

		// clear global array before adding to it
		missionNamespace setVariable [TO_STRING(BLWK_PUB_CURRENT_PLAYLIST),[],true];
		// if there is actually anything to add
		if !(_musicClassesInList isEqualTo []) then {
			private _countOfUnavailable = 0;
			private "_configPath_temp";

			_musicClassesInList apply {
				_configPath_temp = [["CfgMusic",_x]] call KISKA_fnc_findConfigAny;
				// make sure song exists right now
				if !(isNull _configPath_temp) then {
					// update Available Music List Control color
					[_x,true] call BLWK_fnc_musicManager_adjustNameColor;

					// CIPHER COMMENT: Truth be told, there is no reason to have this be 0, just needs to be the server and players
					[TO_STRING(BLWK_PUB_CURRENT_PLAYLIST),_x] remoteExecCall ["KISKA_fnc_pushBackToArray",0,true];
				} else {
					_countOfUnavailable = _countOfUnavailable + 1;
				};
			};

			if (_countOfUnavailable > 0) then {
				hint ((str _countOfUnavailable) + " songs could not be found and were not added to the list");
			};
		};
	};

}];

// the initial filling of the combo with loadable playlists
[] spawn BLWK_fnc_musicManager_updateLoadCombo;


nil

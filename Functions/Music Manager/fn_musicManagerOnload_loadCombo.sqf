#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"

params ["_loadComboControl"];

_loadComboControl ctrlAddEventHandler ["LBSelChanged",{
	params ["_control","_selectedIndex"];

	private _playlistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
	// 0 is a blank spot used for having no entry
	if (!(_selectedIndex isEqualTo 0) AND {!(_playlistArray isEqualTo [])}) then {
		// _selectedIndex is offset from the profile array because of the DEFAULT entry in the combo box
		private _chosenPlaylist = _playlistArray select (_selectedIndex - 1);
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

// fill in list with available ones
null = [] spawn BLWK_fnc_musicManager_updateLoadCombo;
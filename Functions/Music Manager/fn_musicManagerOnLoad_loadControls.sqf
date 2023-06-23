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
    params ["","_selectedIndex"];

    uiNamespace setVariable ["BLWK_musicManager_loadCombo_currentSelection",_selectedIndex];
}];

_loadButtonControl ctrlAddEventHandler ["ButtonClick",{
    private _playlistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
    private _selectedIndex = uiNamespace getVariable ["BLWK_musicManager_loadCombo_currentSelection",0];

    if (_playlistArray isNotEqualTo []) then {
        private _chosenPlaylist = _playlistArray select _selectedIndex;
        private _musicClassesInList = _chosenPlaylist select 1;

        if (_musicClassesInList isNotEqualTo []) then {

            private _currentPlaylist = localNamespace getVariable ["BLWK_musicManager_currentPlaylistMap", -1];
            if (_currentPlaylist isNotEqualTo -1) then {
                (keys _currentPlaylist) apply {
                    [_x] remoteExecCall ["BLWK_fnc_musicManager_removeSongFromPlaylist",0,true];
                };
            };

            private _classNameToInfoMap = localNamespace getVariable "BLWK_musicManager_classNameToInfoMap";
            private _countOfUnavailable = 0;
            _musicClassesInList apply {
                if (_x in _classNameToInfoMap) then {
                    private _songIndex = (_classNameToInfoMap get _x) select 3;
                    [_songIndex] remoteExecCall ["BLWK_fnc_musicManager_addSongToPlaylist",0,true];

                } else {
                    _countOfUnavailable = _countOfUnavailable + 1;

                };
            };

            if (_countOfUnavailable > 0) then {
                private _playlistName = _chosenPlaylist select 0;
                [_playlistName + " was loaded"] call KISKA_fnc_notification;
                [((str _countOfUnavailable) + " songs could not be found and were not loaded")] call KISKA_fnc_errorNotification;
            };
        };
    };

}];

// the initial filling of the combo with loadable playlists
[] spawn BLWK_fnc_musicManager_updateLoadCombo;


nil

#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_addAndRemoveButtons

Description:
    Adds button pressed events to the add and remove from current playlist buttons.

Parameters:
    0: _addButtonControl : <CONTROL> - The control for the add to playlist button
    1: _removeButtonControl : <CONTROL> - The control for the remove from playlist button

Returns:
    NOTHING

Examples:
    (begin example)
        [_addToButtonControl,_removeFromButtonControl] call BLWK_fnc_musicManagerOnLoad_addAndRemoveButtons;
    (end)

Author(s):
    Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_addAndRemoveButtons";

params ["_addButtonControl","_removeButtonControl"];

_addButtonControl ctrlAddEventHandler ["ButtonClick", {
    private _selectedTrackIndexes = uiNamespace getVariable ["BLWK_musicManager_selectedAvailableTrackRowIndexes",[]];

    if (_selectedTrackIndexes isEqualTo []) then {
        ["You need to have a selection made from the available songs list"] call KISKA_fnc_errorNotification;

    } else {
        private _availableMusicListControl = uiNamespace getVariable "BLWK_musicManager_control_availableSongsList";
        _selectedTrackIndexes apply {
            private _songIndex = _availableMusicListControl lnbValue [_x,0];
            [_songIndex] remoteExecCall ["BLWK_fnc_musicManager_addSongToPlaylist",0,true];
        };

    };

}];

_removeButtonControl ctrlAddEventHandler ["ButtonClick", {
    private _selectedTrackIndexes = uiNamespace getVariable ["BLWK_musicManager_selectedAvailableTrackRowIndexes",[]];

    if (_selectedTrackIndexes isEqualTo []) then {
        ["You need to have a selection made from the Current Playlist"] call KISKA_fnc_errorNotification;

    } else {
        private _availableMusicListControl = uiNamespace getVariable "BLWK_musicManager_control_availableSongsList";
        _selectedTrackIndexes apply {
            private _songIndex = _availableMusicListControl lnbValue [_x,0];
			[_songIndex] remoteExecCall ["BLWK_fnc_musicManager_removeSongFromPlaylist",0,true];
        };

    };
}];


nil

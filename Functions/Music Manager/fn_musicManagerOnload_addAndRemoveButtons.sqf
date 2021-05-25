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

_addButtonControl ctrlAddEventHandler ["ButtonClick",{
	params ["_control"];

	private _availableMusicListControl = (uiNamespace getVariable "BLWK_musicManager_control_songsList");

	private _selectedIndex = lnbCurSelRow _availableMusicListControl;
	if (_selectedIndex isEqualTo -1) then {
		hint "You need to have a selection made from the songs list";
	} else {
		private _classToAdd = _availableMusicListControl lnbData [_selectedIndex,0];
		// class name of song is stored in its data
		[TO_STRING(BLWK_PUB_CURRENT_PLAYLIST),_classToAdd] remoteExecCall ["KISKA_fnc_pushBackToArray",0,true];

		// available music list coloring for
		[_classToAdd,true] call BLWK_fnc_musicManager_adjustNameColor;
	};

}];

_removeButtonControl ctrlAddEventHandler ["ButtonClick",{
	params ["_control"];

	private _selectedIndex = lbCurSel (uiNamespace getVariable "BLWK_musicManager_control_currentPlaylist");
	if (_selectedIndex isEqualTo -1) then {
		hint "You need to have a selection made from the Current Playlist";
	} else {
		// available music list set color back to white
		private _classToRemove = BLWK_PUB_CURRENT_PLAYLIST select _selectedIndex;
		[_classToRemove,false] call BLWK_fnc_musicManager_adjustNameColor;

		// class name of song is stored in its data
		[TO_STRING(BLWK_PUB_CURRENT_PLAYLIST),_selectedIndex] remoteExecCall ["KISKA_fnc_deleteAtArray",0,true];

	};
}];


nil

#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"

params ["_addButtonControl","_removeButtonControl"];

_addButtonControl ctrlAddEventHandler ["ButtonClick",{
	params ["_control"];
	
	private _availableMusicListControl = (uiNamespace getVariable "BLWK_musicManager_control_songsList");

	private _selectedIndex = lnbCurSelRow _availableMusicListControl;
	systemChat str _selectedIndex;
	if (_selectedIndex isEqualTo -1) then {
		hint "You need to have a selection made from the songs list";
	} else {
		// class name of song is stored in its data
		[TO_STRING(BLWK_PUB_CURRENT_PLAYLIST),_availableMusicListControl lnbData [_selectedIndex,0]] remoteExecCall ["KISKA_fnc_pushBackToGlobalArray",BLWK_allClientsTargetId,true];
	};
}];

_removeButtonControl ctrlAddEventHandler ["ButtonClick",{
	params ["_control"];
	
	private _selectedIndex = lbCurSel (uiNamespace getVariable "BLWK_musicManager_control_currentPlaylist");
	systemChat str _selectedIndex;
	if (_selectedIndex isEqualTo -1) then {
		hint "You need to have a selection made from the Current Playlist";
	} else {
		// class name of song is stored in its data
		[TO_STRING(BLWK_PUB_CURRENT_PLAYLIST),_selectedIndex] remoteExecCall ["KISKA_fnc_deleteAtGlobalArray",BLWK_allClientsTargetId,true];
	};
}];
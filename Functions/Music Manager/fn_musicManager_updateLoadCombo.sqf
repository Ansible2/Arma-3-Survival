#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManager_updateLoadCombo

Description:
	Updates the drop down list of loadable playlists

Parameters:
	0: _control : <CONTROL> - The control of the combobox
  	1: _goToIndex : <NUMBER> - What index should the load combo be set to after updating

Returns:
	NOTHING

Examples:
    (begin example)
		null = [] spawn BLWK_fnc_musicManager_updateLoadCombo;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "BLWK_fnc_musicManager_updateLoadCombo"
scriptName SCRIPT_NAME;

if (!canSuspend) exitWith {
	[SCRIPT_NAME,"Needs to be run in scheduled, now running in scheduled",false,true,true] call KISKA_fnc_log;
	null = _this spawn BLWK_fnc_musicManager_updateLoadCombo;
};

params [
	["_control",uiNamespace getVariable "BLWK_musicManager_control_loadCombo",[controlNull]],
	["_goToIndex",0,[123]]
];

private _playlistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];

// if we are deleteing, the profile array may be empty, but we still need the list empty regardless
lbClear _control;

// adding a blank spot so there is always a constant position to reference
_control lbAdd "DEFAULT";
if !(_playlistArray isEqualTo []) then {
	private _playlistNames = [];
	_playlistArray apply {
		_playlistNames pushBack (_x select 0);
	};

	_playlistNames apply {
		_control lbAdd _x;
	};
};

_control lbSetCurSel _goToIndex;
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
		[] spawn BLWK_fnc_musicManager_updateLoadCombo;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManager_updateLoadCombo";

if (!canSuspend) exitWith {
	["Needs to be run in scheduled, now running in scheduled",true] call KISKA_fnc_log;
	_this spawn BLWK_fnc_musicManager_updateLoadCombo;
};

params [
	["_control",uiNamespace getVariable "BLWK_musicManager_control_loadCombo",[controlNull]],
	["_goToIndex",0,[123]]
];

private _playlistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];

// if we are deleteing, the profile array may be empty, but we still need the list empty regardless
lbClear _control;

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
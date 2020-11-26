if (!canSuspend) exitWith {
	"BLWK_fnc_musicManager_updateLoadCombo needs to be run in a scheduled environment" call BIS_fnc_error;
};

params [
	["_control",uiNamespace getVariable "BLWK_musicManager_control_loadCombo",[controlNull]],
	["_goToIndex",0,[123]]
];

private _playlistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
// if we are deleteing, the profile array may be empty, but we still need the list empty regardless
lbClear _control;
// adding a blank spot so things don't change
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
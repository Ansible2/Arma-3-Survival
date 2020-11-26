params ["_control"];

private _playlistArray = profileNamespace getVariable ["BLWK_musicManagerPlaylists",[]];
if !(_playlistArray isEqualTo []) then {
	lbClear _control;
	
	private _playlistNames = [];
	_playlistArray apply {
		_playlistNames pushBack (_x select 0);
	};

	_playlistNames apply {
		_control lbAdd _x;
	};

	_control lbSetCurSel 0;
};
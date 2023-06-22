/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_availableMusicList

Description:
	Populates the ListNBox that shows all available tracks when the Music Manager
	 is openned.

Parameters:
	0: _availableSongsListControl : <CONTROL> - The control for the ListNBox with available music

Returns:
	NOTHING

Examples:
    (begin example)
		[_availableSongsListControl] call BLWK_fnc_musicManagerOnLoad_availableMusicList;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_availableMusicList";

params ["_availableSongsListControl"];

/* ----------------------------------------------------------------------------
	Setup events
---------------------------------------------------------------------------- */
_availableSongsListControl ctrlAddEventHandler ["LBSelChanged", {
	params [
		"_availableSongsListControl",
		"_lastSelectedIndex",
		"_allCurrentlySelectedIndexes"
	];

	uiNamespace setVariable ["BLWK_musicManager_selectedAvailableTrackIndexes",_allCurrentlySelectedIndexes];
	
	private _musicClass = _availableSongsListControl lnbData [_lastSelectedIndex,0];
	uiNamespace setVariable ["BLWK_musicManager_selectedTrackToPlay",_musicClass];
}];

_availableSongsListControl ctrlAddEventHandler ["LBDblClick", {
	params ["_availableSongsListControl", "_selectedIndex"];

	// TODO: This may be redundant with the above LBSelChanged
	private _musicClass = _availableSongsListControl lnbData [_selectedIndex,0];
	uiNamespace setVariable ["BLWK_musicManager_selectedTrackToPlay",_musicClass];
	[] call BLWK_fnc_musicManager_playMusic;
}];


/* ----------------------------------------------------------------------------
	Generate List
---------------------------------------------------------------------------- */
// cache and/or get music info for list
private "_musicMap";
if (isNil {localNamespace getVariable "BLWK_musicManager_musicMap"}) then {
	private _musicClasses = "true" configClasses (configFile >> "cfgMusic");

	private _musicArray = [];
	{
		private _songName = getText(_x >> "name");
		if (_songName isEqualTo "") then {
			_songName = configName _x;
		};

		private _songDuration = getNumber(_x >> "duration");
		private _songClassname = configName _x;

		_musicArray pushBack [_songClassname,[_songName, str (round _songDuration), _songDuration,_forEachIndex]];
	} forEach _musicClasses;

	_musicMap = createHashMapFromArray _musicArray;
	localNamespace setVariable ["BLWK_musicManager_musicMap",_musicMap];

} else {
	_musicMap = localNamespace getVariable "BLWK_musicManager_musicMap";

};

// add duration column
_availableSongsListControl lnbAddColumn 1;
_availableSongsListControl lnbSetColumnsPos [0,0.82];


{
	_y params ["_songName","_songDurationString"];
	private _rowIndex = _availableSongsListControl lnbAddRow [_songName,_songDurationString];

	private _songClassname = _x;
	_availableSongsListControl lnbSetData [[_rowIndex,0],_songClassname];
	_availableSongsListControl lnbSetTooltip [[_rowIndex,0],_songClassname];
	_availableSongsListControl lnbSetTooltip [[_rowIndex,1],_songClassname];
} forEach _musicMap;


_availableSongsListControl lnbSort [0, false];

// TODO:
// be able to sort list by the name of the track
// clicking the add button with one track selected will add that single track
// clicking the add button with MORE than one track will add multiple tracks
	// tracks will have some kind of indication that the have been added
// can scroll through listbox
// can playmusic with double click




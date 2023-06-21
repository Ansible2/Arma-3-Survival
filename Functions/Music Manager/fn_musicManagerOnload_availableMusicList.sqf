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
	
	private _musicClass = _selectedListboxControl lnbData [_selectedIndex,0];
	uiNamespace setVariable ["BLWK_musicManager_selectedTrackToPlay",_musicClass];
}];

_availableSongsListControl ctrlAddEventHandler ["LBDblClick", {
	params ["_availableSongsListControl", "_selectedIndex"];

	private _musicClass = _selectedListboxControl lnbData [_selectedIndex,0];
	uiNamespace setVariable ["BLWK_musicManager_selectedTrackToPlay",_musicClass];

	[_musicClass,0] spawn BLWK_fnc_musicManager_playMusic;
}];


/* ----------------------------------------------------------------------------
	Generate List
---------------------------------------------------------------------------- */
// cache and/or get music info for list
// get classes
private "_musicMap";
if (isNil {localNamespace getVariable "BLWK_musicManager_musicMap"}) then {
	private _musicClasses = "true" configClasses (configFile >> "cfgMusic");

	// collect music info
	
	private _musicArray = _musicClasses apply {
		// name
		private _songName = getText(_x >> "name");
		if (_songName isEqualTo "") then {
			_songName = configName _x;
		};

		// duration
		private _songDuration = getNumber(_x >> "duration");
		private _songClassname = configName _x;

		[_songClassname,[_songName, str (round _songDuration), _songDuration]]
	};

	// sort by track name
	_musicArray = [_musicArray,[],{(_x select 1) select 0}] call BIS_fnc_sortBy;

	{
		// provide the index within _musicArray for a particular class
		// this will be used for finding the location within the available music list control (and avoid looping through the list)
		// so that we can selectively color entries depending on if they are in the current music list control
		private _songInfoArray = _x select 1;
		_songInfoArray pushBack _forEachIndex;
	} forEach _musicArray;

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
// can click on a single track and 


nil

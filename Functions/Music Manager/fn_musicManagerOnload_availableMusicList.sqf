#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_availableMusicList

Description:
	Populates the listboxes that shows all available tracks when the Music Manager
	 is openned.

	Important Note:
		While ideally a ListNBox would have been used to support multiple columns
		with the duration and name, support for multi select seems to not be available
		for ListNBox at the time of implementing this feature.

		Therefore, this what appears to be a single listNBox is actually two listboxes
		inside a controls group and their height maxed out to allow scrolling on the control
		group.

Parameters:
	0: _songListGroupControl : <CONTROL> - The control for the controls group that 
		has both the duration and name listboxes
	1: _songNamesListControl : <CONTROL> - The control for the ListBox with available music names
	2: _songDurationsListControl : <CONTROL> - The control for the ListBox with available music durations

Returns:
	NOTHING

Examples:
    (begin example)
		[
			_songListGroupControl,
			_songNamesListControl,
			_songDurationsListControl
		] call BLWK_fnc_musicManagerOnLoad_availableMusicList;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_availableMusicList";

params [
	"_songListGroupControl",
	"_songNamesListControl",
	"_songDurationsListControl"
];

/* ----------------------------------------------------------------------------
	Setup events
---------------------------------------------------------------------------- */
private _selectionCode = {
	params ["_selectedListboxControl","_selectedIndex"];

	private _otherListboxControl = controlNull;
	private _songNamesListControl = uiNamespace getVariable ["BLWK_musicManager_control_songNamesList",controlNull];
	private _songDurationsListControl = uiNamespace getVariable ["BLWK_musicManager_control_songDurationsList",controlNull];
	if (_selectedListboxControl isEqualTo _songDurationsListControl) then {
		_otherListboxControl = _songNamesListControl;
	} else {
		_otherListboxControl = _songDurationsListControl;
	};

	
	_otherListboxControl lbSetSelected [-1,false];
	private _selectedTrackClassnames = (lbSelection _selectedListboxControl) apply {
		_otherListboxControl lbSetSelected [_x,true];
		
		_selectedListboxControl lbData _x
	};
	uiNamespace setVariable ["BLWK_musicManager_selectedTracks",_selectedTrackClassnames];

	private _musicClass = _selectedListboxControl lbData _selectedIndex;
	uiNamespace setVariable ["BLWK_musicManager_playingTrack",_musicClass];
};



private _scrollCode = {
	params ["_selectedControl"];
};



private _doubleClickCode = {
	params ["_control", "_selectedIndex"];

	private _musicClass = _control lbData _selectedIndex;
	uiNamespace setVariable ["BLWK_musicManager_playingTrack",_musicClass];

	private _timeLineSlider = uiNamespace getVariable "BLWK_musicManager_control_timelineSlider";
	_timeLineSlider sliderSetPosition 0;

	private _musicMap = localNamespace getVariable "BLWK_musicManager_musicMap";
	private _musicDuration = (_musicMap get _musicClass) select 2;
	// TODO: need more of a one-stop-shop for translating a music class into playing
	// music, the fact that so many different places need logic to reset the slider
	// and change do play logic, etc. is smelly
	_timeLineSlider sliderSetRange [0,_musicDuration];

	[_musicClass,0] spawn BLWK_fnc_musicManager_playMusic;
};

[
	_songDurationsListControl,
	_songNamesListControl
] apply {
	_x ctrlAddEventHandler ["LBSelChanged",_selectionCode];
	_x ctrlAddEventHandler ["LBDblClick",_doubleClickCode];
	_x ctrlAddEventHandler ["MouseZChanged",_scrollCode];
};



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

private _numberOfSongs = count _musicMap;
private _heightOfControlGroup = (ctrlPosition _songListGroupControl) select 3;
private _heightOfControls = POS_H(_numberOfSongs) max _heightOfControlGroup;
[
	_numberOfSongs,
	_songNamesListControl,
	_songDurationsListControl,
	_heightOfControls
] spawn {
	params [
		"_numberOfSongs",
		"_songNamesListControl",
		"_songDurationsListControl",
		"_heightOfControls"
	];

	_songNamesListControl ctrlSetPositionH _heightOfControls;
	_songNamesListControl ctrlCommit 0.1;
	_songDurationsListControl ctrlSetPositionH _heightOfControls;
	_songDurationsListControl ctrlCommit 0.1;
};


{
	_y params ["_songName","_songDuration","_songIndex"];
	private _rowIndex = _songNamesListControl lbAdd _songName;
	_songDurationsListControl lbAdd _songDuration;

	private _songClassname = _x;
	_songNamesListControl lbSetData [_rowIndex,_songClassname];
	_songDurationsListControl lbSetData [_rowIndex,_songClassname];
	_songNamesListControl lbSetTooltip [_rowIndex,_songClassname];
	_songDurationsListControl lbSetTooltip [_rowIndex,_songClassname];
} forEach _musicMap;


// TODO:
// be able to sort list by the name of the track
// clicking the add button with one track selected will add that single track
// clicking the add button with MORE than one track will add multiple tracks
	// tracks will have some kind of indication that the have been added
// can scroll through listbox
// can playmusic with double click
// can click on a single track and 


nil

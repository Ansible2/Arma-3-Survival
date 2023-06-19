/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_availableMusicList

Description:
	Populates the ListNBox that shows all available tracks when the Music Manager
	 is openned.

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
// TODO: handle new controls
// reset music pause state when selection is changed
_songNamesListControl ctrlAddEventHandler ["LBSelChanged",{
	params ["_songNamesListControl","_selectedIndex"];

	private _display = ctrlParent _songNamesListControl;
	private _musicClass = _songNamesListControl lnbData [_selectedIndex,0];
	uiNamespace setVariable ["BLWK_musicManager_selectedTrack",_musicClass];
	//uiNamespace setVariable ["BLWK_musicManager_paused",false];

	// reset timeline slider to 0
	private _timeLineSlider = uiNamespace getVariable "BLWK_musicManager_control_timelineSlider";
	if ((sliderPosition _timeLineSlider) != 0) then {
		_timeLineSlider sliderSetPosition 0;
	};

	// adjust slider range to song duration
	private _musicDuration = [_songNamesListControl lnbText [_selectedIndex,1]] call BIS_fnc_parseNumber;
	_timeLineSlider sliderSetRange [0,_musicDuration];


	// play new track unless music is paused
	if !(uiNamespace getVariable ["BLWK_musicManager_paused",false]) then {
		[_musicClass,0] spawn BLWK_fnc_musicManager_playMusic;
	};

}];


// cache and/or get music info for list
// get classes
private "_musicHash";
if (isNil {missionNamespace getVariable "BLWK_musicManager_musicHash"}) then {
	private _musicClasses = "true" configClasses (configFile >> "cfgMusic");

	// collect music info
	private ["_name_temp","_duration_temp","_class_temp"];
	private _musicArray = [];
	_musicClasses apply {
		// name
		_name_temp = getText(_x >> "name");
		if (_name_temp isEqualTo "") then {
			_name_temp = configName _x;
		};

		// duration
		_duration_temp = round (getNumber(_x >> "duration"));
		_class_temp = configName _x;

		_musicArray pushBack [_class_temp,[_name_temp,_duration_temp]];
	};

	// sort by track name
	_musicArray = [_musicArray,[],{(_x select 1) select 0}] call BIS_fnc_sortBy;

	{
		// provide the index within _musicArray for a particular class
		// this will be used for finding the location within the available music list control (and avoid looping through the list)
		// so that we can selectively color entries depending on if they are in the current music list control
		(_x select 1) pushBack _forEachIndex;
	} forEach _musicArray;

	_musicHash = createHashMapFromArray _musicArray;
	missionNamespace setVariable ["BLWK_musicManager_musicHash",_musicHash];

} else {
	_musicHash = missionNamespace getVariable "BLWK_musicManager_musicHash";
};

// add duration column
_songNamesListControl lnbAddColumn 1;
_songNamesListControl lnbSetColumnsPos [0,0.82];

// fill list
private "_row";
{
	// track name and duration
	_row = _songNamesListControl lnbAddRow [_y select 0,str (_y select 1)];
	_songNamesListControl lnbSetData [[_row,0],_x]; // set data to the track class name
	_songNamesListControl lnbSetTooltip [[_row,0],_x];
} forEach _musicHash;


// Hashes are not sorted even when added from array.
_songNamesListControl lnbSort [0, false];


nil

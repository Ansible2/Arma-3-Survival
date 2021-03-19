/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_availableMusicList

Description:
	Populates the ListNBox that shows all available tracks when the Music Manager
	 is openned.

Parameters:
	0: _control : <CONTROL> - The control for the ListNBox with available music

Returns:
	NOTHING

Examples:
    (begin example)
		[_control] call BLWK_fnc_musicManagerOnLoad_availableMusicList;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_availableMusicList";

params ["_control"];

// reset music pause state when selection is changed
_control ctrlAddEventHandler ["LBSelChanged",{
	params ["_control","_selectedIndex"];
	
	private _display = ctrlParent _control;
	private _musicClass = _control lnbData [_selectedIndex,0];
	uiNamespace setVariable ["BLWK_musicManager_selectedTrack",_musicClass];
	//uiNamespace setVariable ["BLWK_musicManager_paused",false];

	// reset timeline slider to 0
	private _timeLineSlider = uiNamespace getVariable "BLWK_musicManager_control_timelineSlider";
	if ((sliderPosition _timeLineSlider) != 0) then {
		_timeLineSlider sliderSetPosition 0;
	};

	// adjust slider range to song duration
	private _musicDuration = [_control lnbText [_selectedIndex,1]] call BIS_fnc_parseNumber;
	_timeLineSlider sliderSetRange [0,_musicDuration];


	// play new track unless music is paused
	if !(uiNamespace getVariable ["BLWK_musicManager_paused",false]) then {
		[_musicClass,0] spawn BLWK_fnc_musicManager_playMusic;
	};

}];


// cache and/or get music info for list
// get classes
private "_musicClasses";
if (isNil {uiNamespace getVariable "BLWK_musicManager_allMusicClasses"}) then {		
	_musicClasses = "true" configClasses (configFile >> "cfgMusic");

	if (isClass (missionConfigFile >> "cfgMusic")) then {
		private _missionMusicClasses = "true" configClasses (missionConfigFile >> "cfgMusic");
		_musicClasses append _missionMusicClasses;
	};
	uiNamespace setVariable ["BLWK_musicManager_allMusicClasses",_musicClasses];
} else {
	_musicClasses = uiNamespace getVariable "BLWK_musicManager_allMusicClasses";
};


// music display names
private _musicNames = [];
if (isNil {uiNamespace getVariable "BLWK_musicManager_allMusicNames"}) then {
	private "_name_temp";
	_musicClasses apply {
		_name_temp = getText(_x >> "name");
		if (_name_temp isEqualTo "") then {
			_name_temp = configName _x;
		};
		_musicNames pushBack _name_temp;
	};
	uiNamespace setVariable ["BLWK_musicManager_allMusicNames",_musicNames];
} else {
	_musicNames = uiNamespace getVariable "BLWK_musicManager_allMusicNames";
};


// track durations
private _musicDurations = [];
if (isNil {uiNamespace getVariable "BLWK_musicManager_allMusicDurations"}) then {
	private "_duration_temp";
	_musicClasses apply {
		_duration_temp = round (getNumber(_x >> "duration"));
		_musicDurations pushBack _duration_temp;
	};
	uiNamespace setVariable ["BLWK_musicManager_allMusicDurations",_musicDurations];
} else {
	_musicDurations = uiNamespace getVariable "BLWK_musicManager_allMusicDurations";
};


// fill list
private "_row";
private _durationColumn = _control lnbAddColumn 1;
_control lnbSetColumnsPos [0,0.82];
{
	_row = _control lnbAddRow [_musicNames select _forEachIndex,str (_musicDurations select _forEachIndex)];
	_control lnbSetData [[_row,0],configName _x]; // set data to the track class name
} forEach _musicClasses;

_control lnbSort [0,false];
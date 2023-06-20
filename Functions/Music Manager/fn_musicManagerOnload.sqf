#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad

Description:
	This is the entry point for the Music Manager. It initializes its variables
	 and sets up relevant information to display when openned.

	It is executed from the (configed) onLoad event.

Parameters:
	0: _display : <DISPLAY> - The display of the Music Manager

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_musicManagerOnLoad;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad";

params ["_display"];

// prepare globals for controls
uiNamespace setVariable ["BLWK_musicManager_display",_display];


// close button
private _closeButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_CLOSE_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_closeButton",_closeButtonControl];
[_closeButtonControl] call BLWK_fnc_musicManagerOnLoad_closeButton;


// available tracks list
private _songListGroupControl = _display displayCtrl BLWK_MUSIC_MANAGER_SONG_GROUP_LIST_IDC;
private _songNamesListControl = _songListGroupControl controlsGroupCtrl BLWK_MUSIC_MANAGER_SONG_NAMES_LIST_IDC;
private _songDurationsListControl = _songListGroupControl controlsGroupCtrl BLWK_MUSIC_MANAGER_SONG_DURATIONS_LIST_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_songGroup",_songListGroupControl];
uiNamespace setVariable ["BLWK_musicManager_control_songNamesList",_songNamesListControl];
uiNamespace setVariable ["BLWK_musicManager_control_songDurationsList",_songDurationsListControl];
[
	_songListGroupControl,
	_songNamesListControl,
	_songDurationsListControl
] call BLWK_fnc_musicManagerOnLoad_availableMusicList;


// current playlist
private _currentPlaylistControl = _display displayCtrl BLWK_MUSIC_MANAGER_CURRENT_PLAYLIST_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_currentPlaylist",_currentPlaylistControl];
[_currentPlaylistControl,_display] call BLWK_fnc_musicManagerOnLoad_currentPlaylistLoop;


// add to and remove from current playlist buttons
private _addToButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_ADDTO_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_addToButton",_addToButtonControl];
private _removeFromButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_REMOVEFROM_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_removeFromButton",_removeFromButtonControl];
[_addToButtonControl,_removeFromButtonControl] call BLWK_fnc_musicManagerOnLoad_addAndRemoveButtons;


// system on off combo
private _onOffComboControl = _display displayCtrl BLWK_MUSIC_MANAGER_ONOFF_COMBO_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_onOffCombo",_onOffComboControl];
[_onOffComboControl,_display] spawn BLWK_fnc_musicManagerOnLoad_systemOnOffCombo;


// volume slider
private _volumeSliderControl = _display displayCtrl BLWK_MUSIC_MANAGER_VOLUME_SLIDER_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_volumeSLider",_volumeSliderControl];
[_volumeSliderControl] call BLWK_fnc_musicManagerOnLoad_volumeSlider;


// timeline slider
private _timelineSliderControl = _display displayCtrl BLWK_MUSIC_MANAGER_TIMELINE_SLIDER_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_timelineSlider",_timelineSliderControl];
[_timelineSliderControl] call BLWK_fnc_musicManagerOnLoad_timelineSlider;


// play pause buttons
private _playButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_PLAY_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_playButton",_playButtonControl];
private _pauseButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_PAUSE_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_pauseButton",_pauseButtonControl];
[_playButtonControl,_pauseButtonControl] call BLWK_fnc_musicManagerOnLoad_pauseAndPlayButtons;


// load playlist controls
private _loadComboControl = _display displayCtrl BLWK_MUSIC_MANAGER_LOAD_COMBO_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_loadCombo",_loadComboControl];
private _loadButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_LOAD_PLAYLIST_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_loadPlaylistButton",_loadButtonControl];
[_loadComboControl,_loadButtonControl] call BLWK_fnc_musicManagerOnLoad_loadControls;


// saves
private _saveEditControl = _display displayCtrl BLWK_MUSIC_MANAGER_SAVE_EDIT_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_saveEdit",_saveEditControl];
private _saveButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_SAVE_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_saveButton",_saveButtonControl];
private _saveAsButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_SAVEAS_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_saveAsButton",_saveAsButtonControl];
[_saveButtonControl,_saveAsButtonControl] call BLWK_fnc_musicManagerOnLoad_savePlaylistControls;


// track spacing group
private _spacingEditControl = _display displayCtrl BLWK_MUSIC_MANAGER_SPACING_EDIT_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_spacingEdit",_spacingEditControl];
private _spacingButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_SPACING_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_spacingButton",_spacingButtonControl];
private _spacingComboControl = _display displayCtrl BLWK_MUSIC_MANAGER_SPACING_COMBO_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_spacingCombo",_spacingComboControl];
[_spacingComboControl,_spacingEditControl,_spacingButtonControl] spawn BLWK_fnc_musicManagerOnLoad_trackSpacingControls;


// delete button
private _deleteButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_DELETE_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_deleteButton",_deleteButtonControl];
[_deleteButtonControl] call BLWK_fnc_musicManagerOnLoad_deleteButton;


// commit button
private _commitButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_COMMIT_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_commitButton",_commitButtonControl];
[_commitButtonControl] call BLWK_fnc_musicManagerOnLoad_commitButton;


_display displayAddEventHandler ["unload",{
	// stop music if playing
	if (uiNamespace getVariable ["BLWK_musicManager_doPlay",false]) then {
		playMusic "";
		[] call KISKA_fnc_musicStopEvent;
	};

	// clear memory
	[
		"BLWK_musicManager_display",
		"BLWK_musicManager_control_currentPlaylist",
		"BLWK_musicManager_control_songNamesList",
		"BLWK_musicManager_control_closeButton",
		"BLWK_musicManager_control_commitButton",
		"BLWK_musicManager_control_timelineSlider",
		"BLWK_musicManager_control_volumeSLider",
		"BLWK_musicManager_control_playButton",
		"BLWK_musicManager_control_pauseButton",
		"BLWK_musicManager_control_spacingEdit",
		"BLWK_musicManager_control_spacingButton",
		"BLWK_musicManager_control_spacingCombo",
		"BLWK_musicManager_control_onOffCombo",
		"BLWK_musicManager_control_saveEdit",
		"BLWK_musicManager_control_saveButton",
		"BLWK_musicManager_control_loadCombo",
		"BLWK_musicManager_control_addToButton",
		"BLWK_musicManager_control_removeFromButton",
		"BLWK_musicManager_control_deleteButton",
		"BLWK_musicManager_paused",
		"BLWK_musicManager_playingTrack",
		"BLWK_musicManager_selectedTracks",
		"BLWK_musicManager_doPlay",
		"BLWK_fnc_musicManager_getMusicName",
		"BLWK_musicManager_control_loadPlaylistButton",
		"BLWK_musicManager_loadCombo_currentSelection",
		"BLWK_musicManager_coloredClasses",
		"BLWK_musicManager_timelineLooping",
		"BLWK_musicManager_control_songNamesList",
		"BLWK_musicManager_control_songDurationsList"
	] apply {
		uiNamespace setVariable [_x,nil];
	};
	

}];


nil

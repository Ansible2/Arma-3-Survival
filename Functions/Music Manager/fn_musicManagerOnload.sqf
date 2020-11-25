#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
disableSerialization;

params ["_display"];

// prepare globals for controls
uiNamespace setVariable ["BLWK_musicManager_display",_display];


private _pausePlayIndicatorControl = _display displayCtrl BLWK_MUSIC_MANAGER_PAUSED_PLAYING_INDICATOR_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_pausePlayIndicator",_pausePlayIndicatorControl];



private _commitButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_COMMIT_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_commitButton",_commitButtonControl];


private _saveEditControl = _display displayCtrl BLWK_MUSIC_MANAGER_SAVE_EDIT_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_saveEdit",_saveEditControl];

private _saveButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_SAVE_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_saveButton",_saveButtonControl];


private _saveAsButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_SAVEAS_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_saveAsButton",_saveAsButtonControl];





private _deleteButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_DELETE_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_deleteButton",_deleteButtonControl];


// close button
private _closeButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_CLOSE_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_closeButton",_closeButtonControl];
[_closeButtonControl] call BLWK_fnc_musicManagerOnload_closeButton;
	
// available tracks list
private _songListControl = _display displayCtrl BLWK_MUSIC_MANAGER_SONGS_LIST_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_songsList",_songListControl];
[_songListControl] call BLWK_fnc_musicManagerOnload_availableMusicList;

// current playlist
private _currentPlaylistControl = _display displayCtrl BLWK_MUSIC_MANAGER_CURRENT_PLAYLIST_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_currentPlaylist",_currentPlaylistControl];
[_currentPlaylistControl,_display] call BLWK_fnc_musicManagerOnload_currentPlaylistLoop;


// add to and remove from current playlist buttons
private _addToButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_ADDTO_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_addToButton",_addToButtonControl];
private _removeFromButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_REMOVEFROM_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_removeFromButton",_removeFromButtonControl];
[_addToButtonControl,_removeFromButtonControl] call BLWK_fnc_musicManagerOnload_addAndRemoveButtons;

// system on off combo
private _onOffComboControl = _display displayCtrl BLWK_MUSIC_MANAGER_ONOFF_COMBO_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_onOffCombo",_onOffComboControl];
null = [_onOffComboControl,_display] spawn BLWK_fnc_musicManagerOnload_systemOnOffCombo;

// volume slider
private _volumeSliderControl = _display displayCtrl BLWK_MUSIC_MANAGER_VOLUME_SLIDER_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_volumeSLider",_volumeSliderControl];
[_volumeSliderControl] call BLWK_fnc_musicManagerOnload_volumeSlider;

// timeline slider
private _timelineSliderControl = _display displayCtrl BLWK_MUSIC_MANAGER_TIMELINE_SLIDER_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_timelineSlider",_timelineSliderControl];
[_timelineSliderControl] call BLWK_fnc_musicManagerOnload_timelineSlider;

// play pause buttons
private _playButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_PLAY_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_playButton",_playButtonControl];
private _pauseButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_PAUSE_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_pauseButton",_pauseButtonControl];
[_playButtonControl,_pauseButtonControl] call BLWK_fnc_musicManagerOnload_pauseAndPlayButtons;

// load playlist combo
private _loadComboControl = _display displayCtrl BLWK_MUSIC_MANAGER_LOAD_COMBO_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_loadCombo",_loadComboControl];
[_loadComboControl] call BLWK_fnc_musicManagerOnload_loadCombo;



// track spacing group
private _spacingEditControl = _display displayCtrl BLWK_MUSIC_MANAGER_SPACING_EDIT_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_spacingEdit",_spacingEditControl];
private _spacingButtonControl = _display displayCtrl BLWK_MUSIC_MANAGER_SPACING_BUTTON_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_spacingButton",_spacingButtonControl];
private _spacingComboControl = _display displayCtrl BLWK_MUSIC_MANAGER_SPACING_COMBO_IDC;
uiNamespace setVariable ["BLWK_musicManager_control_spacingCombo",_spacingComboControl];
null = [_spacingComboControl,_spacingEditControl,_spacingButtonControl] spawn BLWK_fnc_musicManagerOnload_trackSpacingControls;










_display displayAddEventHandler ["unload",{
	// stop music if playing
	if (uiNamespace getVariable ["BLWK_musicManager_doPlay",false]) then {
		playMusic "";
		call KISKA_fnc_musicStopEvent;
	};

	uiNamespace setVariable ["BLWK_musicManager_display",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_currentPlaylist",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_songsList",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_pausePlayIndicator",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_closeButton",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_commitButton",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_timelineSlider",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_volumeSLider",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_playButton",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_pauseButton",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_spacingEdit",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_spacingButton",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_spacingCombo",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_onOffCombo",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_saveEdit",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_saveButton",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_loadCombo",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_addToButton",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_removeFromButton",nil];
	uiNamespace setVariable ["BLWK_musicManager_control_deleteButton",nil];
	uiNamespace setVariable ["BLWK_musicManager_paused",nil];
	uiNamespace setVariable ["BLWK_musicManager_selectedTrack",nil];
	uiNamespace setVariable ["BLWK_musicManager_doPlay",nil];
	uiNamespace setVariable ["BLWK_fnc_musicManager_getMusicName",nil];
}];
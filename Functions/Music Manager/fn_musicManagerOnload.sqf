#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"

params ["_display"];
	
// available tracks list
[_display displayCtrl BLWK_MUSIC_MANAGER_SONGS_LIST_IDC] call BLWK_fnc_musicManagerOnload_availableMusicList;

// current playlist
[_display displayCtrl BLWK_MUSIC_MANAGER_CURRENT_PLAYLIST_IDC,_display] call BLWK_fnc_musicManagerOnload_currentPlaylistLoop;
// add to and remove from current playlist buttons
[
	_display displayCtrl BLWK_MUSIC_MANAGER_ADDTO_BUTTON_IDC,
	_display displayCtrl BLWK_MUSIC_MANAGER_REMOVEFROM_BUTTON_IDC
] call BLWK_fnc_musicManagerOnload_addAndRemoveButtons;

// system on off combo
null = [_display displayCtrl BLWK_MUSIC_MANAGER_ONOFF_COMBO_IDC,_display] spawn BLWK_fnc_musicManagerOnload_systemOnOffCombo;

// volume slider
private _volumeSlider_ctrl = _display displayCtrl BLWK_MUSIC_MANAGER_VOLUME_SLIDER_IDC;
_volumeSlider_ctrl sliderSetPosition (musicVolume);


null = [
	_display displayCtrl BLWK_MUSIC_MANAGER_SPACING_COMBO_IDC,
	_display displayCtrl BLWK_MUSIC_MANAGER_SPACING_EDIT_IDC,
	_display displayCtrl BLWK_MUSIC_MANAGER_SPACING_BUTTON_IDC
] spawn BLWK_fnc_musicManagerOnload_trackSpacingControls;
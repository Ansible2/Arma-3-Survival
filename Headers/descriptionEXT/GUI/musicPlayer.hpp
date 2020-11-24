#include "musicPlayerCommonDefines.hpp"
#define PROFILE_BACKGROUND_COLOR(ALPHA)\
{\
	"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",\
	ALPHA\
}
#define BORDER_COLOR(ALPHA) {0,0,0,ALPHA}
#define BACKGROUND_FRAME_COLOR(ALPHA) {0,0,0,ALPHA}
#define GREY_COLOR(PERCENT,ALPHA) {PERCENT,PERCENT,PERCENT,ALPHA}

//missionconfigfile >> "musicPlayerDialog"
/* -------------------------------------------------------------------------
	Base Classes
------------------------------------------------------------------------- */




/* -------------------------------------------------------------------------
	Dialog
------------------------------------------------------------------------- */
class musicPlayerDialog
{
	idd = BLWK_MUSIC_PLAYER_IDD;
	enableSimulation = true;
	onLoad = "_this call BLWK_fnc_onLoadMusicPlayerEvent";

	class controlsBackground
	{
		class musicPlayerDialog_background_frame: RscText
		{
			idc = -1;
			x = 0.253906 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.492188 * safezoneW;
			h = 0.53125 * safezoneH;
			colorBackground[] = GREY_COLOR(0.24,1);
		};
		class musicPlayerDialog_background_filler_1: RscText
		{
			idc = -1;
			x = 0.552734 * safezoneW + safezoneX;
			y = 0.416667 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.114583 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class musicPlayerDialog_background_filler_2: RscText
		{
			idc = -1;
			x = 0.552734 * safezoneW + safezoneX;
			y = 0.59375 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.15625 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class musicPlayerDialog_background_filler_3: RscText
		{
			idc = -1;
			x = 0.552734 * safezoneW + safezoneX;
			y = 0.552083 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
	};
	
	class controls
	{
		class musicPlayerDialog_listBox_currentPlaylist: RscListBox
		{
			idc = BLWK_MUSIC_PLAYER_CURRENT_PLAYLIST_IDC;

			x = 0.564453 * safezoneW + safezoneX;
			y = 0.416667 * safezoneH + safezoneY;
			w = 0.175781 * safezoneW;
			h = 0.333333 * safezoneH;
			colorBackground[] = GREY_COLOR(0,1);
			sizeEx = 0.0208333 * safezoneH;
		};
		class musicPlayerDialog_listNBox_availableSongs: RscListNBox
		{
			idc = BLWK_MUSIC_PLAYER_SONGS_LIST_IDC;
			//onLoad = "[(_this select 0)] call loadMusic";

			x = 0.259766 * safezoneW + safezoneX;
			y = 0.416667 * safezoneH + safezoneY;
			w = 0.292969 * safezoneW;
			h = 0.333333 * safezoneH;
			colorBackground[] = GREY_COLOR(0.24,1);
			sizeEx = 0.0208333 * safezoneH;
		};
		class musicPlayerDialog_headerText_playlistMaker: RscText
		{
			idc = -1;
			text = "Playlist Maker"; //--- ToDo: Localize;
			x = 0.253906 * safezoneW + safezoneX;
			y = 0.229167 * safezoneH + safezoneY;
			w = 0.427734 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicPlayerDialog_headerText_pausedOrPlayingIndicator: RscText
		{
			idc = BLWK_MUSIC_PLAYER_PAUSED_PLAYING_INDICATOR;
			text = "Playing"; //--- ToDo: Localize;
			x = 0.259766 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.480469 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class musicPlayerDialog_button_closeDialog: RscButton
		{
			idc = BLWK_MUSIC_PLAYER_CLOSE_BUTTON_IDC;

			text = "Close"; //--- ToDo: Localize;
			x = 0.681641 * safezoneW + safezoneX;
			y = 0.229167 * safezoneH + safezoneY;
			w = 0.0644531 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class musicPlayerDialog_button_commit: RscButton
		{
			idc = BLWK_MUSIC_PLAYER_COMMIT_BUTTON_IDC;

			text = "Commit Playlist"; //--- ToDo: Localize;
			x = 0.634766 * safezoneW + safezoneX;
			y = 0.28125 * safezoneH + safezoneY;
			w = 0.105469 * safezoneW;
			h = 0.0416667 * safezoneH;
		};
		class musicPlayerDialog_slider_timeline: RscXSliderH
		{
			idc = BLWK_MUSIC_PLAYER_TIMELINE_SLIDER_IDC;

			x = 0.242187 * safezoneW + safezoneX;
			y = 0.364583 * safezoneH + safezoneY;
			w = 0.515625 * safezoneW;
			h = 0.03125 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.25};
			sliderStep = 1;
		};
		class musicPlayerDialog_button_play: RscButton
		{
			idc = BLWK_MUSIC_PLAYER_PLAY_BUTTON_IDC;
			text = "Play"; //--- ToDo: Localize;
			x = 0.652344 * safezoneW + safezoneX;
			y = 0.333333 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class musicPlayerDialog_button_pause: RscButton
		{
			idc = BLWK_MUSIC_PLAYER_PAUSE_BUTTON_IDC;
			text = "Pause"; //--- ToDo: Localize;
			x = 0.294922 * safezoneW + safezoneX;
			y = 0.333333 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class musicPlayerDialog_headerText_currentPlaylist: RscText
		{
			idc = -1;

			text = "Current Playlist"; //--- ToDo: Localize;
			x = 0.564453 * safezoneW + safezoneX;
			y = 0.395833 * safezoneH + safezoneY;
			w = 0.175781 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicPlayerDialog_headerText_volume: RscText
		{
			idc = -1;

			text = "Volume:"; //--- ToDo: Localize;
			x = 0.435547 * safezoneW + safezoneX;
			y = 0.333333 * safezoneH + safezoneY;
			w = 0.0351563 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicPlayerDialog_slider_volume: RscXSliderH
		{
			idc = BLWK_MUSIC_PLAYER_VOLUME_SLIDER_IDC;

			x = 0.458984 * safezoneW + safezoneX;
			y = 0.333333 * safezoneH + safezoneY;
			w = 0.123047 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.25};
			sliderStep = 0.05;
			sliderRange = [0,2];
			//sliderPosition = 1;
		};
		class musicPlayerDialog_headerText_trackTitle: RscText
		{
			idc = -1;

			text = "Track Title"; //--- ToDo: Localize;
			x = 0.259766 * safezoneW + safezoneX;
			y = 0.395833 * safezoneH + safezoneY;
			w = 0.240234 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicPlayerDialog_headerText_duration: RscText
		{
			idc = -1;

			text = "Duration"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.395833 * safezoneH + safezoneY;
			w = 0.0644531 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicPlayerDialog_edit_trackSpacing: RscEdit
		{
			idc = BLWK_MUSIC_PLAYER_SPACING_EDIT_IDC;

			//text = "[200,250,300]"; //--- ToDo: Localize;
			x = 0.306641 * safezoneW + safezoneX;
			y = 0.302083 * safezoneH + safezoneY;
			w = 0.0585937 * safezoneW;
			h = 0.0208333 * safezoneH;
			
		};
		class musicPlayerDialog_button_trackSpacing: RscButton
		{
			idc = BLWK_MUSIC_PLAYER_SPACING_BUTTON_IDC;

			text = "Set Spacing"; //--- ToDo: Localize;
			x = 0.259766 * safezoneW + safezoneX;
			y = 0.302083 * safezoneH + safezoneY;
			w = 0.046875 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class musicPlayerDialog_comboBox_trackSpacing: RscCombo
		{
			idc = BLWK_MUSIC_PLAYER_SPACING_COMBO_IDC;

			x = 0.259766 * safezoneW + safezoneX;
			y = 0.28125 * safezoneH + safezoneY;
			w = 0.105469 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class musicPlayerDialog_comboBox_systemOnOff: RscCombo
		{
			idc = BLWK_MUSIC_PLAYER_ONOFF_COMBO_IDC;

			x = 0.634766 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.105469 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class musicPlayerDialog_edit_savePlaylist: RscEdit
		{
			idc = BLWK_MUSIC_PLAYER_SAVE_EDIT_IDC;

			text = "A PlayList name"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.291667 * safezoneH + safezoneY;
			w = 0.105469 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class musicPlayerDialog_comboBox_loadPlaylist: RscCombo
		{
			idc = BLWK_MUSIC_PLAYER_LOAD_COMBO_IDC;

			x = 0.394531 * safezoneW + safezoneX;
			y = 0.291667 * safezoneH + safezoneY;
			w = 0.105469 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class musicPlayerDialog_headerText_trackSpacing: RscText
		{
			idc = -1;
			text = "Track Spacing"; //--- ToDo: Localize;
			x = 0.259766 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.105469 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicPlayerDialog_button_savePlaylist: RscButton
		{
			idc = BLWK_MUSIC_PLAYER_SAVE_BUTTON_IDC;

			text = "Save Current Playlist"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.270833 * safezoneH + safezoneY;
			w = 0.105469 * safezoneW;
			h = 0.0208333 * safezoneH;
			//colorBackground[] = {-1,-1,-1,1};
		};
		class musicPlayerDialog_headerText_loadPlaylist: RscText
		{
			idc = -1;
			text = "Load Playlist"; //--- ToDo: Localize;
			x = 0.394531 * safezoneW + safezoneX;
			y = 0.270833 * safezoneH + safezoneY;
			w = 0.105469 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		
		class musicPlayerDialog_button_addToCurrentPlaylist: RscButton
		{
			idc = BLWK_MUSIC_PLAYER_ADDTO_BUTTON_IDC;

			text = "+"; //--- ToDo: Localize;
			x = 0.552734 * safezoneW + safezoneX;
			y = 0.53125 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;

			toolTip = "Add to Current Playlist";
		};
		class musicPlayerDialog_button_removeFromCurrentPlaylist: RscButton
		{
			idc = BLWK_MUSIC_PLAYER_REMOVEFROM_BUTTON_IDC;

			text = "-"; //--- ToDo: Localize;
			x = 0.552734 * safezoneW + safezoneX;
			y = 0.572917 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;

			toolTip = "Remove from Current Playlist";
		};
	};
};





#include "musicPlayerCommonDefines.hpp"
/*
 	you should populate the current playlist first and then have a check to see if the class
	is in the current playlist when populating the track list.

	Also cache the track list.
*/
uiNamespace setVariable ["BLWK_musicManager_allMusicClasses",nil];
uiNamespace setVariable ["BLWK_musicManager_allMusicNames",nil];
uiNamespace setVariable ["BLWK_musicManager_allMusicDurations",nil];

KISKA_fnc_getVariableTarget_sendBack = {
	params ["_namespace","_variableName","_saveVariable","_defaultValue","_sendBackTarget"];
	private _variable = _namespace getVariable [_variableName,_defaultValue];

	if (_sendBackTarget isEqualTo 0) then {
		if (remoteExecutedOwner isEqualTo 0) then { // never broadcast to all clients
			missionNamespace setVariable [_saveVariable,_variable];
			
			diag_log "KISKA_fnc_getVariableTarget_sendBack: Did not send back to 0 target, saved locally";
			diag_log "_saveVariable" + (str _saveVariable);
			diag_log "_variable" + (str _variable);
		} else {
			missionNamespace setVariable [_saveVariable,_variable,remoteExecutedOwner];
			
			diag_log "KISKA_fnc_getVariableTarget_sendBack: Sent variable back";
			diag_log "_saveVariable" + (str _saveVariable);
			diag_log "_variable" + (str _variable);
			diag_log "remoteExecutedOwner" + (str remoteExecutedOwner);
		};
	} else {
		missionNamespace setVariable [_saveVariable,_variable,_sendBackTarget];

		diag_log "KISKA_fnc_getVariableTarget_sendBack: Sent variable back";
		diag_log "_saveVariable" + (str _saveVariable);
		diag_log "_variable" + (str _variable);
		diag_log "_sendBackTarget" + (str _sendBackTarget);
	};
};

KISKA_fnc_getVariableTarget = {
	if (!canSuspend) exitWith {
		"KISKA_fnc_getVariableTarget: must be run scheduled" call BIS_fnc_error;
	};

	params [
		["_variableName","",[""]],
		["_namespace",missionNamespace,[missionNamespace,objNull,grpNull,"",controlNull,locationNull]],
		["_target",2,[123,objNull,grpNull,""]],
		["_defaultValue",nil],
		["_saveVariable","",[""]]
	];

	if (_variableName isEqualTo "") exitWith {
		"KISKA_fnc_getVariableTarget: _variableName is empty string ''" call BIS_fnc_error;
	};
	if (_saveVariable isEqualTo "") then {
		_saveVariable = "KISKA_getVariableTarget_" + _variableName;
	};

	[_namespace,_variableName,_saveVariable,_defaultValue,clientOwner] remoteExecCall ["KISKA_fnc_getVariableTarget_sendBack",_target];

	waitUntil {
		if (!isNil {missionNamespace getVariable _saveVariable}) exitWith {
			diag_log "KISKA_fnc_getVariableTarget: Got variable " + _saveVariable + " from target";
			true
		};
		sleep 0.5;
		diag_log "KISKA_fnc_getVariableTarget: Waiting for variable from target";
		false
	};

	private _return = missionNamespace getVariable _saveVariable;
	missionNamespace setVariable [_saveVariable,nil];

	_return
};


BLWK_fnc_musicManagerOnload_availableMusicList = {
	params ["_control"];

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
			_duration_temp = round ([_x >> "duration"] call BIS_fnc_getCfgData);
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
		_control lnbAddRow [_musicNames select _forEachIndex,str (_musicDurations select _forEachIndex)];
	} forEach _musicClasses;

	_control lnbSort [0,false];
};

BLWK_fnc_musicManagerOnload_systemOnOffCombo = {
	params ["_control","_display"];

	private _systemOn = ["KISKA_musicSystemIsRunning",missionNamespace,2,false] call KISKA_fnc_getVariableTarget;
	_control lbAdd "SYSTEM IS: OFF"; // 0
	_control lbAdd "SYSTEM IS: ON"; // 1
	_control ctrlSetFont "PuristaLight";
	_control lbSetCurSel ([0,1] select _systemOn);

	_control ctrlAddEventHandler ["onLBSelChanged",{
		params ["_control", "_selectedIndex"];
		
		private _display = ctrlParent _control;
		if (_selectedIndex isEqualTo 0) then {
			missionNamespace setVariable ["KISKA_musicSystemIsRunning",false,2];
		} else {
			missionNamespace setVariable ["KISKA_musicSystemIsRunning",true,2];
			
		};
	}];

};


BLWK_fnc_musicManagerOnLoad = {
	params ["_display"];
	
	// available tracks list
	[_display displayCtrl BLWK_MUSIC_MANAGER_SONGS_LIST_IDC] call BLWK_fnc_musicManagerOnload_availableMusicList;
	


	// system on off combo
	null = [_display,_display displayCtrl BLWK_MUSIC_MANAGER_ONOFF_COMBO_IDC] spawn BLWK_fnc_musicManagerOnload_systemOnOffCombo;


	// volume slider
	private _volumeSlider_ctrl = _display displayCtrl BLWK_MUSIC_MANAGER_VOLUME_SLIDER_IDC;
	_volumeSlider_ctrl sliderSetPosition (musicVolume);
	

	// track spacing combo 
	// this will need to be auto adjusted based off of what the global is currently equal to
	// will also need a function to adjust the global value to keep things from getting messed up
	// will also need to change the edit box tooltip based upon what the combo is or the combo tooltip
	private _trackSpacingCombo_ctrl = _display displayCtrl BLWK_MUSIC_MANAGER_SPACING_COMBO_IDC;
	_trackSpacingCombo_ctrl lbAdd "Random Max";
	_trackSpacingCombo_ctrl lbSetTooltip [0,"You will get a random number between 0 and this number."];

	_trackSpacingCombo_ctrl lbAdd "Random Bell Curve";
	_trackSpacingCombo_ctrl lbSetTooltip [1,"[min,mid,max]. Time between tracks will likely be close to the 'mid' value but can be anything between 'min' and 'max'."];

	_trackSpacingCombo_ctrl lbAdd "Exact Time Between";
	_trackSpacingCombo_ctrl lbSetTooltip [2,"Time between tracks will ALWAYS be this many seconds."];

	_trackSpacingCombo_ctrl ctrlSetFont "PuristaLight";
	_trackSpacingCombo_ctrl lbSetCurSel 0; // set to random max

};

BLWK_fnc_popList = {
	params ["_control"];

	hint str _control;

	_display = ctrlParent _control;
	
	_plus = _display ctrlCreate ["RscButtonMenu",198,_display displayCtrl 1500];
	_plus ctrlSetText ">";
	_minus = _display ctrlCreate ["RscButtonMenu",199,_display displayCtrl 1500];
	_minus ctrlSettext "<";

	_control lnbAddRow ["#1","#2"];
};
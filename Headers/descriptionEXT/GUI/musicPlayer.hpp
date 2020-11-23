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
			colorBackground[] = {-1,-1,-1,0.25};
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
			colorBackground[] = {-1,-1,-1,0.25};
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
			colorBackground[] = {-1,-1,-1,0.25};
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

			text = "[200,250,300]"; //--- ToDo: Localize;
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

			text = ">"; //--- ToDo: Localize;
			x = 0.552734 * safezoneW + safezoneX;
			y = 0.53125 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class musicPlayerDialog_button_removeFromCurrentPlaylist: RscButton
		{
			idc = BLWK_MUSIC_PLAYER_REMOVEFROM_BUTTON_IDC;

			text = "<"; //--- ToDo: Localize;
			x = 0.552734 * safezoneW + safezoneX;
			y = 0.572917 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
	};
};


/*
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Gill, v1.063, #Buzygo)
////////////////////////////////////////////////////////

class musicPlayerDialog_listBox_currentPlaylist: RscText
{
	idc = 61501;

	x = 0.564453 * safezoneW + safezoneX;
	y = 0.354167 * safezoneH + safezoneY;
	w = 0.175781 * safezoneW;
	h = 0.333333 * safezoneH;
	colorBackground[] = {-1,-1,-1,0.25};
	sizeEx = 0.0208333 * safezoneH * UI_GRID_H;
};
class musicPlayerDialog_listNBox_availableSongs: RscText
{
	idc = 61501;
	onLoad = "[(_this select 0)] call loadMusic";

	x = 0.259766 * safezoneW + safezoneX;
	y = 0.354167 * safezoneH + safezoneY;
	w = 0.292969 * safezoneW;
	h = 0.333333 * safezoneH;
	colorBackground[] = {-1,-1,-1,0.25};
	sizeEx = 0.0208333 * safezoneH * UI_GRID_H;
};
class musicPlayerDialog_headerText_playlistMaker: RscText
{
	idc = 1004;
	text = "Playlist Maker"; //--- ToDo: Localize;
	x = 0.253906 * safezoneW + safezoneX;
	y = 0.229167 * safezoneH + safezoneY;
	w = 0.427734 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_headerText_pausedOrPlayingIndicator: RscText
{
	idc = 1005;
	text = "Playing"; //--- ToDo: Localize;
	x = 0.259766 * safezoneW + safezoneX;
	y = 0.6875 * safezoneH + safezoneY;
	w = 0.480469 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_button_closeDialog: RscButton
{
	idc = 1600;

	text = "Close"; //--- ToDo: Localize;
	x = 0.681641 * safezoneW + safezoneX;
	y = 0.229167 * safezoneH + safezoneY;
	w = 0.0644531 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class musicPlayerDialog_button_commit: RscButton
{
	idc = 1608;

	text = "Commit Playlist"; //--- ToDo: Localize;
	x = 0.634766 * safezoneW + safezoneX;
	y = 0.28125 * safezoneH + safezoneY;
	w = 0.105469 * safezoneW;
	h = 0.0416667 * safezoneH;
};
class musicPlayerDialog_slider_playing: RscText
{
	idc = 1900;

	x = 0.242187 * safezoneW + safezoneX;
	y = 0.708333 * safezoneH + safezoneY;
	w = 0.515625 * safezoneW;
	h = 0.03125 * safezoneH;
	colorBackground[] = {-1,-1,-1,0.25};
};
class musicPlayerDialog_button_play: RscButton
{
	idc = 1603;
	text = "Play"; //--- ToDo: Localize;
	x = 0.435547 * safezoneW + safezoneX;
	y = 0.75 * safezoneH + safezoneY;
	w = 0.0527344 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class musicPlayerDialog_button_pause: RscButton
{
	idc = 1604;
	text = "Pause"; //--- ToDo: Localize;
	x = 0.511719 * safezoneW + safezoneX;
	y = 0.75 * safezoneH + safezoneY;
	w = 0.0527344 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class musicPlayerDialog_headerText_currentPlaylist: RscText
{
	idc = 1001;

	text = "Current Playlist"; //--- ToDo: Localize;
	x = 0.564453 * safezoneW + safezoneX;
	y = 0.333333 * safezoneH + safezoneY;
	w = 0.175781 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_headerText_volume: RscText
{
	idc = 1002;

	text = "Volume:"; //--- ToDo: Localize;
	x = 0.582031 * safezoneW + safezoneX;
	y = 0.75 * safezoneH + safezoneY;
	w = 0.0351563 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_slider_volume: RscText
{
	idc = 1901;

	x = 0.599609 * safezoneW + safezoneX;
	y = 0.75 * safezoneH + safezoneY;
	w = 0.128906 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,0.25};
};
class musicPlayerDialog_headerText_trackTitle: RscText
{
	idc = 1001;

	text = "Track Title"; //--- ToDo: Localize;
	x = 0.259766 * safezoneW + safezoneX;
	y = 0.333333 * safezoneH + safezoneY;
	w = 0.240234 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_headerText_duration: RscText
{
	idc = 1001;

	text = "Duration"; //--- ToDo: Localize;
	x = 0.5 * safezoneW + safezoneX;
	y = 0.333333 * safezoneH + safezoneY;
	w = 0.0644531 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_edit_trackSpacing: RscEdit
{
	idc = 1400;

	text = "[200,250,300]"; //--- ToDo: Localize;
	x = 0.306641 * safezoneW + safezoneX;
	y = 0.302083 * safezoneH + safezoneY;
	w = 0.0585937 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class musicPlayerDialog_button_trackSpacing: RscButton
{
	idc = 1600;

	text = "Set Spacing"; //--- ToDo: Localize;
	x = 0.259766 * safezoneW + safezoneX;
	y = 0.302083 * safezoneH + safezoneY;
	w = 0.046875 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_comboBox_trackSpacing: RscCombo
{
	idc = 2100;

	x = 0.259766 * safezoneW + safezoneX;
	y = 0.28125 * safezoneH + safezoneY;
	w = 0.105469 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class musicPlayerDialog_comboBox_systemOnOff: RscCombo
{
	idc = 2101;

	x = 0.634766 * safezoneW + safezoneX;
	y = 0.260417 * safezoneH + safezoneY;
	w = 0.105469 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class musicPlayerDialog_edit_savePlaylist: RscEdit
{
	idc = 1400;

	text = "A PlayList name"; //--- ToDo: Localize;
	x = 0.5 * safezoneW + safezoneX;
	y = 0.291667 * safezoneH + safezoneY;
	w = 0.105469 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class musicPlayerDialog_comboBox_loadPlaylist: RscCombo
{
	idc = 2100;

	x = 0.394531 * safezoneW + safezoneX;
	y = 0.291667 * safezoneH + safezoneY;
	w = 0.105469 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class musicPlayerDialog_headerText_trackSpacing: RscText
{
	idc = 1015;
	text = "Track Spacing"; //--- ToDo: Localize;
	x = 0.259766 * safezoneW + safezoneX;
	y = 0.260417 * safezoneH + safezoneY;
	w = 0.105469 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_button_savePlaylist: RscButton
{
	idc = 1600;

	text = "Save Current Playlist"; //--- ToDo: Localize;
	x = 0.5 * safezoneW + safezoneX;
	y = 0.270833 * safezoneH + safezoneY;
	w = 0.105469 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_headerText_loadPlaylist: RscText
{
	idc = 1016;
	text = "Load Playlist"; //--- ToDo: Localize;
	x = 0.394531 * safezoneW + safezoneX;
	y = 0.270833 * safezoneH + safezoneY;
	w = 0.105469 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_background_frame: RscText
{
	idc = 1017;
	x = 0.253906 * safezoneW + safezoneX;
	y = 0.25 * safezoneH + safezoneY;
	w = 0.492188 * safezoneW;
	h = 0.53125 * safezoneH;
	colorBackground[] = {-1,-1,-1,0.1};
};
class musicPlayerDialog_button_addToCurrentPlaylist: RscButton
{
	idc = 1600;

	text = ">"; //--- ToDo: Localize;
	x = 0.552734 * safezoneW + safezoneX;
	y = 0.46875 * safezoneH + safezoneY;
	w = 0.0117188 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class musicPlayerDialog_button_removeFromCurrentPlaylist: RscButton
{
	idc = 1600;

	text = "<"; //--- ToDo: Localize;
	x = 0.552734 * safezoneW + safezoneX;
	y = 0.510417 * safezoneH + safezoneY;
	w = 0.0117188 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class RscText_1018: RscText
{
	idc = 1018;
	x = 0.552734 * safezoneW + safezoneX;
	y = 0.489583 * safezoneH + safezoneY;
	w = 0.0117188 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_background_filler_1: RscText
{
	idc = 1019;
	x = 0.552734 * safezoneW + safezoneX;
	y = 0.354167 * safezoneH + safezoneY;
	w = 0.0117188 * safezoneW;
	h = 0.114583 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class musicPlayerDialog_background_filler_2: RscText
{
	idc = 1020;
	x = 0.552734 * safezoneW + safezoneX;
	y = 0.53125 * safezoneH + safezoneY;
	w = 0.0117188 * safezoneW;
	h = 0.15625 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

*/
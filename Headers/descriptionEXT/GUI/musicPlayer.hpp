#include "musicPlayerCommonDefines.hpp"
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
	
	class controlsBackground
	{
		class musicPlayerDialog_background_frame: RscText
		{
			idc = 1017;
			x = 0.253906 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.492188 * safezoneW;
			h = 0.53125 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.85};
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
		class musicPlayerDialog_background_filler_3: RscText
		{
			idc = 1018;
			x = 0.552734 * safezoneW + safezoneX;
			y = 0.489583 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
	};
	
	class controls
	{
		class musicPlayerDialog_listBox_currentPlaylist: RscListBox
		{
			idc = 61501;

			x = 0.564453 * safezoneW + safezoneX;
			y = 0.354167 * safezoneH + safezoneY;
			w = 0.175781 * safezoneW;
			h = 0.333333 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.25};
			sizeEx = 0.0208333 * safezoneH;
		};
		class musicPlayerDialog_listNBox_availableSongs: RscListNBox
		{
			idc = 61501;
			onLoad = "[(_this select 0)] call loadMusic";

			x = 0.259766 * safezoneW + safezoneX;
			y = 0.354167 * safezoneH + safezoneY;
			w = 0.292969 * safezoneW;
			h = 0.333333 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.25};
			sizeEx = 0.0208333 * safezoneH;
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
		class musicPlayerDialog_slider_playing: RscXSliderH
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
		class musicPlayerDialog_slider_volume: RscXSliderH
		{
			idc = 1901;

			x = 0.605469 * safezoneW + safezoneX;
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
			//colorBackground[] = {-1,-1,-1,1};
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
	};
};
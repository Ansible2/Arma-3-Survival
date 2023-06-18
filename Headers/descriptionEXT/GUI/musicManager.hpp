#include "musicManagerCommonDefines.hpp"
#define PROFILE_BACKGROUND_COLOR(ALPHA)\
{\
	"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",\
	ALPHA\
}
//#define BORDER_COLOR(ALPHA) {0,0,0,ALPHA}
#define BACKGROUND_FRAME_COLOR(ALPHA) {0,0,0,ALPHA}
#define GREY_COLOR(PERCENT,ALPHA) {PERCENT,PERCENT,PERCENT,ALPHA}

/* -------------------------------------------------------------------------
	Base Classes
------------------------------------------------------------------------- */

class musicManagerDialogSliderX: RscXSliderH
{
	colorBackground[] = {-1,-1,-1,0.25};
	arrowEmpty = "images\transparent.paa";
	arrowFull = "images\transparent.paa";
	lineSize = 0;
};
class musicManagerDialogButton: RscButton
{
	colorBackground[] = GREY_COLOR(0.5,0.25);
	colorBackgroundActive[] = GREY_COLOR(0.5,0.65);
	colorFocused[] = GREY_COLOR(0.5,0.25);
	colorDisabled[] = {1,1,1,0.25};
	colorBackgroundDisabled[] = {0,0,0,0.5};
	colorShadow[] = {0,0,0,1};
	colorBorder[] = {0,0,0,1};
};
// missionconfigfile >> "musicManagerDialog"
/* -------------------------------------------------------------------------
	Dialog
------------------------------------------------------------------------- */
class musicManagerDialog
{
	idd = BLWK_MUSIC_MANAGER_IDD;
	enableSimulation = true;
	onLoad = "_this call BLWK_fnc_musicManagerOnLoad";

	class controlsBackground
	{
		class musicManagerDialogBackground_frame: RscText
		{
			idc = -1;
			x = POS_X(-21);
			y = POS_Y(-12);
			w = POS_W(42);
			h = POS_H(25.5);
			colorBackground[] = GREY_COLOR(0.24,0.7);
		};
		class musicManagerDialogBackground_filler_1: RscText
		{
			idc = -1;
			x = POS_X(4.5);
			y = POS_Y(-4);
			w = POS_W(1);
			h = POS_H(5.5);
			colorBackground[] = {-1,-1,-1,1};
		};
		class musicManagerDialogBackground_filler_2: musicManagerDialogBackground_filler_1
		{
			y = POS_Y(4.5);
			h = POS_H(7.5);
		};
		class musicManagerDialogBackground_filler_3: musicManagerDialogBackground_filler_1
		{
			y = POS_Y(2.5);
			h = POS_H(1);
		};
		class musicManagerDialogBackground_filler_4: RscText
		{
			idc = -1;
			text = "";
			
			x = POS_X(-20.5);
			y = POS_Y(12);
			w = POS_W(41);
			h = POS_H(1);
			
			colorBackground[] = {-1,-1,-1,1};
		};
	};
	
	class controls
	{
		class musicManagerDialogListBox_currentPlaylist: RscListBox
		{
			idc = BLWK_MUSIC_MANAGER_CURRENT_PLAYLIST_IDC;
			x = POS_X(5.5);
			y = POS_Y(-4);
			w = POS_W(15);
			h = POS_H(16);

			style = LB_MULTI + LB_TEXTURES;
			colorBackground[] = GREY_COLOR(0,1);
			sizeEx = 0.0208333 * safezoneH;
		};
		class musicManagerDialog_availableSongsGroup : RscControlsGroupNoHScrollbars
		{
			idc = BLWK_MUSIC_MANAGER_SONG_GROUP_LIST_IDC;
			x = POS_X(-20.5);
			y = POS_Y(-4);
			w = POS_W(25);
			h = POS_H(16);
			
			class controls
			{
				class musicManagerDialogListBox_availableSongNames: ctrlListBox
				{
					idc = BLWK_MUSIC_MANAGER_SONG_NAMES_LIST_IDC;
					style = LB_MULTI + LB_TEXTURES;
					// x = POS_X();
					// y = POS_Y();
					w = POS_W(20.5);
					h = POS_H(16);
			
					sizeEx = 0.0208333 * safezoneH;
					colorBackground[] = GREY_COLOR(0.24,1);
				};
				class musicManagerDialogListBox_availableSongDurations: musicManagerDialogListBox_availableSongNames
				{
					idc = BLWK_MUSIC_MANAGER_SONG_DURATIONS_LIST_IDC;
					x = POS_X(20.5);
					// y = POS_Y();
					w = POS_W(4.5);
					h = POS_H(16);
			
				};
			};
		};
		
		class musicManagerDialogHeaderText_musicManager: RscText
		{
			idc = -1;
			text = "Music Manager"; //--- ToDo: Localize;
			x = POS_X(-21);
			y = POS_Y(-13);
			w = POS_W(36.5);
			h = POS_H(1);
			
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicManagerDialogButton_closeDialog: musicManagerDialogButton
		{
			idc = BLWK_MUSIC_MANAGER_CLOSE_BUTTON_IDC;

			text = "Close"; //--- ToDo: Localize;
			x = POS_X(15.5);
			y = POS_Y(-13);
			w = POS_W(5.5);
			h = POS_H(1);
			
			colorBackground[] = {1,0,0,0.45};
			colorBackgroundActive[] = {1,0,0,0.75};
			colorFocused[] = {1,0,0,0.45};
		};
		class musicManagerDialogButton_commit: musicManagerDialogButton
		{
			idc = BLWK_MUSIC_MANAGER_COMMIT_BUTTON_IDC;

			text = "Commit Playlist To Server"; //--- ToDo: Localize;
			x = POS_X(11.5);
			y = POS_Y(-10.5);
			w = POS_W(9);
			h = POS_H(2);
			
			colorBackground[] = {1,0,0,0.45};
			colorBackgroundActive[] = {1,0,0,0.75};
			colorFocused[] = {1,0,0,0.45};

			toolTip = "Save Current Playlist to the server for use with the system";
		};
		class musicManagerDialogSlider_timeline: musicManagerDialogSliderX
		{
			idc = BLWK_MUSIC_MANAGER_TIMELINE_SLIDER_IDC;
			x = POS_X(-22);
			y = POS_Y(-6.5);
			w = POS_W(44);
			h = POS_H(1.5);
			
			sliderStep = 0.01;
		};
		class musicManagerDialogButton_play: musicManagerDialogButton
		{
			idc = BLWK_MUSIC_MANAGER_PLAY_BUTTON_IDC;
			text = "Play"; //--- ToDo: Localize;
			x = POS_X(13);
			y = POS_Y(-8);
			w = POS_W(4.5);
			h = POS_H(1);
			
		};
		class musicManagerDialogButton_pause: musicManagerDialogButton
		{
			idc = BLWK_MUSIC_MANAGER_PAUSE_BUTTON_IDC;
			text = "Pause"; //--- ToDo: Localize;
			x = POS_X(-17.5);
			y = POS_Y(-8);
			w = POS_W(4.5);
			h = POS_H(1);
			
		};
		class musicManagerDialogHeaderText_currentPlaylist: RscText
		{
			idc = -1;

			text = "Current Playlist"; //--- ToDo: Localize;
			x = POS_X(5.5);
			y = POS_Y(-5);
			w = POS_W(15);
			h = POS_H(1);
			
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicManagerDialogHeaderText_volume: RscText
		{
			idc = -1;

			text = "Volume:"; //--- ToDo: Localize;
			x = POS_X(-5.5);
			y = POS_Y(-8);
			w = POS_W(3);
			h = POS_H(1);
			
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicManagerDialogSlider_volume: musicManagerDialogSliderX
		{
			idc = BLWK_MUSIC_MANAGER_VOLUME_SLIDER_IDC;
			x = POS_X(-3.5);
			y = POS_Y(-8);
			w = POS_W(10.5);
			h = POS_H(1);
			
			sliderStep = 0.05;
			sliderRange = [0,1];
		};
		class musicManagerDialogHeaderText_trackTitle: RscText
		{
			idc = -1;

			text = "Track Title"; //--- ToDo: Localize;

			x = POS_X(-20.5);
			y = POS_Y(-5);
			w = POS_W(20.5);
			h = POS_H(1);
			
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicManagerDialogHeaderText_duration: RscText
		{
			idc = -1;

			text = "Duration"; //--- ToDo: Localize;

			x = POS_X(0);
			y = POS_Y(-5);
			w = POS_W(20.5);
			h = POS_H(1);
			
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicManagerDialogEdit_trackSpacing: RscEdit
		{
			idc = BLWK_MUSIC_MANAGER_SPACING_EDIT_IDC;

			//text = "[200,250,300]"; //--- ToDo: Localize;

			x = POS_X(-16.5);
			y = POS_Y(-9.5);
			w = POS_W(5);
			h = POS_H(1);
			
			colorBackground[] = GREY_COLOR(1,0.25);
			
		};
		class musicManagerDialogButton_trackSpacing: musicManagerDialogButton
		{
			idc = BLWK_MUSIC_MANAGER_SPACING_BUTTON_IDC;

			text = "Set Spacing"; //--- ToDo: Localize;

			x = POS_X(-20.5);
			y = POS_Y(-9.5);
			w = POS_W(4);
			h = POS_H(1);
			
			toolTip = "Setting will be saved to the server";
		};
		class musicManagerDialogComboBox_trackSpacing: RscCombo
		{
			idc = BLWK_MUSIC_MANAGER_SPACING_COMBO_IDC;
			x = POS_X(-20.5);
			y = POS_Y(-10.5);
			w = POS_W(-);
			h = POS_H(1);
			
		};
		class musicManagerDialogComboBox_systemOnOff: RscCombo
		{
			idc = BLWK_MUSIC_MANAGER_ONOFF_COMBO_IDC;
			x = POS_X(11.5);
			y = POS_Y(-11.5);
			w = POS_W(9);
			h = POS_H(1);
			
		};
		class musicManagerDialogEdit_savePlaylist: RscEdit
		{
			idc = BLWK_MUSIC_MANAGER_SAVE_EDIT_IDC;

			text = "A Playlist Name"; //--- ToDo: Localize;

			x = POS_X(0);
			y = POS_Y(-10);
			w = POS_W(9);
			h = POS_H(1);
			
			maxChars = 20;
			colorBackground[] = GREY_COLOR(1,0.25);
		};
		class musicManagerDialogComboBox_loadPlaylist: RscCombo
		{
			idc = BLWK_MUSIC_MANAGER_LOAD_COMBO_IDC;
			x = POS_X(-6.5);
			y = POS_Y(-11);
			w = POS_W(6.5);
			h = POS_H(1);
		};
		class musicManagerDialogHeaderText_trackSpacing: RscText
		{
			idc = -1;
			text = "Track Spacing"; //--- ToDo: Localize;

			x = POS_X(-20.5);
			y = POS_Y(-11.5);
			w = POS_W(9);
			h = POS_H(1);
			
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class musicManagerDialogButton_savePlaylist: musicManagerDialogButton
		{
			idc = BLWK_MUSIC_MANAGER_SAVE_BUTTON_IDC;

			text = "Save"; //--- ToDo: Localize;

			x = POS_X(4.5);
			y = POS_Y(-11);
			w = POS_W(4.5);
			h = POS_H(1);
			
			toolTip = "Save over the current list selected in the drop down";
		};
		class musicManagerDialogButton_saveAsPlaylist: musicManagerDialogButton
		{
			idc = BLWK_MUSIC_MANAGER_SAVEAS_BUTTON_IDC;

			text = "Save As"; //--- ToDo: Localize;

			x = POS_X(0);
			y = POS_Y(-11);
			w = POS_W(4.5);
			h = POS_H(1);
			
			toolTip = "Save a new playlist based upon the edit box";
		};
		class musicManagerDialogButton_deletePlaylist: musicManagerDialogButton
		{
			idc = BLWK_MUSIC_MANAGER_DELETE_BUTTON_IDC;

			text = "Delete"; //--- ToDo: Localize;

			x = POS_X(-9);
			y = POS_Y(-11);
			w = POS_W(2.5);
			h = POS_H(1);
			
			toolTip = "Delete the currently selected list in the drop down";
		};
		class musicManagerDialogHeaderText_loadPlaylist: musicManagerDialogButton
		{
			idc = BLWK_MUSIC_MANAGER_LOAD_PLAYLIST_BUTTON_IDC;
			text = "Load Playlist"; //--- ToDo: Localize;

			x = POS_X(-6.5);
			y = POS_Y(-11);
			w = POS_W(6.5);
			h = POS_H(1);
			
			
			toolTip = "Load selected item into Current Playlist";
		};
		
		class musicManagerDialogButton_addToCurrentPlaylist: musicManagerDialogButton
		{
			idc = BLWK_MUSIC_MANAGER_ADDTO_BUTTON_IDC;

			text = "+"; //--- ToDo: Localize;

			x = POS_X(4.5);
			y = POS_Y(1.5);
			w = POS_W(1);
			h = POS_H(1);
			
			toolTip = "Add to Current Playlist";
		};
		class musicManagerDialogButton_removeFromCurrentPlaylist: musicManagerDialogButton
		{
			idc = BLWK_MUSIC_MANAGER_REMOVEFROM_BUTTON_IDC;

			text = "-"; //--- ToDo: Localize;

			x = POS_X(4.5);
			y = POS_Y(3.5);
			w = POS_W(1);
			h = POS_H(1);
			
			toolTip = "Remove from Current Playlist";
		};
	};
};
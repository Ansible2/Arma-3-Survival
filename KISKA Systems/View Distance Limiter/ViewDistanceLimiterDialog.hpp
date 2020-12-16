#include "viewDistanceLimiterBases.hpp"

class VIEW_DISTANCE_LIMITER_DIALOG 
{
	idd = VIEW_DISTANCE_LIMITER_DIALOG_IDD;
	movingEnabled = true;
	enableSimulation = true;
	onLoad = "[_this select 0] call KISKA_fnc_handleVDLDialogOpen";
	onUnload = "hintSilent ''";

	class controls
	{
		/* -------------------------------------------------------------------------
			General Controls
		------------------------------------------------------------------------- */
		class VDL_FRAME: VDL_RSC_FRAME_BASE
		{
			idc = VDL_FRAME_IDC;

			x = 0.699219 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.458333 * safezoneH;
		};
		class VDL_HEADER_TEXT: VDL_RSC_TEXT_BASE
		{
			idc = VDL_HEADER_TEXT_IDC;

			text = "VIEW DISTANCE LIMITER"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = PROFILE_BACKGROUND_COLOR(0.65);
			style = ST_CENTER;
			sizeEx = 0.0208333 * safezoneH;
		};
		class VDL_CLOSE_DIALOG_BUTTON: VDL_RSC_BUTTON_BASE
		{
			idc = VDL_CLOSE_DIALOG_BUTTON_IDC;

			text = "Close Interface"; //--- ToDo: Localize;
			x = 0.757813 * safezoneW + safezoneX;
			y = 0.28125 * safezoneH + safezoneY;
			w = 0.0820313 * safezoneW;
			h = 0.0208333 * safezoneH;
			onMouseButtonClick = "closeDialog 2";
			sizeEx = 0.0208333 * safezoneH;
		};
		class VDL_SET_ALL_BUTTON: VDL_RSC_BUTTON_BASE
		{
			idc = VDL_SET_ALL_BUTTON_IDC;

			text = "Set All Changes"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.6875 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.03125 * safezoneH;
			onButtonClick = "_this call KISKA_fnc_setAllVDLButton";
			sizeEx = 0.03125 * safezoneH;
		};
		class VDL_SYSTEM_ON_CHECKBOX: VDL_RSC_CHECKBOX_BASE
		{
			idc = VDL_SYSTEM_ON_CHECKBOX_IDC;

			x = 0.746094 * safezoneW + safezoneX;
			y = 0.28125 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorText[] = {-1,-1,-1,1};
			colorActive[] = {-1,-1,-1,1};
			onCheckedChanged = "_this call KISKA_fnc_handleVdlGUICheckBox";
			onload = "(_this select 0) cbSetChecked (call KISKA_fnc_isVDLSystemRunning)";
		};
		class VDL_SYSTEM_ON_TEXT: VDL_RSC_TEXT_BASE
		{
			idc = VDL_SYSTEM_ON_TEXT_IDC;

			text = "System On:"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.28125 * safezoneH + safezoneY;
			w = 0.046875 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
			sizeEx = 0.0208333 * safezoneH;
		};
		/* -------------------------------------------------------------------------
			Target FPS
		------------------------------------------------------------------------- */
		class VDL_SET_FPS_BUTTON: VDL_RSC_BUTTON_BASE
		{
			idc = VDL_SET_FPS_BUTTON_IDC;

			text = "Set FPS Target"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.3125 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
		class VDL_FPS_TEXT_EDIT: VDL_RSC_EDIT_BASE
		{
			idc = VDL_FPS_TEXT_EDIT_IDC;

			text = "12345"; //--- ToDo: Localize;
			x = 0.804687 * safezoneW + safezoneX;
			y = 0.34375 * safezoneH + safezoneY;
			w = 0.0351563 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
		class VDL_FPS_SLIDER: VDL_RSC_SLIDER_BASE
		{
			idc = VDL_FPS_SLIDER_IDC;

			x = 0.705078 * safezoneW + safezoneX;
			y = 0.34375 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
			sliderPosition = 60;
            sliderRange[] = {15,120};
            sliderStep = 1;
			lineSize = 1;
			tooltip = "Your target FPS that you want to achieve"; //--- ToDo: Localize;
		};
		/* -------------------------------------------------------------------------
			Check Frequency
		------------------------------------------------------------------------- */
		class VDL_SET_FREQ_BUTTON: VDL_RSC_BUTTON_BASE
		{
			idc = VDL_SET_FREQ_BUTTON_IDC;

			text = "Set Check Frequency"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.375 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
		class VDL_FREQ_SLIDER: VDL_RSC_SLIDER_BASE
		{
			idc = VDL_FREQ_SLIDER_IDC;

			x = 0.705078 * safezoneW + safezoneX;
			y = 0.40625 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
			sliderPosition = 3;
            sliderRange[] = {1,10};
            sliderStep = 1;
			lineSize = 1;
			tooltip = "This is how often the view distance will be adjusted in seconds"; //--- ToDo: Localize;
		};
		class VDL_FREQ_TEXT_EDIT: VDL_RSC_EDIT_BASE
		{
			idc = VDL_FREQ_TEXT_EDIT_IDC;

			text = "12345"; //--- ToDo: Localize;
			x = 0.804688 * safezoneW + safezoneX;
			y = 0.40625 * safezoneH + safezoneY;
			w = 0.0351563 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
		/* -------------------------------------------------------------------------
			Min Obj View Distance
		------------------------------------------------------------------------- */
		class VDL_MIN_OBJ_DIST_BUTTON: VDL_RSC_BUTTON_BASE
		{
			idc = VDL_MIN_OBJ_DIST_BUTTON_IDC;

			text = "Set Min Object Distance"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.4375 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
		class VDL_MIN_OBJ_DIST_SLIDER: VDL_RSC_SLIDER_BASE
		{
			idc = VDL_MIN_OBJ_DIST_SLIDER_IDC;

			x = 0.705078 * safezoneW + safezoneX;
			y = 0.46875 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
			sliderPosition = 500;
            sliderRange[] = {100,3000};
            sliderStep = 5;
			lineSize = 10;
		};
		class VDL_MIN_OBJ_DIST_TEXT_EDIT: VDL_RSC_EDIT_BASE
		{
			idc = VDL_MIN_OBJ_DIST_TEXT_EDIT_IDC;

			text = "12345"; //--- ToDo: Localize;
			x = 0.804687 * safezoneW + safezoneX;
			y = 0.46875 * safezoneH + safezoneY;
			w = 0.0351563 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
		/* -------------------------------------------------------------------------
			Max Obj View Distance
		------------------------------------------------------------------------- */
		class VDL_MAX_OBJ_DIST_BUTTON: VDL_RSC_BUTTON_BASE
		{
			idc = VDL_MAX_OBJ_DIST_BUTTON_IDC;

			text = "Set Max Object Distance"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
		class VDL_MAX_OBJ_DIST_SLIDER: VDL_RSC_SLIDER_BASE
		{
			idc = VDL_MAX_OBJ_DIST_SLIDER_IDC;

			x = 0.705078 * safezoneW + safezoneX;
			y = 0.53125 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
			sliderPosition = 1000;
            sliderRange[] = {200,5000};
            sliderStep = 5;
			lineSize = 10;
		};
		class VDL_MAX_OBJ_DIST_TEXT_EDIT: VDL_RSC_EDIT_BASE
		{
			idc = VDL_MAX_OBJ_DIST_TEXT_EDIT_IDC;

			text = "12345"; //--- ToDo: Localize;
			x = 0.804687 * safezoneW + safezoneX;
			y = 0.53125 * safezoneH + safezoneY;
			w = 0.0351563 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
		/* -------------------------------------------------------------------------
			Increment Size
		------------------------------------------------------------------------- */
		class VDL_INCREMENT_BUTTON: VDL_RSC_BUTTON_BASE
		{
			idc = VDL_INCREMENT_BUTTON_IDC;

			text = "Set Increment Size"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.5625 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
		class VDL_INCREMENT_SLIDER: VDL_RSC_SLIDER_BASE
		{
			idc = VDL_INCREMENT_SLIDER_IDC;

			x = 0.705078 * safezoneW + safezoneX;
			y = 0.59375 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
			sliderPosition = 25;
            sliderRange[] = {1,100};
            sliderStep = 1;
			lineSize = 1;
			tooltip = "By how much will the view distance be adjusted in meters to achieve FPS?"; //--- ToDo: Localize;
		};
		class VDL_INCREMENT_TEXT_EDIT: VDL_RSC_EDIT_BASE
		{
			idc = VDL_INCREMENT_TEXT_EDIT_IDC;

			text = "12345"; //--- ToDo: Localize;
			x = 0.804687 * safezoneW + safezoneX;
			y = 0.59375 * safezoneH + safezoneY;
			w = 0.0351563 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
		/* -------------------------------------------------------------------------
			Terrain View Distance
		------------------------------------------------------------------------- */
		class VDL_TERRAIN_BUTTON: VDL_RSC_BUTTON_BASE
		{
			idc = VDL_TERRAIN_BUTTON_IDC;

			text = "Set Terrain View Distance"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.625 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
		class VDL_TERRAIN_SLIDER: VDL_RSC_SLIDER_BASE
		{
			idc = VDL_TERRAIN_SLIDER_IDC;

			x = 0.705078 * safezoneW + safezoneX;
			y = 0.65625 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
			sliderPosition = 200;
            sliderRange[] = {100,6000};
            sliderStep = 5;
			lineSize = 10;
			tooltip = "The overall (static) view distance; this can be rather high without an issue."; //--- ToDo: Localize;
		};
		class VDL_TERRAIN_TEXT_EDIT: VDL_RSC_EDIT_BASE
		{
			idc = VDL_TERRAIN_TEXT_EDIT_IDC;

			text = "12345"; //--- ToDo: Localize;
			x = 0.804687 * safezoneW + safezoneX;
			y = 0.65625 * safezoneH + safezoneY;
			w = 0.0351563 * safezoneW;
			h = 0.0208333 * safezoneH;
			sizeEx = 0.0208333 * safezoneH;
		};
	};
};
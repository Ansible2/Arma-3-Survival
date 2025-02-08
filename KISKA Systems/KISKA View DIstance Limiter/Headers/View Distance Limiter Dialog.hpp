#include "View Distance Limiter Common Defines.hpp"
#include "..\..\KISKA Headers\GUI\KISKA GUI Classes.hpp"
#include "..\..\KISKA Headers\GUI\KISKA GUI Grid.hpp"
#include "..\..\KISKA Headers\GUI\KISKA GUI Colors.hpp"
#include "..\..\KISKA Headers\GUI\KISKA GUI Styles.hpp"

class KISKA_VDL_setting_ctrlGrp: RscControlsGroupNoScrollbars
{
	idc = -1;

	x = KISKA_POS_X(-7.75);
	y = KISKA_POS_Y(1);
	w = KISKA_POS_W(15.5);
	h = KISKA_POS_H(2.5);
	class controls
	{
		class setButton : ctrlButton
		{
			idc = VDL_SET_BUTTON_IDC;
			text = "Button";
			x = KISKA_POS_W(0.75);
			y = KISKA_POS_H(0);
			w = KISKA_POS_W(10.75);
			h = KISKA_POS_H(1);
		};
		class settingEditBox: RscEdit
		{
			idc = VDL_EDIT_BUTTON_IDC;
			text = "123";
			x = KISKA_POS_W(11.5);
			y = KISKA_POS_H(0);
			w = KISKA_POS_W(4);
			h = KISKA_POS_H(1);
		};
		class settingSlider: RscXSliderH
		{
			idc = VDL_SLIDER_IDC;
			x = KISKA_POS_W(0.75);
			y = KISKA_POS_H(1);
			w = KISKA_POS_W(14.75);
			h = KISKA_POS_H(1);
		};

	};
};


class KISKA_viewDistanceLimiter_dialog
{
	idd = VDL_IDD;
	movingEnabled = 1;
	enableSimulation = 1;
	onLoad = "[_this select 0] call KISKA_fnc_VDL_onLoad";

	class controlsBackground
	{
		class KISKA_VDL_mainFrame: Rsctext
		{
			idc = -1;

            x = KISKA_POS_X(-7.5);
        	y = KISKA_POS_Y(-8);
        	w = KISKA_POS_W(16);
        	h = KISKA_POS_H(18.5);
			colorBackground[] = KISKA_GREY_COLOR(0,0.25);
		};
		class KISKA_VDL_mainHeaderText: Rsctext
		{
			idc = -1;

			moving = 1;
			text = "View Distance Limiter";
            x = KISKA_POS_X(-7.5);
        	y = KISKA_POS_Y(-10);
        	w = KISKA_POS_W(15);
        	h = KISKA_POS_H(1);
			colorBackground[] = KISKA_PROFILE_BACKGROUND_COLOR(0.65);
			style = KISKA_ST_CENTER;
		};
		class KISKA_VDL_systemOn_headerText: RscText
		{
			idc = -1;

			text = "System On:";
            x = KISKA_POS_X(-7.5);
        	y = KISKA_POS_Y(-9);
        	w = KISKA_POS_W(3);
        	h = KISKA_POS_H(1);
			colorBackground[] = KISKA_GREY_COLOR(0,1);
			sizeEx = KISKA_GUI_TEXT_SIZE(2);
		};
		class KISKA_VDL_tiedViewDistance_headerText: RscText
		{
			idc = -1;

			text = "Tied View Distance:";
            x = KISKA_POS_X(2.5);
        	y = KISKA_POS_Y(-9);
        	w = KISKA_POS_W(5);
        	h = KISKA_POS_H(1);
			colorBackground[] = KISKA_GREY_COLOR(0,1);
			sizeEx = KISKA_GUI_TEXT_SIZE(2);
		};
	};

	class controls
	{
		/* -------------------------------------------------------------------------
			General Controls
		------------------------------------------------------------------------- */
		class KISKA_VDL_close_button: KISKA_RscCloseButton
		{
			idc = VDL_CLOSE_BUTTON_IDC;
            x = KISKA_POS_X(7.5);
        	y = KISKA_POS_Y(-10);
        	w = KISKA_POS_W(1);
        	h = KISKA_POS_H(1);
		};
		class KISKA_VDL_setAll_button: ctrlButton
		{
			idc = VDL_SET_ALL_BUTTON_IDC;

			text = "Set All Changes";
            x = KISKA_POS_X(-3.5);
        	y = KISKA_POS_Y(-9);
        	w = KISKA_POS_W(6);
        	h = KISKA_POS_H(1);
			sizeEx = KISKA_GUI_TEXT_SIZE(2);
		};
		class KISKA_VDL_systemOn_checkBox: RscCheckBox
		{
			idc = VDL_SYSTEM_ON_CHECKBOX_IDC;

            x = KISKA_POS_X(-4.5);
        	y = KISKA_POS_Y(-9);
        	w = KISKA_POS_W(1);
        	h = KISKA_POS_H(1);
			colorText[] = KISKA_GREY_COLOR(0,1);
			colorActive[] = KISKA_GREY_COLOR(0,1);
		};
		class KISKA_VDL_tiedViewDistance_checkBox: RscCheckBox
		{
			idc = VDL_TIED_DISTANCE_CHECKBOX_IDC;

            x = KISKA_POS_X(7.5);
        	y = KISKA_POS_Y(-9);
        	w = KISKA_POS_W(1);
        	h = KISKA_POS_H(1);
			colorText[] = KISKA_GREY_COLOR(0,1);
			colorActive[] = KISKA_GREY_COLOR(0,1);

			tooltip = "A tied view distance will make the terrain view distance be the same as and follow the dynamic adjustments of the object view distance";
		};

		/* -------------------------------------------------------------------------
			Target FPS
		------------------------------------------------------------------------- */
		class KISKA_VDL_targetFPS_ctrlGrp: KISKA_VDL_setting_ctrlGrp
		{
			idc = VDL_TARGET_FPS_CTRL_GRP_IDC;
			y = KISKA_POS_Y(-7.5);

			class controls : controls
			{
				class setButton: setButton
				{
					text = "Set Target FPS";
					tooltip = "The FPS that you want to achieve to have while the system is running";
				};
				class settingSlider: settingSlider
				{
					sliderPosition = 60;
		            sliderRange[] = {15,300};
		            sliderStep = 1;
					lineSize = 1;
				};
				class settingEditBox: settingEditBox
				{
				};
			};
		};

		/* -------------------------------------------------------------------------
			Min Obj View Distance
		------------------------------------------------------------------------- */
		class KISKA_VDL_minObjectDist_ctrlGrp: KISKA_VDL_setting_ctrlGrp
		{
			idc = VDL_MIN_OBJECT_DIST_CTRL_GRP_IDC;

			y = KISKA_POS_Y(-4.5);

			class controls : controls
			{
				class setButton: setButton
				{
					text = "Set Min Object Distance";
					tooltip = "The minimum distance your Object View Distance can be set to";
				};
				class settingSlider: settingSlider
				{
					sliderPosition = 500;
					sliderRange[] = {100,3000};
					sliderStep = 1;
					lineSize = 10;
				};
				class settingEditBox: settingEditBox
				{
				};
			};
		};

		/* -------------------------------------------------------------------------
			Max Obj View Distance
		------------------------------------------------------------------------- */
		class KISKA_VDL_maxObjectDist_ctrlGrp: KISKA_VDL_minObjectDist_ctrlGrp
		{
			idc = VDL_MAX_OBJECT_DIST_CTRL_GRP_IDC;
			y = KISKA_POS_Y(-1.5);

			class controls : controls
			{
				class setButton: setButton
				{
					text = "Set Max Object Distance";
					tooltip = "The maximum distance your Object View Distance can be set to";
				};
				class settingSlider: settingSlider
				{
				};
				class settingEditBox: settingEditBox
				{
				};
			};
		};

		/* -------------------------------------------------------------------------
			Terrain View Distance
		------------------------------------------------------------------------- */
		class KISKA_VDL_terrainDist_ctrlGrp: KISKA_VDL_minObjectDist_ctrlGrp
		{
			idc = VDL_TERRAIN_DIST_CTRL_GRP_IDC;

			y = KISKA_POS_Y(1.5);
			class controls : controls
			{
				class setButton: setButton
				{
					text = "Set Terrain View Distance";
					tooltip = "The overall (static) view distance; this can be rather high without an issue.";
				};
				class settingSlider: settingSlider
				{
				};
				class settingEditBox: settingEditBox
				{
				};
			};
		};

		/* -------------------------------------------------------------------------
			Check Frequency
		------------------------------------------------------------------------- */
		class KISKA_VDL_checkFreq_ctrlGrp: KISKA_VDL_setting_ctrlGrp
		{
			idc = VDL_CHECK_FREQ_CTRL_GRP_IDC;
			y = KISKA_POS_Y(4.5);
			class controls : controls
			{
				class setButton: setButton
				{
					text = "Set Check Frequency";
					tooltip = "This is how often the view distance will be adjusted in seconds";
				};
				class settingSlider: settingSlider
				{
					sliderPosition = 1;
		            sliderRange[] = {0.01,10};
		            sliderStep = 0.01;
					lineSize = 0.05;
				};
				class settingEditBox: settingEditBox
				{
				};
			};
		};

		/* -------------------------------------------------------------------------
			Increment Size
		------------------------------------------------------------------------- */
		class KISKA_VDL_incriment_ctrlGrp: KISKA_VDL_setting_ctrlGrp
		{
			idc = VDL_INCRIMENT_CTRL_GRP_IDC;
			y = KISKA_POS_Y(7.5);

			class controls : controls
			{
				class setButton: setButton
				{
					text = "Set Increment Size";
					tooltip = "By how much will the view distance be adjusted in meters to achieve the target FPS each check frequency?";
				};
				class settingSlider: settingSlider
				{
					sliderPosition = 25;
		            sliderRange[] = {1,500};
		            sliderStep = 5;
					lineSize = 10;
				};
				class settingEditBox: settingEditBox
				{
				};
			};
		};

	};
};

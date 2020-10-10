/*
#define INFO_PANEL_IDC 99999

class BLWK_infoPanel {
	idd = -1;
    fadeout = 0;
    fadein = 0;
	duration = 1e+011; // we want this to be up for as long as the mission is
	name= "BLWK_infoPanel";
	// _this select 0 is the display or control assigned
	// basically giving it a variable to reference in the uiNamespace so we can make changes
	onLoad = "uiNamespace setVariable ['BLWK_infoPanel', _this select 0]";

	class controlsBackground {
		class KillPointsHud_1:RscStructuredText
		{
			idc = INFO_PANEL_IDC;
			type = CT_STRUCTURED_TEXT;
			size = 0.040;
			x = (SafeZoneX + 0);
			y = (SafeZoneY + 0.015);
			w = 0.2; h = 0.20;
			colorText[] = {1,1,1,1};
			lineSpacing = 3;
			colorBackground[] = {0,0,0,0.3};
			text = "Text";
			font = "PuristaLight";
			shadow = 2;
			class Attributes {
				align = "left";
			};
		};
	};
};
*/

#include "infoPanelCommonDefines.hpp"
class BLWK_infoPanel {
	idd = INFO_PANEL_IDD;
	fadeout = 0;
    fadein = 0;
	duration = 1e+011; // we want this to be up for as long as the mission is
	name= "BLWK_infoPanel";

	class controlsBackground {
		class BLWK_infoPanel_frame_static: RscFrame
		{
			idc = -1;
			x = 0.00781247 * safezoneW + safezoneX;
			y = 0.0104166 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.145833 * safezoneH;
			colorBackground[] = {0,0,0,0.3};
			shadow = 2;
		};
		class BLWK_infoPanel_playerName_static: RscText
		{
			idc = -1;
			text = ""; //--- ToDo: Localize;
			x = 0.0136719 * safezoneW + safezoneX;
			y = 0.0208333 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.03125 * safezoneH;
			onLoad = "(_this select 0) ctrlSetText (name player)"
			colorBackground[] = {-1,-1,-1,-1};
		};
		class BLWK_infoPanel_playerPoints_shower: RscText
		{
			idc = INFO_PANEL_PLAYER_POINTS_IDC;
			text = ""; //--- ToDo: Localize;
			x = 0.0136718 * safezoneW + safezoneX;
			y = 0.0520833 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.03125 * safezoneH;
			colorBackground[] = {-1,-1,-1,-1};
		};
		class BLWK_infoPanel_wave_static: RscText
		{
			idc = -1;
			text = "Wave:"; //--- ToDo: Localize;
			x = 0.0136718 * safezoneW + safezoneX;
			y = 0.104167 * safezoneH + safezoneY;
			w = 0.0644531 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,-1};
			sizeEx = 0.75 * UI_GRID_H;
		};
		class BLWK_infoPanel_wave_number: RscText
		{
			idc = INFO_PANEL_WAVE_NUM_IDC;
			text = ""; //--- ToDo: Localize;
			x = 0.078125 * safezoneW + safezoneX;
			y = 0.104167 * safezoneH + safezoneY;
			w = 0.0234375 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,-1};
		};
		class BLWK_infoPanel_respawnsLeft_number: RscText
		{
			idc = INFO_PANEL_RESPAWNS_NUM_IDC;
			text = ""; //--- ToDo: Localize;
			x = 0.078125 * safezoneW + safezoneX;
			y = 0.125 * safezoneH + safezoneY;
			w = 0.0234375 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,-1};
		};
		class BLWK_infoPanel_respawnsLeft_static: RscText
		{
			idc = -1;
			text = "Respawns Left:"; //--- ToDo: Localize;
			x = 0.0136718 * safezoneW + safezoneX;
			y = 0.125 * safezoneH + safezoneY;
			w = 0.0644531 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,-1};
			sizeEx = 0.75 * UI_GRID_H;
		};
		class BLWK_infoPanel_waveStatus_static: RscText
		{
			idc = -1;
			text = "Wave Status:"; //--- ToDo: Localize;
			x = 0.0136718 * safezoneW + safezoneX;
			y = 0.0833333 * safezoneH + safezoneY;
			w = 0.0410156 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,-1};
			sizeEx = 0.75 * UI_GRID_H;
		};
		class BLWK_infoPanel_waveStatus_shower: RscText
		{
			idc = INFO_PANEL_WAVE_STATUS_IDC;
			text = ""; //--- ToDo: Localize;
			x = 0.0546875 * safezoneW + safezoneX;
			y = 0.0833333 * safezoneH + safezoneY;
			w = 0.046875 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,-1};
			sizeEx = 0.75 * UI_GRID_H;
		};
	};
};
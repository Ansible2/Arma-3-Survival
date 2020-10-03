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

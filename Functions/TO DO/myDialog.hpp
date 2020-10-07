#define BUTTON_COLOR_BACKGROUND {}
#define SLIDER_cOLOR {}
#define TEXT_BOX_COLOR {}

class myDialog 
{
	idd = 1234
	movingEnabled = true;
	enableSimulation = true;
	class controls
	{
		class RscFrame_1800: RscFrame
		{
			idc = 1800;

			x = 0.699219 * safezoneW + safezoneX;
			y = 0.260416 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.458333 * safezoneH;
			colorText[] = {-1,-1,-1,1};
			colorBackground[] = {1,1,1,1};
			colorActive[] = {-1,-1,-1,1};
		};
		class headerText: RscText
		{
			idc = 1000;

			text = "View Distance Limiter"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class setFPSButton: RscButton
		{
			idc = 1604;

			text = "Set FPS Target"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.3125 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class closeDiagButton: RscButton
		{
			idc = 1606;

			text = "Close GUI"; //--- ToDo: Localize;
			x = 0.757813 * safezoneW + safezoneX;
			y = 0.28125 * safezoneH + safezoneY;
			w = 0.0820313 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class setAllChangesButton: RscButton
		{
			idc = 1607;

			text = "Set All Changes"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.6875 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.03125 * safezoneH;
		};
		class systemOnCheckBox: RscCheckbox
		{
			idc = 2800;
			x = 0.746094 * safezoneW + safezoneX;
			y = 0.28125 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorText[] = {-1,-1,-1,1};
			colorBackground[] = {-1,-1,-1,-1};
			colorActive[] = {-1,-1,-1,1};
		};
		class systemOnText: RscText
		{
			idc = 1001;
			text = "System On:"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.28125 * safezoneH + safezoneY;
			w = 0.046875 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class FPSText: RscText
		{
			idc = 1002;
			text = "12345"; //--- ToDo: Localize;
			x = 0.810546 * safezoneW + safezoneX;
			y = 0.34375 * safezoneH + safezoneY;
			w = 0.0292969 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
			tooltip = "FPS Target"; //--- ToDo: Localize;
		};
		class setFrequencyButton: RscButton
		{
			idc = 1604;

			text = "Set Check Frequency"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.375 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
			tooltip = "How often to check/make view distance changes"; //--- ToDo: Localize;
		};
		class FPSSlider: RscXSliderH
		{
			idc = 1900;
			x = 0.705078 * safezoneW + safezoneX;
			y = 0.34375 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class frequencySlider: RscXSliderH
		{
			idc = 1901;
			x = 0.705078 * safezoneW + safezoneX;
			y = 0.40625 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
			sliderPosition = 5;
            sliderRange[] = {1,10};
            sliderStep = 1;
            lineSize = 1;
			onSliderPosChanged = "hint str (_this select 1)";
		};
		class frequencyText: RscText
		{
			idc = 1003;
			text = "12345"; //--- ToDo: Localize;
			x = 0.810546 * safezoneW + safezoneX;
			y = 0.40625 * safezoneH + safezoneY;
			w = 0.0292969 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class setMinObjViewButton: RscButton
		{
			idc = 1604;

			text = "Set Min Object Distance"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.4375 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class minObjViewSlider: RscXSliderH
		{
			idc = 1902;
			x = 0.705078 * safezoneW + safezoneX;
			y = 0.46875 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class minObjViewText: RscText
		{
			idc = 1004;
			text = "12345"; //--- ToDo: Localize;
			x = 0.810546 * safezoneW + safezoneX;
			y = 0.46875 * safezoneH + safezoneY;
			w = 0.0292969 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class setMaxObjViewButton: RscButton
		{
			idc = 1604;

			text = "Set Max Object Distance"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class maxObjViewSlider: RscXSliderH
		{
			idc = 1903;
			x = 0.705078 * safezoneW + safezoneX;
			y = 0.53125 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class maxObjViewText: RscText
		{
			idc = 1005;
			text = "12345"; //--- ToDo: Localize;
			x = 0.810546 * safezoneW + safezoneX;
			y = 0.53125 * safezoneH + safezoneY;
			w = 0.0292969 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class setIncrementButton: RscButton
		{
			idc = 1604;

			text = "Set Increment Size"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.5625 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
			tooltip = "This is how much each check frequency drops/increases the view distance until the FPS target is met"; //--- ToDo: Localize;
		};
		class incrementSlider: RscXSliderH
		{
			idc = 1904;
			x = 0.705078 * safezoneW + safezoneX;
			y = 0.59375 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class incrementText: RscText
		{
			idc = 1006;
			text = "12345"; //--- ToDo: Localize;
			x = 0.810547 * safezoneW + safezoneX;
			y = 0.59375 * safezoneH + safezoneY;
			w = 0.0292969 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class setTerrainViewButton: RscButton
		{
			idc = 1604;

			text = "Set Terrain View Distance"; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.625 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.0208333 * safezoneH;
			tooltip = "This is terrain view distance (how far the wall of fog is). In general, this can be rather large without an issue."; //--- ToDo: Localize;
		};
		class terrainViewSlider: RscXSliderH
		{
			idc = 1905;
			x = 0.705078 * safezoneW + safezoneX;
			y = 0.65625 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class terrainViewText: RscText
		{
			idc = 1007;
			text = "12345"; //--- ToDo: Localize;
			x = 0.810546 * safezoneW + safezoneX;
			y = 0.65625 * safezoneH + safezoneY;
			w = 0.0292969 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
	};
};




/*
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Gill, v1.063, #Nufele)
////////////////////////////////////////////////////////

class RscFrame_1800: RscFrame
{
	idc = 1800;

	x = 0.699219 * safezoneW + safezoneX;
	y = 0.260416 * safezoneH + safezoneY;
	w = 0.140625 * safezoneW;
	h = 0.458333 * safezoneH;
	colorText[] = {-1,-1,-1,1};
	colorBackground[] = {1,1,1,1};
	colorActive[] = {-1,-1,-1,1};
};
class headerText: RscText
{
	idc = 1000;

	text = "View Distance Limiter"; //--- ToDo: Localize;
	x = 0.699219 * safezoneW + safezoneX;
	y = 0.260417 * safezoneH + safezoneY;
	w = 0.140625 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class setFPSButton: RscButton
{
	idc = 1604;

	text = "Set FPS Target"; //--- ToDo: Localize;
	x = 0.699219 * safezoneW + safezoneX;
	y = 0.3125 * safezoneH + safezoneY;
	w = 0.140625 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class closeDiagButton: RscButton
{
	idc = 1606;

	text = "Close GUI"; //--- ToDo: Localize;
	x = 0.757813 * safezoneW + safezoneX;
	y = 0.28125 * safezoneH + safezoneY;
	w = 0.0820313 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class setAllChangesButton: RscButton
{
	idc = 1607;

	text = "Set All Changes"; //--- ToDo: Localize;
	x = 0.699219 * safezoneW + safezoneX;
	y = 0.6875 * safezoneH + safezoneY;
	w = 0.140625 * safezoneW;
	h = 0.03125 * safezoneH;
};
class systemOnCheckBox: RscCheckbox
{
	idc = 2800;
	x = 0.746094 * safezoneW + safezoneX;
	y = 0.28125 * safezoneH + safezoneY;
	w = 0.0117188 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorText[] = {-1,-1,-1,1};
	colorBackground[] = {-1,-1,1,1};
	colorActive[] = {-1,-1,-1,1};
};
class systemOnText: RscText
{
	idc = 1001;
	text = "System On:"; //--- ToDo: Localize;
	x = 0.699219 * safezoneW + safezoneX;
	y = 0.28125 * safezoneH + safezoneY;
	w = 0.046875 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class FPSText: RscText
{
	idc = 1002;
	text = "12345"; //--- ToDo: Localize;
	x = 0.810546 * safezoneW + safezoneX;
	y = 0.34375 * safezoneH + safezoneY;
	w = 0.0292969 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
	tooltip = "FPS Target"; //--- ToDo: Localize;
};
class setFrequencyButton: RscButton
{
	idc = 1604;

	text = "Set Check Frequency"; //--- ToDo: Localize;
	x = 0.699219 * safezoneW + safezoneX;
	y = 0.375 * safezoneH + safezoneY;
	w = 0.140625 * safezoneW;
	h = 0.0208333 * safezoneH;
	tooltip = "How often to check/make view distance changes"; //--- ToDo: Localize;
};
class FPSSlider: RscSlider
{
	idc = 1900;
	x = 0.705078 * safezoneW + safezoneX;
	y = 0.34375 * safezoneH + safezoneY;
	w = 0.0996094 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class frequencySlider: RscSlider
{
	idc = 1901;
	x = 0.705078 * safezoneW + safezoneX;
	y = 0.40625 * safezoneH + safezoneY;
	w = 0.0996094 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class frequencyText: RscText
{
	idc = 1003;
	text = "12345"; //--- ToDo: Localize;
	x = 0.810546 * safezoneW + safezoneX;
	y = 0.40625 * safezoneH + safezoneY;
	w = 0.0292969 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class setMinObjViewButton: RscButton
{
	idc = 1604;

	text = "Set Min Object Distance"; //--- ToDo: Localize;
	x = 0.699219 * safezoneW + safezoneX;
	y = 0.4375 * safezoneH + safezoneY;
	w = 0.140625 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class minObjViewSlider: RscSlider
{
	idc = 1902;
	x = 0.705078 * safezoneW + safezoneX;
	y = 0.46875 * safezoneH + safezoneY;
	w = 0.0996094 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class minObjViewText: RscText
{
	idc = 1004;
	text = "12345"; //--- ToDo: Localize;
	x = 0.810546 * safezoneW + safezoneX;
	y = 0.46875 * safezoneH + safezoneY;
	w = 0.0292969 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class setMaxObjViewButton: RscButton
{
	idc = 1604;

	text = "Set Max Object Distance"; //--- ToDo: Localize;
	x = 0.699219 * safezoneW + safezoneX;
	y = 0.5 * safezoneH + safezoneY;
	w = 0.140625 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class maxObjViewSlider: RscSlider
{
	idc = 1903;
	x = 0.705078 * safezoneW + safezoneX;
	y = 0.53125 * safezoneH + safezoneY;
	w = 0.0996094 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class maxObjViewText: RscText
{
	idc = 1005;
	text = "12345"; //--- ToDo: Localize;
	x = 0.810546 * safezoneW + safezoneX;
	y = 0.53125 * safezoneH + safezoneY;
	w = 0.0292969 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class setIncrementButton: RscButton
{
	idc = 1604;

	text = "Set Increment Size"; //--- ToDo: Localize;
	x = 0.699219 * safezoneW + safezoneX;
	y = 0.5625 * safezoneH + safezoneY;
	w = 0.140625 * safezoneW;
	h = 0.0208333 * safezoneH;
	tooltip = "This is how much each check frequency drops/increases the view distance until the FPS target is met"; //--- ToDo: Localize;
};
class incrementSlider: RscSlider
{
	idc = 1904;
	x = 0.705078 * safezoneW + safezoneX;
	y = 0.59375 * safezoneH + safezoneY;
	w = 0.0996094 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class incrementText: RscText
{
	idc = 1006;
	text = "12345"; //--- ToDo: Localize;
	x = 0.810547 * safezoneW + safezoneX;
	y = 0.59375 * safezoneH + safezoneY;
	w = 0.0292969 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class setTerrainViewButton: RscButton
{
	idc = 1604;

	text = "Set Terrain View Distance"; //--- ToDo: Localize;
	x = 0.699219 * safezoneW + safezoneX;
	y = 0.625 * safezoneH + safezoneY;
	w = 0.140625 * safezoneW;
	h = 0.0208333 * safezoneH;
	tooltip = "This is terrain view distance (how far the wall of fog is). In general, this can be rather large without an issue."; //--- ToDo: Localize;
};
class terrainViewSlider: RscSlider
{
	idc = 1905;
	x = 0.705078 * safezoneW + safezoneX;
	y = 0.65625 * safezoneH + safezoneY;
	w = 0.0996094 * safezoneW;
	h = 0.0208333 * safezoneH;
};
class terrainViewText: RscText
{
	idc = 1007;
	text = "12345"; //--- ToDo: Localize;
	x = 0.810546 * safezoneW + safezoneX;
	y = 0.65625 * safezoneH + safezoneY;
	w = 0.0292969 * safezoneW;
	h = 0.0208333 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

*/
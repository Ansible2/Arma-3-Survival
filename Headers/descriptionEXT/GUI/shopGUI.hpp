#define PROFILE_BACKGROUND_COLOR(ALPHA)\
{\
	"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",\
	ALPHA\
}
#define BORDER_COLOR(ALPHA) {0,0,0,ALPHA}
#define BACKGROUND_FRAME_COLOR(ALPHA) {0,0,0,ALPHA}

#define TEXT_SIZE_SMALL(H_VAR,DIV) (H_VAR * safezoneH) / DIV

#include "shopGUICommonDefines.hpp"

/* -------------------------------------------------------------------------
	Base Classes
------------------------------------------------------------------------- */
class theCrateShopDialogbaseClass_button
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_BUTTON;
	text = "";
	colorText[] = {1,1,1,1};
	colorBackground[] = PROFILE_BACKGROUND_COLOR(0.65);
	colorBackgroundActive[] = PROFILE_BACKGROUND_COLOR(1);
	colorFocused[] = PROFILE_BACKGROUND_COLOR(0.65);
	colorDisabled[] = {1,1,1,0.25};
	colorBackgroundDisabled[] = {0,0,0,0.5};
	colorShadow[] = {0,0,0,1};
	colorBorder[] = {0,0,0,1};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEscape",
		0.09,
		1
	};
	idc = -1;
	style = ST_CENTER;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "RobotoCondensed";
	sizeEx = TEXT_SIZE_SMALL(0.0208333,1.1);
	url = "";
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	borderSize = 0;
};

class theCrateShopDialogbaseClass_treeView
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_TREE;
	colorBackground[] = {0,0,0,0};
	colorSelect[] = {1,1,1,0.7};
	colorDisabled[] = {1,1,1,0.25};
	colorText[] = {1,1,1,1};
	colorSelectText[] = {0,0,0,1};
	colorBorder[] = {0,0,0,0};
	colorSearch[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
	};
	colorMarked[] = {0.2,0.3,0.7,1};
	colorMarkedText[] = {0,0,0,1};
	colorMarkedSelected[] = {0,0.5,0.5,1};
	multiselectEnabled = 0;
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {0,0,0,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {0,0,0,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorArrow[] = {1,1,1,1};
	maxHistoryDelay = 1;
	shadow = 0;
	style = ST_LEFT;
	font = "RobotoCondensed";
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa";
	hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.2;
	rowHeight = 0.0439091;
	colorSelectBackground[] = {0,0,0,0.5};
	colorLines[] = {0,0,0,0};
	borderSize = 0;
	expandOnDoubleclick = 1;
	class ScrollBar: ScrollBar
	{
	};
};

class theCrateShopDialogbaseClass_text
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_STATIC;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = ST_LEFT;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "RobotoCondensed";
	SizeEx = GUI_TEXT_SIZE_MEDIUM;
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class theCrateShopDialogbaseClass_picture
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_STATIC;
	idc = -1;
	style = ST_PICTURE;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class theCrateShopDialogbaseClass_shortcutButton
{
	deletable = 0;
	fade = 0;
	type = CT_SHORTCUTBUTTON;
	x = 0.1;
	y = 0.1;
	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0;
		top = ((GUI_GRID_HAbs / 20) - GUI_TEXT_SIZE_MEDIUM) / 2;
		w = GUI_TEXT_SIZE_MEDIUM * (3/4);
		h = GUI_TEXT_SIZE_MEDIUM;
	};
	class TextPos
	{
		left = GUI_TEXT_SIZE_MEDIUM * (3/4);
		top = ((GUI_GRID_HAbs / 20) - GUI_TEXT_SIZE_MEDIUM) / 2;
		right = 0.005;
		bottom = 0;
	};
	shortcuts[] = {};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] = {1,1,1,1};
	colorFocused[] = {1,1,1,1};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		1
	};
	colorBackgroundFocused[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		1
	};
	colorBackground2[] = {1,1,1,1};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEscape",
		0.09,
		1
	};
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	idc = -1;
	style = ST_CENTER;
	default = 0;
	shadow = 0;
	w = 0.183825;
	h = (GUI_GRID_HAbs / 20);
	textSecondary = "";
	colorSecondary[] = {1,1,1,1};
	colorFocusedSecondary[] = {1,1,1,1};
	color2Secondary[] = {0.95,0.95,0.95,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = GUI_TEXT_SIZE_MEDIUM;
	fontSecondary = "RobotoCondensed";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	periodFocus = 1.2;
	periodOver = 0.8;
	period = 0.4;
	font = "RobotoCondensed";
	size = GUI_TEXT_SIZE_MEDIUM;
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	text = "";
	url = "";
	action = "";
	class AttributesImage
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "left";
	};
};

class theCrateShopDialogbaseClass_menuButton: theCrateShopDialogbaseClass_shortcutButton
{
	idc = -1;
	type = CT_SHORTCUTBUTTON;
	style = ST_CENTER + ST_FRAME + ST_HUD_BACKGROUND;
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0,0,0,0.8};
	colorBackgroundFocused[] = {1,1,1,1};
	colorBackground2[] = {0.75,0.75,0.75,1};
	color[] = {1,1,1,1};
	colorFocused[] = {0,0,0,1};
	color2[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	textSecondary = "";
	colorSecondary[] = {1,1,1,1};
	colorFocusedSecondary[] = {0,0,0,1};
	color2Secondary[] = {0,0,0,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = GUI_TEXT_SIZE_MEDIUM;
	fontSecondary = "PuristaLight";
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = GUI_TEXT_SIZE_MEDIUM;
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class TextPos
	{
		left = 0.25 * GUI_GRID_W;
		top = (GUI_GRID_H - GUI_TEXT_SIZE_MEDIUM) / 2;
		right = 0.005;
		bottom = 0;
	};
	class Attributes
	{
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class ShortcutPos
	{
		left = 5.25 * GUI_GRID_W;
		top = 0;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",
		0.09,
		1
	};
};

class theCrateShopDialogbaseClass_editBox
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_EDIT;
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	colorBackground[] = {0,0,0,0};
	colorText[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorSelection[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		1
	};
	autocomplete = "";
	text = "";
	size = 0.2;
	style = ST_FRAME;
	font = "RobotoCondensed";
	shadow = 2;
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	canModify = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class theCrateShopDialogbaseClass_xSliderH
{
	deletable = 0;
	fade = 0;
	type = CT_XSLIDER;
	color[] = {1,1,1,0.6};
	colorActive[] = {1,1,1,1};
	colorDisable[] = {1,1,1,0.4};
	style = SL_TEXTURES + SL_HORZ;
	shadow = 0;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.4;
	colorDisabled[] = {1,1,1,0.2};
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
	lineSize = 10;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	sliderPosition = 5;
	sliderRange[] = {0,10};
	sliderStep = 1;
	onSliderPosChanged = "_this call BLWK_fnc_shop_adjustPartnerControl";
};
/* -------------------------------------------------------------------------
	Additional Base Classes
------------------------------------------------------------------------- */
class theCrateShopDialogbaseClass_headerText: theCrateShopDialogbaseClass_text
{
	font = "RobotoCondensed";
	SizeEx = GUI_TEXT_SIZE_MEDIUM;
	colorBackground[] = BORDER_COLOR(1);
};
class theCrateShopDialogbaseClass_border: theCrateShopDialogbaseClass_text
{
	colorBackground[] = BORDER_COLOR(0.75);
};
class theCrateShopDialogbaseClass_background: theCrateShopDialogbaseClass_text
{
	colorBackground[] = BACKGROUND_FRAME_COLOR(0.60);
};



/* -------------------------------------------------------------------------
	Dialog
------------------------------------------------------------------------- */
class theCrateShopDialog
{
    idd = BLWK_SHOP_IDD;
    movingEnabled = false;
	onLoad = "_this call BLWK_fnc_shop_onLoadEvent";
	
	class controlsBackground
	{	
		/* -------------------------------------------------------------------------
			Backgrounds
		------------------------------------------------------------------------- */
		class theCrateShopDialogbuildableObjects_background: theCrateShopDialogbaseClass_background
		{
			idc = -1;

			x = 0.189453 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.199219 * safezoneW;
			h = 0.510417 * safezoneH;
		};
		class theCrateShopDialogsupports_background: theCrateShopDialogbaseClass_background
		{
			idc = -1;

			x = 0.400391 * safezoneW + safezoneX;
			y = 0.479167 * safezoneH + safezoneY;
			w = 0.199219 * safezoneW;
			h = 0.28125 * safezoneH;
		};
		class theCrateShopDialogpreviewPic_background: theCrateShopDialogbaseClass_background
		{
			idc = -1;

			x = 0.400391 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.199219 * safezoneW;
			h = 0.229167 * safezoneH;
		};
		class theCrateShopDialogcommunityPool_background: theCrateShopDialogbaseClass_background
		{
			idc = -1;

			x = 0.611328 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.199219 * safezoneW;
			h = 0.510417 * safezoneH;
		};


		/* -------------------------------------------------------------------------
			Borders
		------------------------------------------------------------------------- */
		class theCrateShopDialogborder_right: theCrateShopDialogbaseClass_border
		{
			idc = -1;

			x = 0.816406 * safezoneW + safezoneX;
			y = 0.229167 * safezoneH + safezoneY;
			w = 0.00585938 * safezoneW;
			h = 0.541667 * safezoneH;
		};
		class theCrateShopDialogborder_left: theCrateShopDialogbaseClass_border
		{
			idc = -1;

			x = 0.177734 * safezoneW + safezoneX;
			y = 0.229167 * safezoneH + safezoneY;
			w = 0.00585938 * safezoneW;
			h = 0.541667 * safezoneH;
		};
		class theCrateShopDialogborder_bottom: theCrateShopDialogbaseClass_border
		{
			idc = -1;
			
			x = 0.177734 * safezoneW + safezoneX;
			y = 0.770833 * safezoneH + safezoneY;
			w = 0.644531 * safezoneW;
			h = 0.0625 * safezoneH;
		};


		/* -------------------------------------------------------------------------
			Main Background
		------------------------------------------------------------------------- */
		class theCrateShopDialogbackgroundPrimary: theCrateShopDialogbaseClass_text
		{
			idc = -1;
			x = 0.183594 * safezoneW + safezoneX;
			y = 0.229167 * safezoneH + safezoneY;
			w = 0.632813 * safezoneW;
			h = 0.541667 * safezoneH;
			colorBackground[] = BORDER_COLOR(0.35);
		};
	};
	
    class controls
    {
		/* -------------------------------------------------------------------------
			Header Texts
		------------------------------------------------------------------------- */
		class theCrateShopDialogheaderText: theCrateShopDialogbaseClass_headerText
		{
			idc = -1;

			text = "Shop"; //--- ToDo: Localize;
			x = 0.177734 * safezoneW + safezoneX;
			y = 0.208333 * safezoneH + safezoneY;
			w = 0.632813 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class theCrateShopDialogcommunityPool_headerText: theCrateShopDialogbaseClass_headerText
		{
			idc = -1;
			
			text = "Community Pool"; //--- ToDo: Localize;
			x = 0.617188 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogsupports_headerText: theCrateShopDialogbaseClass_headerText
		{
			idc = -1;

			text = "Supports"; //--- ToDo: Localize;
			x = 0.40625 * safezoneW + safezoneX;
			y = 0.479167 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogbuildableObjects_headerText: theCrateShopDialogbaseClass_headerText
		{
			idc = -1;

			text = "Buildable Objects"; //--- ToDo: Localize;
			x = 0.195312 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};

		/* -------------------------------------------------------------------------
			Buttons
		------------------------------------------------------------------------- */
		class theCrateShopDialogbuildableObjects_purchaseForSelfButton: theCrateShopDialogbaseClass_button
		{
			idc = BLWK_SHOP_BUILD_PURCHASE_SELF_BUTT_IDC;
			text = "Purchase (Self)"; //--- ToDo: Localize;

			x = 0.195312 * safezoneW + safezoneX;
			y = 0.729167 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;

			onButtonClick = "_this call BLWK_fnc_shop_purchaseForSelf";
		};
		class theCrateShopDialogbuildableObjects_purchaseForPoolButton: theCrateShopDialogbaseClass_button
		{
			idc = BLWK_SHOP_BUILD_PURCHASE_POOL_BUTT_IDC;
			text = "Purchase (Pool)"; //--- ToDo: Localize;
			x = 0.3125 * safezoneW + safezoneX;
			y = 0.729167 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;

			onButtonClick = "_this call BLWK_fnc_shop_purchaseForPool";
		};
		class theCrateShopDialogcommunityPool_withdrawButton: theCrateShopDialogbaseClass_button
		{
			idc = BLWK_SHOP_POOL_WITHDRAW_BUTT_IDC;
			text = "Withdraw"; //--- ToDo: Localize;
			x = 0.734375 * safezoneW + safezoneX;
			y = 0.729167 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;

			onButtonClick = "_this call BLWK_fnc_shop_withdrawFromPoolButtonEvent";
		};
		class theCrateShopDialogcommunityPool_sellButton: theCrateShopDialogbaseClass_button
		{
			idc = BLWK_SHOP_POOL_SELL_BUTT_IDC;
			text = "Sell Back"; //--- ToDo: Localize;
			x = 0.617188 * safezoneW + safezoneX;
			y = 0.729167 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;

			onButtonClick = "_this call BLWK_fnc_shop_sellFromPoolButtonEvent";
		};
		class theCrateShopDialogpoints_deposit_button: theCrateShopDialogbaseClass_button
		{
			idc = BLWK_SHOP_POINTS_DEPOSIT_BUTT_IDC;
			text = "Deposit Points"; //--- ToDo: Localize;
			x = 0.324219 * safezoneW + safezoneX;
			y = 0.802083 * safezoneH + safezoneY;
			w = 0.169922 * safezoneW;
			h = 0.0208333 * safezoneH;

			onButtonClick = "_this call BLWK_fnc_shop_depositPointsButtonPressedEvent";
		};
		class theCrateShopDialogsupports_purchaseForPoolButton: theCrateShopDialogbaseClass_button
		{
			idc = BLWK_SHOP_SUPP_PURCHASE_POOL_BUTT_IDC;
			text = "Purchase (Pool)"; //--- ToDo: Localize;
			x = 0.523438 * safezoneW + safezoneX;
			y = 0.729167 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;

			onButtonClick = "_this call BLWK_fnc_shop_purchaseForPool";
		};
		class theCrateShopDialogsupports_purchaseForSelfButton: theCrateShopDialogbaseClass_button
		{
			idc = BLWK_SHOP_SUPP_PURCHASE_SELF_BUTT_IDC;
			text = "Purchase (Self)"; //--- ToDo: Localize;
			x = 0.40625 * safezoneW + safezoneX;
			y = 0.729167 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;

			onButtonClick = "_this call BLWK_fnc_shop_purchaseForSelf";
		};
		class theCrateShopDialogpoints_withdraw_button: theCrateShopDialogbaseClass_button
		{
			idc = BLWK_SHOP_POINTS_WITHDRAW_BUTT_IDC;
			
			text = "Withdraw Points"; //--- ToDo: Localize;
			x = 0.505859 * safezoneW + safezoneX;
			y = 0.802083 * safezoneH + safezoneY;
			w = 0.169922 * safezoneW;
			h = 0.0208333 * safezoneH;

			onButtonClick = "_this call BLWK_fnc_shop_withdrawPointsButtonPressedEvent";
		};
		class theCrateShopDialogclose_button: RscButtonMenu
		{
			idc = BLWK_SHOP_CLOSE_BUTT_IDC;
			
			text = ""; //--- ToDo: Localize;
			x = 0.810547 * safezoneW + safezoneX;
			y = 0.208333 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
			textureNoShortcut = "\A3\3den\Data\Displays\Display3DEN\search_END_ca.paa";
			class ShortcutPos
			{
				left = 0;
				top = 0;
				w = 0.0117188 * safezoneW;
				h = 0.0208333 * safezoneH;
			};
			animTextureNormal = "#(argb,8,8,3)color(1,0,0,0.57)";
			animTextureDisabled = "";
			animTextureOver = "#(argb,8,8,3)color(1,0,0,0.57)";
			animTextureFocused = "";
			animTexturePressed = "#(argb,8,8,3)color(1,0,0,0.57)";
			animTextureDefault = "";

			onButtonClick = "closeDialog 2";
		};

		/* -------------------------------------------------------------------------
			Edit boxes
		------------------------------------------------------------------------- */
		class theCrateShopDialogsupports_searchBar: theCrateShopDialogbaseClass_editBox
		{
			idc = BLWK_SHOP_SUPP_EDIT_IDC;
			
			x = 0.494141 * safezoneW + safezoneX;
			y = 0.479167 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogbuildableObjects_searchBar: theCrateShopDialogbaseClass_editBox
		{
			idc = BLWK_SHOP_BUILD_EDIT_IDC;
			
			x = 0.283203 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogcommunityPool_searchBar: theCrateShopDialogbaseClass_editBox
		{
			idc = BLWK_SHOP_POOL_EDIT_IDC;
			
			x = 0.705078 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogpoints_deposit_edit: theCrateShopDialogbaseClass_editBox
		{
			idc = BLWK_SHOP_POINTS_DEPOSIT_EDIT_IDC;
			
			x = 0.441406 * safezoneW + safezoneX;
			y = 0.78125 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
			onKeyDown = "_this call BLWK_fnc_shop_adjustPartnerControl";
		};
		class theCrateShopDialogpoints_withdraw_edit: theCrateShopDialogbaseClass_editBox
		{
			idc = BLWK_SHOP_POINTS_WITHDRAW_EDIT_IDC;
			
			x = 0.505859 * safezoneW + safezoneX;
			y = 0.78125 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
			onKeyDown = "_this call BLWK_fnc_shop_adjustPartnerControl";
		};

		/* -------------------------------------------------------------------------
			Sliders
		------------------------------------------------------------------------- */
		class theCrateShopDialogpoints_deposit_slider: theCrateShopDialogbaseClass_xSliderH
		{
			idc = BLWK_SHOP_POINTS_DEPOSIT_SLIDER_IDC;
			
			x = 0.324219 * safezoneW + safezoneX;
			y = 0.78125 * safezoneH + safezoneY;
			w = 0.117187 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogpoints_withdraw_slider: theCrateShopDialogbaseClass_xSliderH
		{
			idc = BLWK_SHOP_POINTS_WITHDRAW_SLIDER_IDC;
			
			x = 0.558594 * safezoneW + safezoneX;
			y = 0.78125 * safezoneH + safezoneY;
			w = 0.117187 * safezoneW;
			h = 0.0208333 * safezoneH;
		};

		/* -------------------------------------------------------------------------
			Tree Views
		------------------------------------------------------------------------- */
		class theCrateShopDialogbuildableObjects_treeView: theCrateShopDialogbaseClass_treeView
		{
			idc = BLWK_SHOP_BUILD_TREE_IDC;
			idcSearch = BLWK_SHOP_BUILD_EDIT_IDC;

			x = 0.195312 * safezoneW + safezoneX;
			y = 0.28125 * safezoneH + safezoneY;
			w = 0.1875 * safezoneW;
			h = 0.447917 * safezoneH;
			onLoad = "_this call BLWK_fnc_shop_populateBuildTree";
			onTreeMouseMove = "_this call BLWK_fnc_shop_mouseMoveTreeEvent";
			onTreeMouseExit = "_this call BLWK_fnc_shop_mouseExitTreeEvent";
			sizeEx = TEXT_SIZE_SMALL(0.229167,12);
		};
		class theCrateShopDialogsupports_treeView: theCrateShopDialogbaseClass_treeView
		{
			idc = BLWK_SHOP_SUPP_TREE_IDC;
			idcSearch = BLWK_SHOP_SUPP_EDIT_IDC;

			x = 0.40625 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.1875 * safezoneW;
			h = 0.229167 * safezoneH;

			onLoad = "_this call BLWK_fnc_shop_populateSupportTree";
			sizeEx = TEXT_SIZE_SMALL(0.229167,12);
		};
		class theCrateShopDialogcommunityPool_treeView: theCrateShopDialogbaseClass_treeView
		{
			idc = BLWK_SHOP_POOL_TREE_IDC;
			idcSearch = BLWK_SHOP_POOL_EDIT_IDC;

			x = 0.617188 * safezoneW + safezoneX;
			y = 0.28125 * safezoneH + safezoneY;
			w = 0.1875 * safezoneW;
			h = 0.447917 * safezoneH;
			onTreeMouseMove = "_this call BLWK_fnc_shop_mouseMoveTreeEvent";
			onTreeMouseExit = "_this call BLWK_fnc_shop_mouseExitTreeEvent";

			sizeEx = TEXT_SIZE_SMALL(0.229167,12);
		};
		

		/* -------------------------------------------------------------------------
			Other
		------------------------------------------------------------------------- */
		class theCrateShopDialogpreviewPic: theCrateShopDialogbaseClass_picture
		{
			idc = BLWK_SHOP_PREVIEW_IDC;

			text = "preview.paa";
			x = 0.40625 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.1875 * safezoneW;
			h = 0.208333 * safezoneH;
		};


		/* -------------------------------------------------------------------------
			Search Icons
		------------------------------------------------------------------------- */
		class theCrateShopDialogbuildableObjects_searchIcon: theCrateShopDialogbaseClass_picture
		{
			idc = 1200;
			
			text = "\A3\3den\Data\Displays\Display3DEN\search_start_ca.paa";
			x = 0.792969 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogsupports_searchIcon: theCrateShopDialogbaseClass_picture
		{
			idc = 1202;
			
			text = "\A3\3den\Data\Displays\Display3DEN\search_start_ca.paa";
			x = 0.582031 * safezoneW + safezoneX;
			y = 0.479167 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogcommunityPool_searchIcon: theCrateShopDialogbaseClass_picture
		{
			idc = 1203;
			
			text = "\A3\3den\Data\Displays\Display3DEN\search_start_ca.paa";
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
	};
};

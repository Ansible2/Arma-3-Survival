#define PROFILE_BACKGROUND_COLOR(ALPHA)\
{\
	"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",\
	ALPHA\
}

class bulwarkShopDialog
{
    idd = 9999;
    movingEnabled = false;

    class controls
    {
        class bulwarkShopDialog_rscPicture: RscPicture
        {
            idc = 1200;
            text = "#(argb,8,8,3)color(0.1,0.1,0.1,0.8)";
            x = 0.3 * safezoneW + safezoneX;
            y = 0.25 * safezoneH + safezoneY;
            w = 0.4 * safezoneW;
            h =  0.385 * safezoneH;
        };

        class bulwarkShopDialog_buildList: RscListbox
        {
            idc = 1500;
            x = 0.31 * safezoneW + safezoneX;
            y = 0.27 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.3 * safezoneH;
        };
		
		class ObjectPicture: RscPicture
        {
            idc = 1502;
			text = "preview.paa";
            x = 0.1 * safezoneW + safezoneX;
            y = 0.3 * safezoneH + safezoneY;
            w = 0.2 * safezoneW;
            h = 0.2 * safezoneH;
        };
		
        class bulwarkShopDialog_buildButton: RscButton
        {
            idc = 1600;
            text = "Purchase Building";
            x = 0.309 * safezoneW + safezoneX;
            y = 0.58 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.04 * safezoneH;
            action = "null = [] spawn BLWK_fnc_purchaseObject";
            colorBackground[] = PROFILE_BACKGROUND_COLOR(0.65);
            colorBackgroundActive[] = PROFILE_BACKGROUND_COLOR(1);
            colorFocused[] = PROFILE_BACKGROUND_COLOR(0.65);
        };

        class bulwarkShopDialog_supportLst: RscListbox
        {
            idc = 1501;
            x = 0.505 * safezoneW + safezoneX;
            y = 0.27 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.3 * safezoneH;
        };
        class bulwarkShopDialog_supportButton: RscButton
        {
            idc = 1601;
            text = "Purchase Support";
            x = 0.505 * safezoneW + safezoneX;
            y = 0.58 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.04 * safezoneH;
            action = "call BLWK_fnc_purchaseSupport";
            colorBackground[] = PROFILE_BACKGROUND_COLOR(0.65);
            colorBackgroundActive[] = PROFILE_BACKGROUND_COLOR(1);
            colorFocused[] = PROFILE_BACKGROUND_COLOR(0.65);
        };
    };
};



/*
#define PROFILE_BACKGROUND_COLOR(ALPHA)\
{\
	"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",\
	ALPHA\
}
#define BORDER_COLOR(ALPHA) {0,0,0,ALPHA}
#define BACKGROUND_FRAME_COLOR(ALPHA) {0,0,0,ALPHA}




#define BLWK_SHOP_IDD 97900

#define BLWK_SHOP_BUILD_PURCHASE_SELF_BUTT_IDC 97901
#define BLWK_SHOP_BUILD_PURCHASE_POOL_BUTT_IDC 97902

#define BLWK_SHOP_SUPP_PURCHASE_SELF_BUTT_IDC 97903
#define BLWK_SHOP_SUPP_PURCHASE_POOL_BUTT_IDC 97904

#define BLWK_SHOP_POOL_WITHDRAW_BUTT_IDC 97905

#define BLWK_SHOP_POINTS_DEPOSIT_BUTT_IDC 97906
#define BLWK_SHOP_POINTS_WITHDRAW_BUTT_IDC 97907

#define BLWK_SHOP_SUPP_EDIT_IDC 97908
#define BLWK_SHOP_BUILD_EDIT_IDC 97909
#define BLWK_SHOP_POOL_EDIT_IDC 97910
#define BLWK_SHOP_POINTS_WITHDRAW_EDIT_IDC 97911
#define BLWK_SHOP_POINTS_DEPOSIT_EDIT_IDC 97912

#define BLWK_SHOP_POINTS_WITHDRAW_SLIDER_IDC 97913
#define BLWK_SHOP_POINTS_DEPOSIT_SLIDER_IDC 97914

#define BLWK_SHOP_SUPP_TREE_IDC 97915
#define BLWK_SHOP_BUILD_TREE_IDC 97916
#define BLWK_SHOP_POOL_TREE_IDC 97917

#define BLWK_SHOP_PREVIEW_IDC 97918


// base classes
class bulwarkShopDialog_baseClass_button
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
	font = "PuristaMedium";
	sizeEx = GUI_TEXT_SIZE_SMALL;
	url = "";
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	borderSize = 0;
};
class bulwarkShopDialog_baseClass_treeView
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
class bulwarkShopDialog_baseClass_text
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
class bulwarkShopDialog_baseClass_picture
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
class bulwarkShopDialog_baseClass_shortcutButton
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
	style = ST_LEFT;
	default = 0;
	shadow = 1;
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
class bulwarkShopDialog_baseClass_editBox
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
class bulwarkShopDialog_baseClass_xSliderH
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
	lineSize = 0;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};



// additional bases
class bulwarkShopDialog_baseClass_headerText: bulwarkShopDialog_baseClass_text
{
	font = "RobotoCondensed";
	SizeEx = GUI_TEXT_SIZE_MEDIUM;
	colorBackground[] = BORDER_COLOR(1);
};
class bulwarkShopDialog_baseClass_border: bulwarkShopDialog_baseClass_text
{
	colorBackground[] = BORDER_COLOR(0.75);
};
class bulwarkShopDialog_baseClass_background: bulwarkShopDialog_baseClass_text
{
	colorBackground[] = BACKGROUND_FRAME_COLOR(0.60);
};




class bulwarkShopDialog
{
    idd = BLWK_SHOP_IDD;
    movingEnabled = false;
	
	class controlsBackground
	{	
		// backgrounds
		class bulwarkShopDialog_buildableObjects_background: bulwarkShopDialog_baseClass_background
		{
			idc = -1;

			x = 0.294922 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.199219 * safezoneW;
			h = 0.229167 * safezoneH;
		};
		class bulwarkShopDialog_supports_background: bulwarkShopDialog_baseClass_background
		{
			idc = -1;

			x = 0.294922 * safezoneW + safezoneX;
			y = 0.510417 * safezoneH + safezoneY;
			w = 0.199219 * safezoneW;
			h = 0.229167 * safezoneH;
		};
		class bulwarkShopDialog_previewPic_background: bulwarkShopDialog_baseClass_background
		{
			idc = -1;

			x = 0.505859 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.199219 * safezoneW;
			h = 0.229167 * safezoneH;
		};
		class bulwarkShopDialog_communityPool_background: bulwarkShopDialog_baseClass_background
		{
			idc = -1;

			x = 0.505859 * safezoneW + safezoneX;
			y = 0.510417 * safezoneH + safezoneY;
			w = 0.199219 * safezoneW;
			h = 0.229167 * safezoneH;
		};


		// borders
		class bulwarkShopDialog_border_right: bulwarkShopDialog_baseClass_border
		{
			idc = -1;

			x = 0.716797 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.00585938 * safezoneW;
			h = 0.5 * safezoneH;
		};
		class bulwarkShopDialog_border_left: bulwarkShopDialog_baseClass_border
		{
			idc = -1;

			x = 0.277344 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.00585938 * safezoneW;
			h = 0.5 * safezoneH;
		};
		class bulwarkShopDialog_border_bottom: bulwarkShopDialog_baseClass_border
		{
			idc = -1;
			
			x = 0.277344 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.445313 * safezoneW;
			h = 0.0625 * safezoneH;
		};


		// primary background
		class bulwarkShopDialog_backgroundPrimary: bulwarkShopDialog_baseClass_text
		{
			idc = -1;
			x = 0.283203 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.433594 * safezoneW;
			h = 0.5 * safezoneH;
			colorBackground[] = BORDER_COLOR(0.35);
		};
	};
	
    class controls
    {
		// header texts
		class bulwarkShopDialog_headerText: bulwarkShopDialog_baseClass_headerText
		{
			idc = -1;

			text = "Shop"; //--- ToDo: Localize;
			x = 0.277344 * safezoneW + safezoneX;
			y = 0.229167 * safezoneH + safezoneY;
			w = 0.445313 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
		};
		class bulwarkShopDialog_communityPool_headerText: bulwarkShopDialog_baseClass_headerText
		{
			idc = -1;
			
			text = "Community Pool"; //--- ToDo: Localize;
			x = 0.511719 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_supports_headerText: bulwarkShopDialog_baseClass_headerText
		{
			idc = -1;

			text = "Supports"; //--- ToDo: Localize;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_buildableObjects_headerText: bulwarkShopDialog_baseClass_headerText
		{
			idc = -1;

			text = "Buildable Objects"; //--- ToDo: Localize;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.270833 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};


		// Buttons
		class bulwarkShopDialog_buildableObjects_purchaseForSelfButton: bulwarkShopDialog_baseClass_button
		{
			idc = BLWK_SHOP_BUILD_PURCHASE_SELF_BUTT_IDC;
			text = "Purchase (Self)"; //--- ToDo: Localize;

			x = 0.300781 * safezoneW + safezoneX;
			y = 0.458333 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_buildableObjects_purchaseForPoolButton: bulwarkShopDialog_baseClass_button
		{
			idc = BLWK_SHOP_BUILD_PURCHASE_POOL_BUTT_IDC;
			text = "Purchase (Pool)"; //--- ToDo: Localize;
			x = 0.417969 * safezoneW + safezoneX;
			y = 0.458333 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_communityPool_withdrawButton: bulwarkShopDialog_baseClass_button
		{
			idc = BLWK_SHOP_POOL_WITHDRAW_BUTT_IDC;
			text = "Withdraw"; //--- ToDo: Localize;
			x = 0.511719 * safezoneW + safezoneX;
			y = 0.708333 * safezoneH + safezoneY;
			w = 0.1875 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_points_deposit_button: bulwarkShopDialog_baseClass_button
		{
			idc = BLWK_SHOP_POINTS_DEPOSIT_BUTT_IDC;
			text = "Deposit Points"; //--- ToDo: Localize;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.78125 * safezoneH + safezoneY;
			w = 0.169922 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_supports_purchaseForPoolButton: bulwarkShopDialog_baseClass_button
		{
			idc = BLWK_SHOP_SUPP_PURCHASE_POOL_BUTT_IDC;
			text = "Purchase (Pool)"; //--- ToDo: Localize;
			x = 0.417969 * safezoneW + safezoneX;
			y = 0.708333 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_supports_purchaseForSelfButton: bulwarkShopDialog_baseClass_button
		{
			idc = BLWK_SHOP_SUPP_PURCHASE_SELF_BUTT_IDC;
			text = "Purchase (Self)"; //--- ToDo: Localize;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.708333 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_points_withdraw_button: bulwarkShopDialog_baseClass_button
		{
			idc = BLWK_SHOP_POINTS_WITHDRAW_BUTT_IDC;
			
			text = "Withdraw Points"; //--- ToDo: Localize;
			x = 0.529297 * safezoneW + safezoneX;
			y = 0.78125 * safezoneH + safezoneY;
			w = 0.169922 * safezoneW;
			h = 0.0208333 * safezoneH;
		};


		// edit bars
		class bulwarkShopDialog_supports_searchBar: bulwarkShopDialog_baseClass_editBox
		{
			idc = BLWK_SHOP_SUPP_EDIT_IDC;
			
			x = 0.388672 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_buildableObjects_searchBar: bulwarkShopDialog_baseClass_editBox
		{
			idc = BLWK_SHOP_BUILD_EDIT_IDC;
			
			x = 0.388672 * safezoneW + safezoneX;
			y = 0.270833 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_communityPool_searchBar: bulwarkShopDialog_baseClass_editBox
		{
			idc = BLWK_SHOP_POOL_EDIT_IDC;
			
			x = 0.599609 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_points_deposit_edit: bulwarkShopDialog_baseClass_editBox
		{
			idc = BLWK_SHOP_POINTS_DEPOSIT_EDIT_IDC;
			
			x = 0.417969 * safezoneW + safezoneX;
			y = 0.760417 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_points_withdraw_edit: bulwarkShopDialog_baseClass_editBox
		{
			idc = BLWK_SHOP_POINTS_WITHDRAW_EDIT_IDC;
			
			x = 0.646484 * safezoneW + safezoneX;
			y = 0.760417 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
		};



		// sliders
		class bulwarkShopDialog_points_deposit_slider: bulwarkShopDialog_baseClass_xSliderH
		{
			idc = BLWK_SHOP_POINTS_DEPOSIT_SLIDER_IDC;
			
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.760417 * safezoneH + safezoneY;
			w = 0.117187 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_points_withdraw_slider: bulwarkShopDialog_baseClass_xSliderH
		{
			idc = BLWK_SHOP_POINTS_WITHDRAW_SLIDER_IDC;
			
			x = 0.529297 * safezoneW + safezoneX;
			y = 0.760417 * safezoneH + safezoneY;
			w = 0.117187 * safezoneW;
			h = 0.0208333 * safezoneH;
		};



		// trees
		class bulwarkShopDialog_buildableObjects_treeView: bulwarkShopDialog_baseClass_treeView
		{
			idc = BLWK_SHOP_BUILD_TREE_IDC;
			idcSearch = BLWK_SHOP_BUILD_EDIT_IDC;

			x = 0.300781 * safezoneW + safezoneX;
			y = 0.291667 * safezoneH + safezoneY;
			w = 0.1875 * safezoneW;
			h = 0.166667 * safezoneH;
			

			onLoad = "params ['_tv'];\
					_classes = 'true' configClasses (configFile >> 'CfgVehicles');\
					for '_i' from 0 to 10 do\
					{\
						_tv tvAdd [[], configName selectRandom _classes];\
						for '_j' from 0 to 10 do\
						{\
							_tv tvAdd [[_i], configName selectRandom _classes];\
							for '_k' from 0 to 10 do\
							{\
								_tv tvAdd [[_i, _j], configName selectRandom _classes];\
							};\
						};\
					};";
			moving = 0;
			type = CT_TREE;
			style = ST_LEFT;
			sizeEx = (0.166667 * safezoneH) / 9;
		};
		class bulwarkShopDialog_supports_treeView: bulwarkShopDialog_baseClass_treeView
		{
			idc = BLWK_SHOP_SUPP_TREE_IDC;
			idcSearch = BLWK_SHOP_SUPP_EDIT_IDC;

			x = 0.300781 * safezoneW + safezoneX;
			y = 0.541667 * safezoneH + safezoneY;
			w = 0.1875 * safezoneW;
			h = 0.166667 * safezoneH;

			onLoad = "_this call BLWK_fnc_popList";
			onTreeMouseMove = "_this call BLWK_fnc_updatePicture";
			onTreeMouseExit = "_this call BLWK_fnc_exitMouseEvent";
		};
		class bulwarkShopDialog_communityPool_treeView: bulwarkShopDialog_baseClass_treeView
		{
			idc = BLWK_SHOP_POOL_TREE_IDC;
			idcSearch = BLWK_SHOP_POOL_EDIT_IDC;

			x = 0.511719 * safezoneW + safezoneX;
			y = 0.541667 * safezoneH + safezoneY;
			w = 0.1875 * safezoneW;
			h = 0.166667 * safezoneH;
		};
		

		// other
		class bulwarkShopDialog_previewPic: bulwarkShopDialog_baseClass_picture
		{
			idc = BLWK_SHOP_PREVIEW_IDC;

			text = "preview.paa";
			x = 0.511719 * safezoneW + safezoneX;
			y = 0.270833 * safezoneH + safezoneY;
			w = 0.1875 * safezoneW;
			h = 0.208333 * safezoneH;
		};


		// search/clear icons
		class bulwarkShopDialog_buildableObjects_searchIcon: bulwarkShopDialog_baseClass_picture
		{
			idc = 1200;
			
			text = "\A3\3den\Data\Displays\Display3DEN\search_start_ca.paa";
			x = 0.476562 * safezoneW + safezoneX;
			y = 0.270833 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_supports_searchIcon: bulwarkShopDialog_baseClass_picture
		{
			idc = 1202;
			
			text = "\A3\3den\Data\Displays\Display3DEN\search_start_ca.paa";
			x = 0.476562 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_communityPool_searchIcon: bulwarkShopDialog_baseClass_picture
		{
			idc = 1203;
			
			text = "\A3\3den\Data\Displays\Display3DEN\search_start_ca.paa";
			x = 0.6875 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
	};
};


*/
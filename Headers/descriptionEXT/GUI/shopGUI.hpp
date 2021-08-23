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
class theCrateShopDialogbaseClass_button : RscButton
{
	colorText[] = {1,1,1,1};
	colorBackground[] = PROFILE_BACKGROUND_COLOR(0.65);
	colorBackgroundActive[] = PROFILE_BACKGROUND_COLOR(1);
	colorFocused[] = PROFILE_BACKGROUND_COLOR(0.65);
	colorShadow[] = {0,0,0,1};
	colorBorder[] = {0,0,0,1};
	shadow = 2;
	font = "RobotoCondensed";
	sizeEx = TEXT_SIZE_SMALL(0.0208333,1.1);
	style = ST_CENTER;
	borderSize = 0;
};


class theCrateShopDialogbaseClass_xSliderH : RscXSliderH
{
	sliderStep = 1;
	onSliderPosChanged = "_this call BLWK_fnc_shop_adjustPartnerControl";

};

class theCrateShopDialogbaseClass_headerText: RscText
{
	font = "RobotoCondensed";
	SizeEx = GUI_TEXT_SIZE_MEDIUM;
	colorBackground[] = BORDER_COLOR(1);
};
class theCrateShopDialogbaseClass_border: RscText
{
	colorBackground[] = BORDER_COLOR(0.75);
};
class theCrateShopDialogbaseClass_background: RscText
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
		class theCrateShopDialogbackgroundPrimary: RscText
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
		class theCrateShopDialogsupports_searchBar: RscEdit
		{
			idc = BLWK_SHOP_SUPP_EDIT_IDC;

			x = 0.494141 * safezoneW + safezoneX;
			y = 0.479167 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogbuildableObjects_searchBar: RscEdit
		{
			idc = BLWK_SHOP_BUILD_EDIT_IDC;

			x = 0.283203 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogcommunityPool_searchBar: RscEdit
		{
			idc = BLWK_SHOP_POOL_EDIT_IDC;

			x = 0.705078 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogpoints_deposit_edit: RscEdit
		{
			idc = BLWK_SHOP_POINTS_DEPOSIT_EDIT_IDC;

			x = 0.441406 * safezoneW + safezoneX;
			y = 0.78125 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
			onKeyDown = "_this call BLWK_fnc_shop_adjustPartnerControl";
		};
		class theCrateShopDialogpoints_withdraw_edit: RscEdit
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
		class theCrateShopDialogbuildableObjects_treeView: RscTree
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
		class theCrateShopDialogsupports_treeView: RscTree
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
		class theCrateShopDialogcommunityPool_treeView: RscTree
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
		class theCrateShopDialogpreviewPic: RscPicture
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
		class theCrateShopDialogbuildableObjects_searchIcon: RscPicture
		{
			idc = -1;

			text = "\A3\3den\Data\Displays\Display3DEN\search_start_ca.paa";
			x = 0.792969 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogsupports_searchIcon: RscPicture
		{
			idc = -1;

			text = "\A3\3den\Data\Displays\Display3DEN\search_start_ca.paa";
			x = 0.582031 * safezoneW + safezoneX;
			y = 0.479167 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class theCrateShopDialogcommunityPool_searchIcon: RscPicture
		{
			idc = -1;

			text = "\A3\3den\Data\Displays\Display3DEN\search_start_ca.paa";
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
	};
};

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
#define BORDER_COLOR {0,0,0,0.5}
class bulwarkShopDialog
{
    idd = 9999;
    movingEnabled = false;
	class controlsBackground
	{
		class bulwarkShopDialog_buildableObjects_background: RscText
		{
			idc = 2200;

			x = 0.294922 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.193359 * safezoneW;
			h = 0.229167 * safezoneH;
			
			colorBackground[] = BORDER_COLOR;
		};
		class bulwarkShopDialog_supports_background: RscText
		{
			idc = 2201;

			x = 0.294922 * safezoneW + safezoneX;
			y = 0.510417 * safezoneH + safezoneY;
			w = 0.193359 * safezoneW;
			h = 0.229167 * safezoneH;

			colorBackground[] = BORDER_COLOR;
		};
		class bulwarkShopDialog_previewPic_background: RscText
		{
			idc = 2205;

			x = 0.511719 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.193359 * safezoneW;
			h = 0.229167 * safezoneH;

			colorBackground[] = BORDER_COLOR;
		};
		class bulwarkShopDialog_communityPool_background: RscText
		{
			idc = 2206;

			x = 0.511719 * safezoneW + safezoneX;
			y = 0.510417 * safezoneH + safezoneY;
			w = 0.193359 * safezoneW;
			h = 0.229167 * safezoneH;

			colorBackground[] = BORDER_COLOR;
		};
		class bulwarkShopDialog_border_right: RscText
		{
			idc = 2202;

			x = 0.716797 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.00585938 * safezoneW;
			h = 0.5 * safezoneH;

			colorBackground[] = BORDER_COLOR;
		};
		class bulwarkShopDialog_border_left: RscText
		{
			idc = 2203;

			x = 0.277344 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.00585938 * safezoneW;
			h = 0.5 * safezoneH;

			colorBackground[] = BORDER_COLOR;
		};
		class bulwarkShopDialog_border_bottom: RscText
		{
			idc = 2204;
			
			x = 0.277344 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.445313 * safezoneW;
			h = 0.0625 * safezoneH;

			colorBackground[] = BORDER_COLOR;
		};
	};
    class controls
    {
		class bulwarkShopDialog_headerText: RscText
		{
			idc = 1000;

			text = "Shop"; //--- ToDo: Localize;
			x = 0.277344 * safezoneW + safezoneX;
			y = 0.229167 * safezoneH + safezoneY;
			w = 0.445313 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class bulwarkShopDialog_communityPool_headerText: RscText
		{
			idc = 100002;

			text = "Community Pool"; //--- ToDo: Localize;
			x = 0.517578 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class bulwarkShopDialog_buildableObjects_treeView: RscTree
		{
			idc = 1500;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.291667 * safezoneH + safezoneY;
			w = 0.181641 * safezoneW;
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
			sizeEx = (0.166667 * safezoneH) / 8;
		};
		class bulwarkShopDialog_communityPool_treeView: RscTree
		{
			idc = 1502;
			x = 0.517578 * safezoneW + safezoneX;
			y = 0.541667 * safezoneH + safezoneY;
			w = 0.181641 * safezoneW;
			h = 0.166667 * safezoneH;
		};
		class bulwarkShopDialog_buildableObjects_purchaseForSelfButton: RscButton
		{
			idc = 1600;
			text = "Purchase (Self)"; //--- ToDo: Localize;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.458333 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_buildableObjects_purchaseForPoolButton: RscButton
		{
			idc = 1602;
			text = "Purchase (Pool)"; //--- ToDo: Localize;
			x = 0.412109 * safezoneW + safezoneX;
			y = 0.458333 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_communityPool_withdrawButton: RscButton
		{
			idc = 1605;
			text = "Withdraw"; //--- ToDo: Localize;
			x = 0.517578 * safezoneW + safezoneX;
			y = 0.708333 * safezoneH + safezoneY;
			w = 0.181641 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_previewPic: RscPicture
		{
			idc = 1201;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.517578 * safezoneW + safezoneX;
			y = 0.270833 * safezoneH + safezoneY;
			w = 0.181641 * safezoneW;
			h = 0.208333 * safezoneH;
		};
		class bulwarkShopDialog_points_deposit_button: RscButton
		{
			idc = 1607;
			text = "Deposit Points"; //--- ToDo: Localize;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.78125 * safezoneH + safezoneY;
			w = 0.169922 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_supports_treeView: RscTree
		{
			idc = 1503;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.541667 * safezoneH + safezoneY;
			w = 0.181641 * safezoneW;
			h = 0.166667 * safezoneH;
		};
		class bulwarkShopDialog_supports_purchaseForPoolButton: RscButton
		{
			idc = 1603;
			text = "Purchase (Pool)"; //--- ToDo: Localize;
			x = 0.412109 * safezoneW + safezoneX;
			y = 0.708333 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_supports_purchaseForSelfButton: RscButton
		{
			idc = 1604;
			text = "Purchase (Self)"; //--- ToDo: Localize;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.708333 * safezoneH + safezoneY;
			w = 0.0703125 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_supports_headerText: RscText
		{
			idc = 1002;

			text = "Supports"; //--- ToDo: Localize;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class bulwarkShopDialog_buildableObjects_headerText: RscText
		{
			idc = 10002;

			text = "Buildable Objects"; //--- ToDo: Localize;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.270833 * safezoneH + safezoneY;
			w = 0.0878906 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class bulwarkShopDialog_supports_searchBar: RscEdit
		{
			idc = 1401;
			x = 0.388672 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0820313 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_buildableObjects_searchBar: RscEdit
		{
			idc = 1402;
			x = 0.388672 * safezoneW + safezoneX;
			y = 0.270833 * safezoneH + safezoneY;
			w = 0.0820313 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_communityPool_searchBar: RscEdit
		{
			idc = 1403;
			x = 0.605469 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0820313 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		
		class bulwarkShopDialog_points_deposit_edit: RscEdit
		{
			idc = 1404;
			x = 0.417969 * safezoneW + safezoneX;
			y = 0.760417 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_points_deposit_slider: RscXSliderH
		{
			idc = 1901;
			x = 0.300781 * safezoneW + safezoneX;
			y = 0.760417 * safezoneH + safezoneY;
			w = 0.117187 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_points_withdraw_button: RscButton
		{
			idc = 1601;
			text = "Withdraw Points"; //--- ToDo: Localize;
			x = 0.523438 * safezoneW + safezoneX;
			y = 0.78125 * safezoneH + safezoneY;
			w = 0.169922 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_points_withdraw_slider: RscXSliderH
		{
			idc = 1900;
			x = 0.523438 * safezoneW + safezoneX;
			y = 0.760417 * safezoneH + safezoneY;
			w = 0.117187 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_points_withdraw_edit: RscEdit
		{
			idc = 1400;
			x = 0.640625 * safezoneW + safezoneX;
			y = 0.760417 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
		};

		class bulwarkShopDialog_buildableObjects_searchIcon: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.470703 * safezoneW + safezoneX;
			y = 0.270833 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_supports_searchIcon: RscPicture
		{
			idc = 1202;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.470703 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class bulwarkShopDialog_communityPool_searchIcon: RscPicture
		{
			idc = 1203;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.6875 * safezoneW + safezoneX;
			y = 0.520833 * safezoneH + safezoneY;
			w = 0.0117188 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
	};
};

*/
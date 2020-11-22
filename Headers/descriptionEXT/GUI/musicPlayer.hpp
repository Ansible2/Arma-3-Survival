class myDialog
{
	idd = 1234;
	movingEnabled = true;
	enableSimulation = true;
	
	class controlsBackground
	{
		/*
		class backGroundFrame: RscText
		{
			idc = 1008;

			x = 0.294922 * safezoneW + safezoneX;
			y = 0.229167 * safezoneH + safezoneY;
			w = 0.410156 * safezoneW;
			h = 0.541667 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.1};
		};
		*/
		class filler_1: RscText
		{
			idc = -1;

			text = ""; //--- ToDo: Localize;
			x = 0.294922 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.00585938 * safezoneW;
			h = 0.03125 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class filler_2: RscText
		{
			idc = -1;

			text = ""; //--- ToDo: Localize;
			x = 0.699219 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.00585938 * safezoneW;
			h = 0.03125 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		/*
			class filler_3: RscText
			{
				idc = -1;

				text = ""; //--- ToDo: Localize;
				x = 0.494141 * safezoneW + safezoneX;
				y = 0.291667 * safezoneH + safezoneY;
				w = 0.00585938 * safezoneW;
				h = 0.0208333 * safezoneH;
				colorBackground[] = {-1,-1,-1,1};
			};
			class filler_4: RscText
			{
				idc = -1;

				text = ""; //--- ToDo: Localize;
				x = 0.330078 * safezoneW + safezoneX;
				y = 0.291667 * safezoneH + safezoneY;
				w = 0.00585938 * safezoneW;
				h = 0.0208333 * safezoneH;
				colorBackground[] = {-1,-1,-1,1};
			};
		*/
	};
	
	class controls
	{
		class playlistListBox: RscListBox
		{
			idc = 1500;

			x = 0.587891 * safezoneW + safezoneX;
			y = 0.333333 * safezoneH + safezoneY;
			w = 0.117187 * safezoneW;
			h = 0.416667 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.25};
		};
		class Playlist_Text: RscText
		{
			idc = 1000;

			text = "Playlist Maker"; //--- ToDo: Localize;
			x = 0.294922 * safezoneW + safezoneX;
			y = 0.239583 * safezoneH + safezoneY;
			w = 0.1875 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class playPaused_Text: RscText
		{
			idc = 222222;

			text = "Playing"; //--- ToDo: Localize;
			x = 0.482422 * safezoneW + safezoneX;
			y = 0.239583 * safezoneH + safezoneY;
			w = 0.123047 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class Songs_Listbox: RscListNBox
		{
			idc = 1501;

			x = 0.294922 * safezoneW + safezoneX;
			y = 0.333333 * safezoneH + safezoneY;
			w = 0.292969 * safezoneW;
			h = 0.416667 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.25};
			sizeEx = 0.0208333 * safezoneH;
			onLoad = "[(_this select 0)] call loadMusic";
		};
		class CloseButton: RscButton
		{
			idc = 1600;

			text = "Close"; //--- ToDo: Localize;
			x = 0.628906 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.0761719 * safezoneW;
			h = 0.0208333 * safezoneH;
			//colorBackground[] = {-1,-1,-1,1};
		};
		class commitChanges: RscButton
		{
			idc = 1608;

			text = "Commit Changes"; //--- ToDo: Localize;
			x = 0.628906 * safezoneW + safezoneX;
			y = 0.291667 * safezoneH + safezoneY;
			w = 0.0761719 * safezoneW;
			h = 0.0208333 * safezoneH;
			//colorBackground[] = {-1,-1,-1,1};
		};
		class playing_slider: RscXSliderH
		{
			idc = 1900;

			x = 0.277344 * safezoneW + safezoneX;
			y = 0.260417 * safezoneH + safezoneY;
			w = 0.445313 * safezoneW;
			h = 0.03125 * safezoneH;
		};
		class addToPlayList_Button: RscButton
		{
			idc = 1601;

			text = "Add To Playlist"; //--- ToDo: Localize;
			x = 0.294922 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.0761719 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class play_Button: RscButton
		{
			idc = -1;

			text = "Play"; //--- ToDo: Localize;
			x = 0.447266 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class pause_Button: RscButton
		{
			idc = -1;

			text = "Pause"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class currentPlaylist_text: RscText
		{
			idc = 1001;

			text = "Current Playlist"; //--- ToDo: Localize;
			x = 0.587891 * safezoneW + safezoneX;
			y = 0.3125 * safezoneH + safezoneY;
			w = 0.117187 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class volume_text: RscText
		{
			idc = 1002;

			text = "Volume:"; //--- ToDo: Localize;
			x = 0.294922 * safezoneW + safezoneX;
			y = 0.291667 * safezoneH + safezoneY;
			w = 0.0351563 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class volume_slider: RscXSliderH
		{
			idc = 1901;
		
			x = 0.318359 * safezoneW + safezoneX;
			y = 0.291667 * safezoneH + safezoneY;
			w = 0.117187 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class titleText: RscText
		{
			idc = 1001;

			text = "Title"; //--- ToDo: Localize;
			x = 0.294922 * safezoneW + safezoneX;
			y = 0.3125 * safezoneH + safezoneY;
			w = 0.240234 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class DurationText: RscText
		{
			idc = 1001;

			text = "Duration"; //--- ToDo: Localize;
			x = 0.535156 * safezoneW + safezoneX;
			y = 0.3125 * safezoneH + safezoneY;
			w = 0.0527344 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class editSpacing: RscEdit
		{
			idc = 1400;

			text = "[200,250,300]"; //--- ToDo: Localize;
			x = 0.470703 * safezoneW + safezoneX;
			y = 0.291667 * safezoneH + safezoneY;
			w = 0.0585937 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,-1};
		};
		class setSpacingText: RscButton
		{
			idc = 1600;

			text = "Set Spacing"; //--- ToDo: Localize;
			x = 0.423828 * safezoneW + safezoneX;
			y = 0.291667 * safezoneH + safezoneY;
			w = 0.046875 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class RscText_1007: RscText // bottom spacer// should replace with search
		{
			idc = 1007;

			x = 0.371094 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.0761719 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class RscText_1110: RscText // bottom spacer// should replace with search
		{
			idc = 1110;

			x = 0.552734 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.0761719 * safezoneW;
			h = 0.0208333 * safezoneH;
			colorBackground[] = {-1,-1,-1,1};
		};
		class changeSpacingCombo: RscCombo
		{
			idc = 2100;

			x = 0.529297 * safezoneW + safezoneX;
			y = 0.291667 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
		class systemOnOffCombo: RscCombo
		{
			idc = 2101;

			x = 0.605469 * safezoneW + safezoneX;
			y = 0.239583 * safezoneH + safezoneY;
			w = 0.0996094 * safezoneW;
			h = 0.0208333 * safezoneH;
		};
	};
};

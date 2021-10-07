#include "params menu common defines.hpp"

/*
import RscText;
import RscButtonMenu;
import RscButton;
import RscCombo;
import RscEdit;
import RscControlsGroupNoHScrollbars;
import RscControlsGroupNoScrollbars;
import RscToolbox;
import RscXSliderH;
import RscListbox;
*/
import ctrlButtonPicture;
import ctrlButton;


/* ----------------------------------------------------------------------------
    Main Dialog
---------------------------------------------------------------------------- */
class paramsMenu
{
    idd = PARAMS_MENU_IDD;
    movingEnable = 1;

    class controlsBackground
    {
        class paramsMenu_background : RscText
        {
        	idc = -1;
        	x = POS_X(-22);
        	y = POS_Y(-12);
        	w = POS_W(44);
        	h = POS_H(28.5);
        	colorBackground[] = GREY_COLOR(0.15,0.5);
        };
        class paramsMenu_mainControlsGroupBackground : RscText
        {
        	idc = -1;
            x = POS_X(-21.5);
        	y = POS_Y(-9);
        	w = POS_W(43);
        	h = POS_H(20);
        	colorBackground[] = GREY_COLOR(0,0.60);
        };
        class paramsMenu_headerText: RscText
        {
        	idc = -1;
        	text = "Parameter Menu"; //--- ToDo: Localize;
            moving = 1;
            x = POS_X(-22);
        	y = POS_Y(-13);
        	w = POS_W(43);
        	h = POS_H(1);
        	colorBackground[] = PROFILE_BACKGROUND_COLOR(1);
        };
        class paramsMenu_categoryText: RscText
        {
        	idc = -1;
        	text = "Category:"; //--- ToDo: Localize;
            x = POS_X(-21);
            y = POS_Y(-10.25);
        	w = POS_W(3.5);
        	h = POS_H(1);
        };
        class paramsMenu_savedProfileText: RscText
        {
            idc = -1;
            text = "Saved Profile:"; //--- ToDo: Localize;
            x = POS_X(2);
            y = POS_Y(-10.25);
        	w = POS_W(5);
        	h = POS_H(1);
        };
    };

    class controls
    {
        class paramsMenu_mainControlGroup: RscControlsGroupNoHScrollbars
        {
        	idc = PARAMS_MENU_MAIN_CONTROL_GROUP_IDC;
            x = POS_X(-21.5);
        	y = POS_Y(-9);
        	w = POS_W(43);
        	h = POS_H(20);
            lineHeight = POS_H(1);
        };
        class paramsMenu_closeButton: RscButtonMenu
        {
        	idc = PARAMS_MENU_CLOSE_BUTTON_IDC;
            x = POS_X(21);
        	y = POS_Y(-13);
        	w = POS_W(1);
        	h = POS_H(1);
            textureNoShortcut = "\A3\3den\Data\Displays\Display3DEN\search_END_ca.paa";
            animTextureNormal = "#(argb,8,8,3)color(1,0,0,0.57)";
            animTextureDisabled = "";
            animTextureOver = "#(argb,8,8,3)color(1,0,0,0.57)";
            animTextureFocused = "";
            animTexturePressed = "#(argb,8,8,3)color(1,0,0,0.57)";
            animTextureDefault = "";
            class ShortcutPos
            {
                left = 0;
                top = 0;
                w = POS_W(1);
            	h = POS_H(1);
            };

        };
        class paramsMenu_loadCombo: RscCombo
        {
        	idc = PARAMS_MENU_LOAD_COMBO_IDC;
            x = POS_X(7);
            y = POS_Y(-10.25);
        	w = POS_W(14);
        	h = POS_H(1);
        };
        class paramsMenu_saveAsEditBox: RscEdit
        {
        	idc = PARAMS_MENU_SAVEAS_EDIT_BOX_IDC;
            colorBackground[] = {1,1,1,0.25};
            x = POS_X(-16);
        	y = POS_Y(-11.75);
        	w = POS_W(14);
        	h = POS_H(1);
        };
        class paramsMenu_saveButton: ctrlButton
        {
        	idc = PARAMS_MENU_SAVE_BUTTON_IDC;
        	text = "Save"; //--- ToDo: Localize;
            x = POS_X(4.5);
        	y = POS_Y(-11.75);
        	w = POS_W(4.5);
        	h = POS_H(1);
            tooltip = "Saves your current settings over the currently selected profile in the profile list";
        };
        class paramsMenu_loadButton: ctrlButton
        {
        	idc = PARAMS_MENU_LOAD_BUTTON_IDC;
        	text = "Load"; //--- ToDo: Localize;
            x = POS_X(10);
        	y = POS_Y(-11.75);
        	w = POS_W(4.5);
        	h = POS_H(1);
            tooltip = "Loads the currently selected profile in the profile list";
        };
        class paramsMenu_deleteButton: ctrlButton
        {
        	idc = PARAMS_MENU_DELETE_BUTTON_IDC;
        	text = "Delete"; //--- ToDo: Localize;
            colorBackgroundActive[] = {
                1,0,0,0.75
            };
            x = POS_X(15.5);
        	y = POS_Y(-11.75);
        	w = POS_W(4.5);
        	h = POS_H(1);
            tooltip = "Deletes the currently selected profile in the profile list";
        };
        class paramsMenu_saveAsButton: ctrlButton
        {
        	idc = PARAMS_MENU_SAVEAS_BUTTON_IDC;
        	text = "Save As"; //--- ToDo: Localize;
            x = POS_X(-21);
        	y = POS_Y(-11.75);
        	w = POS_W(5);
        	h = POS_H(1);
            tooltip = "The name in the edit box will be saved as a loadable profile. Note that this saves staged changes (yellow), not the current brodcasted values";
        };
        class paramsMenu_categoryCombo: RscCombo
        {
        	idc = PARAMS_MENU_CATEGORY_COMBO_IDC;
            x = POS_X(-17);
        	y = POS_Y(-10.25);
        	w = POS_W(15);
        	h = POS_H(1);
        };
        class paramsMenu_importButton: ctrlButton
        {
        	idc = PARAMS_MENU_IMPORT_BUTTON_IDC;
        	text = "Import"; //--- ToDo: Localize;
            x = POS_X(-21);
        	y = POS_Y(11.5);
        	w = POS_W(4);
        	h = POS_H(1);
        };
        class paramsMenu_exportButton: ctrlButton
        {
        	idc = PARAMS_MENU_EXPORT_BUTTON_IDC;
        	text = "Export"; //--- ToDo: Localize;
            x = POS_X(17);
        	y = POS_Y(11.5);
        	w = POS_W(4);
        	h = POS_H(1);
            tooltip = "This will also copy the output to your clipboard";
        };
        class paramsMenu_portEditBox: RscEdit
        {
        	idc = PARAMS_MENU_PORT_EDIT_BOX_IDC;
            colorBackground[] = {1,1,1,0.25};
            x = POS_X(-17);
        	y = POS_Y(11.5);
        	w = POS_W(34);
        	h = POS_H(1);
        };
        class paramsMenu_commitButton: ctrlButton
        {
        	idc = PARAMS_MENU_COMMIT_BUTTON_IDC;
        	text = "Commit Staged Changes"; //--- ToDo: Localize;
            colorBackgroundActive[] = {
                1,0,0,0.75
            };
            x = POS_X(-4.5);
        	y = POS_Y(-13);
        	w = POS_W(9);
        	h = POS_H(1);
            tooltip = "This will brodcast your changes over the network to all connected machines and add the updates to the JIP queue.";
        };
        class paramsMenu_messageBox : RscListbox
        {
        	idc = PARAMS_MENU_MESSAGE_BOX_IDC;
        	x = POS_X(-21.5);
        	y = POS_Y(13);
        	w = POS_W(43);
        	h = POS_H(3);
        	colorBackground[] = GREY_COLOR(0.35,0.5);
        };
    };
};

/* ----------------------------------------------------------------------------
    Control Group Base
---------------------------------------------------------------------------- */
class PARAMS_MENU_CTRLGRP(rowBase) : RscControlsGroupNoScrollbars
{
    x = POS_W(1);
    y = POS_H(1);
    w = POS_W(42);
    h = POS_H(2);

    class controls
    {
        class settingTitle : RscText
        {
            idc = PARAM_MENU_ROW_TITLE_IDC;
            text = "some text:";
            style = ST_RIGHT;
            w = POS_W(19.5);
            h = POS_H(1);
            colorBackground[] = {-1,-1,-1,-1};
        };
        class defaultButton : ctrlButtonPicture
        {
            idc = PARAM_MENU_DEFAULT_BUTTON_IDC;
            x = POS_W(39.5);
            w = POS_W(1);
            h = POS_H(1);
            text = ICON_DEFAULT;
        };
    };
};

class PARAMS_MENU_CTRLGRP(listBox) : PARAMS_MENU_CTRLGRP(rowBase)
{
    h = POS_H(8);

    class controls : controls
    {
        class settingTitle : settingTitle {};
        class defaultButton : defaultButton {};
        class listbox : RscListbox
        {
            idc = PARAM_MENU_ROW_SETTING_CTRL_IDC;
            x = POS_W(20);
            w = POS_W(19);
            h = POS_H(7);
        };
    };
};

/* ----------------------------------------------------------------------------
    Binary
---------------------------------------------------------------------------- */
class PARAMS_MENU_CTRLGRP(binary) : PARAMS_MENU_CTRLGRP(rowBase)
{
    class controls : controls
    {
        class settingTitle : settingTitle {};
        class defaultButton : defaultButton {};
        class settingToolbox : RscToolbox
        {
            idc = PARAM_MENU_ROW_SETTING_CTRL_IDC;
            x = POS_W(20);
            w = POS_W(9);
            h = POS_H(1);
            values[] = {
                0,
                1
            };
            strings[] = {
                "",
                ""
            };
        };
    };
};

/* ----------------------------------------------------------------------------
    SLider
---------------------------------------------------------------------------- */
class PARAMS_MENU_CTRLGRP(slider) : PARAMS_MENU_CTRLGRP(rowBase)
{
    class controls : controls
    {
        class settingTitle : settingTitle {};
        class defaultButton : defaultButton {};
        class settingSlider : RscXSliderH
        {
            idc = PARAM_MENU_ROW_SETTING_CTRL_IDC;
            x = POS_W(20);
            w = POS_W(16);
            h = POS_H(1);
        };
        class settingEditBox : RscEdit
        {
            idc = PARAM_MENU_ROW_SECONDARY_SETTING_CTRL_IDC;
            x = POS_W(36);
            w = POS_W(3);
            h = POS_H(1);
        };
    };
};

/* ----------------------------------------------------------------------------
    Combo list
---------------------------------------------------------------------------- */
class PARAMS_MENU_CTRLGRP(comboList) : PARAMS_MENU_CTRLGRP(rowBase)
{
    class controls : controls
    {
        class settingTitle : settingTitle {};
        class defaultButton : defaultButton {};
        class settingComboList : RscCombo
        {
            idc = PARAM_MENU_ROW_SETTING_CTRL_IDC;
            x = POS_W(20);
            w = POS_W(19);
            h = POS_H(1);
        };
    };
};

/* ----------------------------------------------------------------------------
    Edit Box
---------------------------------------------------------------------------- */
class PARAMS_MENU_CTRLGRP(editBox) : PARAMS_MENU_CTRLGRP(rowBase)
{
    class controls : controls
    {
        class settingTitle : settingTitle {};
        class defaultButton : defaultButton {};
        class settingEditBox : RscEdit
        {
            idc = PARAM_MENU_ROW_SETTING_CTRL_IDC;
            x = POS_W(20);
            w = POS_W(19);
            h = POS_H(1);
        };
    };
};

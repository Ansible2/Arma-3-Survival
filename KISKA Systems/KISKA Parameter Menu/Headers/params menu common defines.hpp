//--- UI_GRID
#define UI_GRID_X (0.5)
#define UI_GRID_Y (0.5)
#define UI_GRID_W (2.5 * pixelW * pixelGrid)
#define UI_GRID_H (2.5 * pixelH * pixelGrid)

#define POS_X(N) N * UI_GRID_W + UI_GRID_X
#define POS_Y(N) N * UI_GRID_H + UI_GRID_Y
#define POS_W(N) N * UI_GRID_W
#define POS_H(N) N * UI_GRID_H

#define ICON_DEFAULT "\a3\3den\Data\Displays\Display3DEN\ToolBar\undo_ca.paa"

// params menu ids
#define PARAMS_MENU_IDD 5020
#define PARAMS_MENU_MAIN_CONTROL_GROUP_IDC 5021
#define PARAMS_MENU_CLOSE_BUTTON_IDC 5022
#define PARAMS_MENU_LOAD_COMBO_IDC 5023
#define PARAMS_MENU_CATEGORY_COMBO_IDC 5024
#define PARAMS_MENU_SAVEAS_EDIT_BOX_IDC 5025
#define PARAMS_MENU_SAVE_BUTTON_IDC 5026
#define PARAMS_MENU_LOAD_BUTTON_IDC 5027
#define PARAMS_MENU_SAVEAS_BUTTON_IDC 5028
#define PARAMS_MENU_LISTBOX_IDC 5029

#define PARAM_MENU_ROW_SETTING_CTRL_IDC 5030 // the primary control to read values from when changing the value of a parameter global
#define PARAM_MENU_ROW_TITLE_IDC 5031
#define PARAM_MENU_DEFAULT_BUTTON_IDC 5032
#define PARAM_MENU_ROW_SECONDARY_SETTING_CTRL_IDC 5033 // used for additional controls in the group capable of editing the main one's value (e.g. the edit box next to a slider)

#define PARAMS_MENU_IMPORT_BUTTON_IDC 5034
#define PARAMS_MENU_EXPORT_BUTTON_IDC 5035
#define PARAMS_MENU_PORT_EDIT_BOX_IDC 5036
#define PARAMS_MENU_COMMIT_BUTTON_IDC 5037
#define PARAMS_MENU_DELETE_BUTTON_IDC 5038

#define PARAMS_MENU_MESSAGE_BOX_IDC 5039


#define PARAMS_MENU_CTRLGRP(CLASS) paramsMenu_controlGroup_##CLASS

#define ST_RIGHT          0x01
#define ST_PICTURE        0x30

#define PROFILE_BACKGROUND_COLOR(ALPHA)\
{\
	"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",\
	"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",\
	ALPHA\
}

#define GREY_COLOR(color,alpha) {color,color,color,alpha}

/*
#define TARGET_ALL 0
#define TARGET_PLAYERS 1
#define TARGET_SERVER 2
#define TARGET_HEADLESS 3
#define TARGET_CLIENTS 4
//#define TARGET_LOCAL -1
*/

#define TYPE_SLIDER 0
#define TYPE_COMBO 1
#define TYPE_BINARY 2
#define TYPE_LIST 3
#define TYPE_EDIT 4

#define TO_STRING(NAME_OF) #NAME_OF


#define UNLOAD_LIST_VAR_STR "KISKA_paramsMenu_unloadVars"
#define MISSION_UNLOAD_LIST_VAR_STR "KISKA_paramsMenu_missionUnloadVars"
#define PARAMS_MENU_DISPLAY_VAR_STR "KISKA_paramsMenu_display"
#define PARAMS_MENU_MAIN_CONTROL_GROUP_VAR_STR "KISKA_paramsMenu_mainControlsGroup"
#define PARAMS_MENU_MAIN_GROUP_YPOS_VAR_STR "KISKA_paramsMenu_bottom_Y_pos"


#define GET_PARAMS_MENU_DISPLAY localNamespace getVariable [PARAMS_MENU_DISPLAY_VAR_STR,displayNull]
#define GET_PARAMS_MENU_MAIN_GROUP (GET_PARAMS_MENU_DISPLAY) getVariable [PARAMS_MENU_MAIN_CONTROL_GROUP_VAR_STR,controlNull]

#define STAGED_CHANGE_VAR_HASH_VAR_STR "KISKA_paramsMenu_stagedVarsHash"
#define GET_STAGED_CHANGE_PARAMS_HASH localNamespace getVariable [STAGED_CHANGE_VAR_HASH_VAR_STR,createHashMap]

#define PARAMS_CONFIG_CATEGORIES_VAR_STR "KISKA_missionParams_categoryConfigs"
#define GET_PARAMS_CATEGORY_CONFIGS localNamespace getVariable [PARAMS_CONFIG_CATEGORIES_VAR_STR,[]]

#define PARAMS_CONFIG_FULL_VAR_STR "KISKA_missionParams_configs"
#define GET_PARAM_CONFIGS_FULL localNamespace getVariable [PARAMS_CONFIG_FULL_VAR_STR,[]]

#define PARAMS_VAR_NAMES_CONFIG_HASH_VAR_STR "KISKA_missionParams_configVarNamesHash"
#define GET_PARAMS_VAR_NAMES_CONFIG_HASH localNamespace getVariable [PARAMS_VAR_NAMES_CONFIG_HASH_VAR_STR,createHashmap]

#define ARE_PARAMS_CACHED_VAR_STR "KISKA_missionParams_configsCached"
#define GET_ARE_PARAMS_CACHED localNamespace getVariable [ARE_PARAMS_CACHED_VAR_STR,false]

#define PARAMS_PROFILES_VAR_STR "KISKA_missionParams_savedProfiles"

#define CTRL_GRP_PARAM_CONFIG_VAR_STR "KISKA_paramsMenu_paramConfig"
#define CTRL_GRP_PARAM_VAR_STR "KISKA_paramsMenu_paramVarName"

#define SLIDER_CTRL_INCRIMENT_VAR_STR "KISKA_paramsMenu_sliderIncriment"

#define MESSAGE_BOX_CTRL_VAR_STR "KISKA_paramsMenu_messageBoxCtrl"
#define MESSAGE_BOX_CURRENT_ENTRIES_VAR_STR "KISKA_paramsMenu_messageBox_entries"

#define LIST_ARRAY_VAR_STR "KISKA_paramsMenu_listArray"
#define LIST_USE_VALUES_VAR_STR "KISKA_paramsMenu_listUsesValues"
#define LIST_SELECTED_INDEX_VAR_STR "KISKA_paramsMenu_listSelectedIndex"
#define LIST_DEFAULT_INDEX_VAR_STR "KISKA_paramsMenu_listDefaultIndex"


#define COLOR_YELLOW [1,1,0.23,1]
#define COLOR_WHITE [1,1,1,1]
#define COLOR_GREEN [0.22,1,0.16,1]


#define VERTICAL_SPACE_BETWEEN_CONTROLS POS_H(2)

#define JIP_QUEUE_PREFIX "KISKA_MPM"

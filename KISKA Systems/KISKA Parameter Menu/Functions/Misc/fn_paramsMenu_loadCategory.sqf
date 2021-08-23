#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_loadCategory

Description:
    Populates the list of param menu options for a given config category.

Parameters:
	0: _categoryConfig : <CONFIG> - The config path of category to load
    1: _paramsMenuDisplay : <DISPLAY> - The display of the param menu

Returns:
	NOTHING

Examples:
    (begin example)
        [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory"
        ] call KISKA_fnc_paramsMenu_loadCategory;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_loadCategory";

disableSerialization;

params [
    ["_categoryConfig",configNull,[configNull]],
    ["_paramsMenuDisplay",localNamespace getVariable ["KISKA_paramsMenu_display",displayNull],[displayNull]]
];

if (isNull _categoryConfig) exitWith {
    ["A null config was passed",true] call KISKA_fnc_log;
    nil
};


// delete controls from previously selected category
allControls (_paramsMenuDisplay getVariable [PARAMS_MENU_MAIN_CONTROL_GROUP_VAR_STR,controlNull]) apply {
    ctrlDelete _x;
};

// reset vertical position for new category
localNamespace setVariable [PARAMS_MENU_MAIN_GROUP_YPOS_VAR_STR, 0];

private _paramsInConfig = "true" configClasses _categoryConfig;
_paramsInConfig apply {
    [_x] call KISKA_fnc_paramsMenu_addParam;
};


nil

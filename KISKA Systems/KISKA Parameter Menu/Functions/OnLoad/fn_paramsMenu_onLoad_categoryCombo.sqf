#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_onLoad_categoryCombo

Description:
	Initializes the category list in the params menu with filling the entries
     and providing the functionality through eventhandlers.

Parameters:
	0: _paramsMenuDisplay : <DISPLAY> - The display of the param menu

Returns:
	NOTHING

Examples:
    (begin example)
		[localNamespace getVariable ["KISKA_paramsMenu_display",displayNull]] call KISKA_fnc_paramsMenu_onLoad_populateCategoryCombo;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_onLoad_categoryCombo";

disableSerialization;

params [
    ["_paramsMenuDisplay",localNamespace getVariable ["KISKA_paramsMenu_display",displayNull],[displayNull]]
];
private _categoryCombo_ctrl = _paramsMenuDisplay displayCtrl PARAMS_MENU_CATEGORY_COMBO_IDC;

/* ----------------------------------------------------------------------------
    Selection Event Handler
---------------------------------------------------------------------------- */
_categoryCombo_ctrl ctrlAddEventHandler ["LBSelChanged",{
    params ["_control", "_selectedIndex"];

    private _categoryIndex = _control lbValue _selectedIndex;
    private _categoryConfig = (GET_PARAMS_CATEGORY_CONFIGS) select _categoryIndex;
    [_categoryConfig] call KISKA_fnc_paramsMenu_loadCategory;
}];


/* ----------------------------------------------------------------------------
    Populate list
---------------------------------------------------------------------------- */
private _index = 0;
{
    private _title = getText (_x >> "title");
    _index = _categoryCombo_ctrl lbAdd (_title);
    // save config class array index
    _categoryCombo_ctrl lbSetValue [_index,_forEachIndex];
} forEach (GET_PARAMS_CATEGORY_CONFIGS);

// NOTE..........................seems to cause combo box entries to become invisible when not already in order
lbSort _categoryCombo_ctrl;

_categoryCombo_ctrl lbSetCurSel 0;


nil

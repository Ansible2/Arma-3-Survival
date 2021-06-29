#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_refresh

Description:
    Reloads the current category controls of the params menu

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
        call KISKA_fnc_paramsMenu_refresh
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_refresh";

private _display = localNamespace getVariable [PARAMS_MENU_DISPLAY_VAR_STR,displayNull];
if (isNull _display) exitWith {};

private _categoryCombo_ctrl = _display displayCtrl PARAMS_MENU_CATEGORY_COMBO_IDC;

private _categoryIndex = _categoryCombo_ctrl lbValue (lbCurSel _categoryCombo_ctrl);

private _categoryConfig = (GET_PARAMS_CATEGORY_CONFIGS) select _categoryIndex;

[_categoryConfig] call KISKA_fnc_paramsMenu_loadCategory;


nil

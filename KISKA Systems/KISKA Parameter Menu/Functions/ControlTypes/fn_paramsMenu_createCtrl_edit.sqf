#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_createCtrl_edit

Description:
    Creates an edit box controls group and adds it to the main params controls group.

Parameters:
	0: _paramConfig : <CONFIG> - The config path of param to add to the params control group

Returns:
	NOTHING

Examples:
    (begin example)
        [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam"
        ] call KISKA_fnc_paramsMenu_createCtrl_edit;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_createCtrl_edit";

#define CONTROL_CLASS TO_STRING(PARAMS_MENU_CTRLGRP(editBox))

disableSerialization;

params [
    ["_paramConfig",configNull,[configNull]]
];

/* ----------------------------------------------------------------------------
    Prepare generic properties
---------------------------------------------------------------------------- */
private _paramControlGroup = [_paramConfig,CONTROL_CLASS] call KISKA_fnc_paramsMenu_createCtrlOfClass;

/* ----------------------------------------------------------------------------
    Get Current Value and set
---------------------------------------------------------------------------- */
private _editBox_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SETTING_CTRL_IDC;
private _currentValue = [_paramConfig] call KISKA_fnc_paramsMenu_getCurrentParamValue;
_editBox_ctrl ctrlSetText _currentValue;

/* ----------------------------------------------------------------------------
    Add Events
---------------------------------------------------------------------------- */
_editBox_ctrl ctrlAddEventHandler ["KeyUp",{
    params ["_control"];
    [_control,ctrlText _control] call KISKA_fnc_paramsMenu_setParamValue;
}];

/* ----------------------------------------------------------------------------
    Default Button
---------------------------------------------------------------------------- */
private _defaultValue = [_paramConfig] call KISKA_fnc_paramsMenu_getDefaultParamValue;
private _defaultButton_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_DEFAULT_BUTTON_IDC;
_defaultButton_ctrl ctrlSetTooltip ("Return to Default: \n" + ([_defaultValue] call KISKA_fnc_str));

_defaultButton_ctrl ctrlAddEventHandler ["ButtonClick",{
    params ["_defaultButton_ctrl"];

    private _paramControlGroup = ctrlParentControlsGroup _defaultButton_ctrl;
    private _edit_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SETTING_CTRL_IDC;
    private _paramConfig = _paramControlGroup getVariable CTRL_GRP_PARAM_CONFIG_VAR_STR;
    private _defaultText = [_paramConfig] call KISKA_fnc_paramsMenu_getDefaultParamValue;

    _edit_ctrl ctrlSetText _defaultText;
    [_edit_ctrl,_defaultText] call KISKA_fnc_paramsMenu_setParamValue;
}];


nil

#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_createCtrl_binary

Description:
    Creates a binary controls group and adds it to the main params controls group.

Parameters:
	0: _paramConfig : <CONFIG> - The config path of param to add to the params control group

Returns:
	<CONTROl> - Returns the created controls group for the param

Examples:
    (begin example)
        [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam"
        ] call KISKA_fnc_paramsMenu_createCtrl_binary;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_createCtrl_binary";

disableSerialization;

params [
    ["_paramConfig",configNull,[configNull]]
];

/* ----------------------------------------------------------------------------
    Prepare generic properties
---------------------------------------------------------------------------- */
private _paramControlGroup = [_paramConfig,TO_STRING(PARAMS_MENU_CTRLGRP(binary))] call KISKA_fnc_paramsMenu_createCtrlOfClass;

/* ----------------------------------------------------------------------------
    Get Current Value and set
---------------------------------------------------------------------------- */
private _toolBox_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SETTING_CTRL_IDC;
_toolBox_ctrl lbSetText [0,getText(_paramConfig >> "textFalse")];
_toolBox_ctrl lbSetText [1,getText(_paramConfig >> "textTrue")];
private _currentValue = [_paramConfig] call KISKA_fnc_paramsMenu_getCurrentParamValue;
_toolBox_ctrl lbSetCurSel ([0,1] select _currentValue); // translate bool to index

/* ----------------------------------------------------------------------------
    Add Events
---------------------------------------------------------------------------- */
_toolBox_ctrl ctrlAddEventHandler ["ToolBoxSelChanged",{
    _this call KISKA_fnc_paramsMenu_setParamValue;
}];


/* ----------------------------------------------------------------------------
    Default Button
---------------------------------------------------------------------------- */
private _defaultValue = [_paramConfig] call KISKA_fnc_paramsMenu_getDefaultParamValue;
private _defaultButton_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_DEFAULT_BUTTON_IDC;
_defaultButton_ctrl ctrlSetTooltip ("Return to Default: \n" + ([_defaultValue] call KISKA_fnc_str));

_defaultButton_ctrl ctrlAddEventHandler ["ButtonClick",{
    params ["_control"];

    private _paramControlGroup = ctrlParentControlsGroup _control;
    private _paramConfig = _paramControlGroup getVariable CTRL_GRP_PARAM_CONFIG_VAR_STR;
    private _defaultValue = [_paramConfig] call KISKA_fnc_paramsMenu_getDefaultParamValue;

    private _binary_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SETTING_CTRL_IDC;
    _binary_ctrl lbSetCurSel ([0,1] select _defaultValue);
    [_binary_ctrl,_defaultValue] call KISKA_fnc_paramsMenu_setParamValue;

}];

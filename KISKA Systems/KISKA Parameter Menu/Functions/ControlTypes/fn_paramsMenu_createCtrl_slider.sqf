#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_createCtrl_slider

Description:
    Creates a slider controls group and adds it to the main params controls group.

Parameters:
	0: _paramConfig : <CONFIG> - The config path of param to add to the params control group

Returns:
	NOTHING

Examples:
    (begin example)
        [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam"
        ] call KISKA_fnc_paramsMenu_createCtrl_slider;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_createCtrl_slider";

#define CONTROL_CLASS TO_STRING(PARAMS_MENU_CTRLGRP(slider))

disableSerialization;

params [
    ["_paramConfig",configNull,[configNull]]
];

if (isNull _paramConfig) exitWith {
    ["A null config was passed",true] call KISKA_fnc_log;
    nil
};

/* ----------------------------------------------------------------------------
    Prepare generic properties
---------------------------------------------------------------------------- */
private _paramControlGroup = [_paramConfig,CONTROL_CLASS] call KISKA_fnc_paramsMenu_createCtrlOfClass;

/* ----------------------------------------------------------------------------
    Get Current Value and set
---------------------------------------------------------------------------- */
private _slider_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SETTING_CTRL_IDC;

_slider_ctrl sliderSetRange [
    getNumber(_paramConfig >> "min"),
    getNumber(_paramConfig >> "max")
];

// sliderSetSpeed does not work on ctXsliders, so we save the incriment for use with KISKA_fnc_getNearestIncriment
private _sliderIncriment = abs (getNumber(_paramConfig >> "incriment"));
_slider_ctrl sliderSetSpeed [_sliderIncriment,_sliderIncriment];
_slider_ctrl setVariable [SLIDER_CTRL_INCRIMENT_VAR_STR,_sliderIncriment];

private _currentValue = [_paramConfig] call KISKA_fnc_paramsMenu_getCurrentParamValue;
_slider_ctrl sliderSetPosition _currentValue;

private _currentValue_str = str _currentValue;
_slider_ctrl ctrlSetTooltip _currentValue_str;
private _editBox_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SECONDARY_SETTING_CTRL_IDC;
_editBox_ctrl ctrlSetText _currentValue_str;

/* ----------------------------------------------------------------------------
    Add Events
---------------------------------------------------------------------------- */
_slider_ctrl ctrlAddEventHandler ["SliderPosChanged",{
    params ["_slider_ctrl", "_newValue"];

    private _sliderIncriment = _slider_ctrl getVariable SLIDER_CTRL_INCRIMENT_VAR_STR;
    _newValue = [
        _newValue,
        _sliderIncriment
    ] call KISKA_fnc_getNearestIncriment;
    _slider_ctrl sliderSetPosition _newValue;

    // update edit box
    private _editBoxControl = (ctrlParentControlsGroup _slider_ctrl) controlsGroupCtrl PARAM_MENU_ROW_SECONDARY_SETTING_CTRL_IDC;
    private _newValueStr = str _newValue;
    _editBoxControl ctrlSetText _newValueStr;
    _slider_ctrl ctrlSetTooltip _newValueStr;

    [_slider_ctrl,_newValue] call KISKA_fnc_paramsMenu_setParamValue;

}];

_editBox_ctrl ctrlAddEventHandler ["KeyUp",{
    params ["_editBoxControl"];

    private _text = ctrlText _editBoxControl;
    private _number = _text call BIS_fnc_parseNumberSafe;
    // if we don't check that an actual number is present, we can't start with a blank edit box if say doing negative numbers
    if (str _number == _text) then {
        private _paramControlGroup = ctrlParentControlsGroup _editBoxControl;
        private _slider_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SETTING_CTRL_IDC;
        private _sliderIncriment = _slider_ctrl getVariable SLIDER_CTRL_INCRIMENT_VAR_STR;

        private _sliderRange = sliderRange _slider_ctrl;
        private _sliderMin = _sliderRange select 0;
        private _sliderMax = _sliderRange select 1;
        // check to see if entered number fits inside slider range
        if ((_number >= _sliderMin) AND {_number <= _sliderMax}) then {
            private _numberChecked = [
                _number,
                _sliderIncriment
            ] call KISKA_fnc_getNearestIncriment;

            // check to see if it is a valid number before saving and adjusting slider
            if (_number isEqualTo _numberChecked) then {
                _slider_ctrl ctrlSetTooltip (str _numberChecked);
                _slider_ctrl sliderSetPosition _numberChecked;
                [_slider_ctrl,_numberChecked] call KISKA_fnc_paramsMenu_setParamValue;
            };
        };
    };
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

    private _slider_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SETTING_CTRL_IDC;
    _slider_ctrl sliderSetPosition _defaultValue;

    private _defaultString = str _defaultValue;
    private _edit_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SECONDARY_SETTING_CTRL_IDC;
    _edit_ctrl ctrlSetText _defaultString;
    _slider_ctrl ctrlSetTooltip _defaultString;

    [_slider_ctrl,_defaultValue] call KISKA_fnc_paramsMenu_setParamValue;

}];




nil

#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_setParamValue

Description:
    Interprets a control's change event into the actual new value of the
     corresponding parameter.

Parameters:
	0: _control : <CONTROL> - The control that the value is changed on.
    1: _value : <STRING, NUMBER, or ARRAY> - The new "value" that is passed by the control's change event

Returns:
	NOTHING

Examples:
    (begin example)
        [
            _control,
            _newValue
        ] call KISKA_fnc_paramsMenu_setParamValue;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_setParamValue";

params ["_control","_value"];

private _parentControlGroup = ctrlParentControlsGroup _control;
private _paramConfig = _parentControlGroup getVariable CTRL_GRP_PARAM_CONFIG_VAR_STR;
private _currentPublicValue = [_paramConfig,false] call KISKA_fnc_paramsMenu_getCurrentParamValue;
private _paramTitle_ctrl = _parentControlGroup controlsGroupCtrl PARAM_MENU_ROW_TITLE_IDC;

if ([_paramConfig >> "isBool"] call BIS_fnc_getCfgDataBool) then {
    _value = [false,true] select _value;
};

if (_value isNotEqualTo _currentPublicValue) then {
    [_paramConfig,_value] call KISKA_fnc_paramsMenu_addToChangedParamHash;
    _paramTitle_ctrl ctrlSetTextColor COLOR_YELLOW;

} else {
    (GET_STAGED_CHANGE_PARAMS_HASH) deleteAt _paramConfig;
    _paramTitle_ctrl ctrlSetTextColor COLOR_WHITE;

};


nil

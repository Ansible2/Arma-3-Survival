#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_createCtrl_list

Description:
    Creates a listbox controls group and adds it to the main params controls group.

Parameters:
	0: _paramConfig : <CONFIG> - The config path of param to add to the params control group
    1: _isComboBox : <BOOL> - false to create listbox, true for combo box

Returns:
	NOTHING

Examples:
    (begin example)
        [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam"
        ] call KISKA_fnc_paramsMenu_createCtrl_list;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_createCtrl_list";

disableSerialization;

params [
    ["_paramConfig",configNull,[configNull]],
    ["_isComboBox",true,[false]]
];


/* ----------------------------------------------------------------------------
    Verify configuration
---------------------------------------------------------------------------- */
private _listArray = [];
private _useValues = false;
private _populationScript = getText(_paramConfig >> "populationScript");

if (_populationScript isNotEqualTo "") then {
    _popList = call (compileFinal _populationScript);
    if ((_popList select 0) isEqualType []) then {
        _useValues = true;
    };

    _listArray = _popList;

} else {
    private _stringsList = getArray(_paramConfig >> "texts");
    private _valuesList = getArray(_paramConfig >> "values");

    if (_valuesList isNotEqualTo []) then {
        // using this method so that the array can be potentially sorted later on
        _useValues = true;
        {
            _listArray pushBack [_x,_valuesList select _forEachindex];
        } forEach _stringsList;

    } else {
        _listArray = _stringsList;

    };
};


if (_listArray isEqualTo [] OR {!(_listArray isEqualType [])}) exitWith {
    [[_paramConfig," returned no list entries!"],true] call KISKA_fnc_log;
    nil
};

if ([_paramConfig >> "sortList"] call BIS_fnc_getCfgDataBool) then {
    _listArray sort true;
};


/* ----------------------------------------------------------------------------
    Prepare generic properties
---------------------------------------------------------------------------- */
private _controlClass = [TO_STRING(PARAMS_MENU_CTRLGRP(listBox)),TO_STRING(PARAMS_MENU_CTRLGRP(comboList))] select _isComboBox;
private _paramControlGroup = [_paramConfig,_controlClass] call KISKA_fnc_paramsMenu_createCtrlOfClass;


/* ----------------------------------------------------------------------------
    Get Current Value and set
---------------------------------------------------------------------------- */
private _list_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SETTING_CTRL_IDC;
_list_ctrl setVariable [LIST_USE_VALUES_VAR_STR,_useValues];

private _currentValue = [_paramConfig] call KISKA_fnc_paramsMenu_getCurrentParamValue;
private _defaultValue = [_paramConfig] call KISKA_fnc_paramsMenu_getDefaultParamValue;
private _indexOfCurrent = 0;
private _indexOfDefault = 0;
private _defaultString = "";

if (_useValues) then {
    private _lbValue = -1;

    {
        _list_ctrl lbAdd (_x select 0);
        _lbValue = _x select 1;
        _list_ctrl lbSetTooltip [_forEachIndex, str _lbValue];
        _list_ctrl lbSetValue [_forEachIndex, _lbValue];

        if (_lbValue isEqualTo _currentValue) then {
            _indexOfCurrent = _forEachIndex;
        };
        if (_lbValue isEqualTo _defaultValue) then {
            _indexOfDefault = _forEachIndex;
            _defaultString = (_x select 0);
        };
    } forEach _listArray;

} else {
    {
        _list_ctrl lbAdd _x;
        _list_ctrl lbSetTooltip [_forEachIndex,_x];

        if (_x isEqualTo _currentValue) then {
            _indexOfCurrent = _forEachIndex;
        };
        if (_x isEqualTo _defaultValue) then {
            _indexOfDefault = _forEachIndex;

            _defaultString = _x;
        };

    } forEach _listArray;

};

_list_ctrl setVariable [LIST_DEFAULT_INDEX_VAR_STR,_indexOfDefault];

private _defaultButton_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_DEFAULT_BUTTON_IDC;
_defaultButton_ctrl ctrlSetTooltip ("Return to Default: \n" + _defaultString);


/* ----------------------------------------------------------------------------
    Type adjustments
---------------------------------------------------------------------------- */
if (_isComboBox) then {
    _list_ctrl lbSetCurSel _indexOfCurrent;

    _list_ctrl ctrlAddEventHandler ["LBSelChanged",{
        params ["_control", "_selectedIndex"];

        [_control,_selectedIndex] call KISKA_fnc_paramsMenu_updateSelection_comboBox;

    }];

    _defaultButton_ctrl ctrlAddEventHandler ["ButtonClick",{
        params ["_control"];

        private _paramControlGroup = ctrlParentControlsGroup _control;
        private _combo_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SETTING_CTRL_IDC;
        private _indexOfDefault = _combo_ctrl getVariable [LIST_DEFAULT_INDEX_VAR_STR,0];
        _combo_ctrl lbSetCurSel _indexOfDefault;

    }];


} else {
    _list_ctrl lbSetColor [_indexOfCurrent, COLOR_GREEN];
    _list_ctrl lbSetSelectColor [_indexOfCurrent,COLOR_GREEN];
    _list_ctrl setVariable [LIST_SELECTED_INDEX_VAR_STR,_indexOfCurrent];

    _list_ctrl ctrlAddEventHandler ["LBDblClick",{
        _this call KISKA_fnc_paramsMenu_updateSelection_listbox;
    }];

    _defaultButton_ctrl ctrlAddEventHandler ["ButtonClick",{
        params ["_control"];

        private _paramControlGroup = ctrlParentControlsGroup _control;
        private _list_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_SETTING_CTRL_IDC;
        private _indexOfDefault = _list_ctrl getVariable [LIST_DEFAULT_INDEX_VAR_STR,0];
        [_list_ctrl,_indexOfDefault] call KISKA_fnc_paramsMenu_updateSelection_listbox;
    }];


};


nil

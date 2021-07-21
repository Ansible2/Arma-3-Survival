#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_createCtrlOfClass

Description:
    Creates and returns a control group of the specified class.
    Saves several variables to the control group's namepsace.
    Fills the title text and tooltip of the param.
    Sets the position within the main control group list.

Parameters:
	0: _paramConfig : <CONFIG> - The config path of param to add to the params control group
    1: _controlClass : <CONTROL> - The class name of the conrtol to create

Returns:
	<CONTROl> - Returns the created controls group

Examples:
    (begin example)
        [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam",
            "someControlClassName"
        ] call KISKA_fnc_paramsMenu_createCtrlOfClass
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_createCtrlOfClass";

disableSerialization;

params [
    ["_paramConfig",configNull,[configNull]],
    ["_controlClass","",[""]]
];

if (isNull _paramConfig) exitWith {
    ["A null config was passed",true] call KISKA_fnc_log;
    nil
};

/* ----------------------------------------------------------------------------
    Create Param Control Group
---------------------------------------------------------------------------- */
private _paramsMenuDisplay = GET_PARAMS_MENU_DISPLAY;
private _mainControlsGroup = _paramsMenuDisplay getVariable [PARAMS_MENU_MAIN_CONTROL_GROUP_VAR_STR,controlNull];

private _paramControlGroup = _paramsMenuDisplay ctrlCreate [_controlClass,-1,_mainControlsGroup];
//OPTIMIZE check if this is even used
_paramControlGroup setVariable [CTRL_GRP_PARAM_CONFIG_VAR_STR,_paramConfig];

[_paramControlGroup] call KISKA_fnc_paramsMenu_setNewYPos;


/* ----------------------------------------------------------------------------
    Save global variable name
---------------------------------------------------------------------------- */
private _paramVarName = [_paramConfig] call KISKA_fnc_paramsMenu_getParamVarName;
// OPTIMIZE check if this variable is used
_paramControlGroup setVariable [CTRL_GRP_PARAM_VAR_STR,_paramVarName];


/* ----------------------------------------------------------------------------
    Fill in param title text and tooltip
---------------------------------------------------------------------------- */
private _paramTitle_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_TITLE_IDC;
_paramTitle_ctrl ctrlSetText (getText(_paramConfig >> "title"));

private _joinStringArray = [];
private _configToolTipText = getText(_paramConfig >> "tooltip");
if (_configToolTipText isNotEqualTo "") then {
    _joinStringArray pushBack _configToolTipText;
};

// OPTIMIZE check if restart bool should be cached and also use when broadcasting to see if it is worth broadcasting a change that won't even take affect
private _requiresRestart = [_paramConfig >> "requiresRestart"] call BIS_fnc_getCfgDataBool;
_joinStringArray pushBack ("Requires Restart: " + (["No","Yes"] select _requiresRestart));

_joinStringArray pushBack ("Variable Name: " + _paramVarName);

private _namespaceNumber = getNumber(_paramConfig >> "namespace");
_joinStringArray pushBack ("Saved To: " + (["missionNamespace","localNamespace"] select _namespaceNumber));

private _paramTooltTip = _joinStringArray joinString "\n";
_paramTitle_ctrl ctrlSetTooltip _paramTooltTip;

if (_paramConfig in (GET_STAGED_CHANGE_PARAMS_HASH)) then {
    _paramTitle_ctrl ctrlSetTextColor COLOR_YELLOW;
};


_paramControlGroup

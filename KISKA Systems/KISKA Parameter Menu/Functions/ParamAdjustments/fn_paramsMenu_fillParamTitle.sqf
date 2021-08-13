#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_fillParamTitle

Description:
    Populates a param control group's title control and tooltip from the given config.

    Also sets the title color to yellow if the parameter is staged for changes

Parameters:
	0: _paramConfig : <CONFIG> - The config path of param to add to the params control group
    1: _paramControlGroup : <CONTROL> - The control of the group to link

Returns:
	<STRING> - The control of the title in the control group of the param

Examples:
    (begin example)
        [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam",
            groupControl
        ] call KISKA_fnc_paramsMenu_fillParamTitle
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_fillParamTitle";

params [
    ["_paramConfig",configNull,[configNull]],
    ["_paramControlGroup",controlNull,[controlNull]]
];

private _paramTitle_ctrl = _paramControlGroup controlsGroupCtrl PARAM_MENU_ROW_TITLE_IDC;
_paramTitle_ctrl ctrlSetText (getText(_paramConfig >> "title"));
private _paramTooltTip = [getText(_paramConfig >> "tooltip"),_paramVarName] joinString "\n";
_paramTitle_ctrl ctrlSetTooltip _paramTooltTip;

if (_paramConfig in (GET_STAGED_CHANGE_PARAMS_HASH)) then {
    _paramTitle_ctrl ctrlSetTextColor COLOR_YELLOW;
};


_paramTitle_ctrl

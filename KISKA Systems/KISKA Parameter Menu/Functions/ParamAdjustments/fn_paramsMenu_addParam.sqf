#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_addParam

Description:
    Adds a param to the params controls group.

Parameters:
	0: _paramConfig : <CONFIG> - The config path of param to add to the params control group

Returns:
	NOTHING

Examples:
    (begin example)
        [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam"
        ] call KISKA_fnc_paramsMenu_addParam;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_addParam";

params [
    ["_paramConfig",configNull,[configNull]]
];

if (isNull _paramConfig) exitWith {
    ["A null config was passed",true] call KISKA_fnc_log;
    nil
};

private _paramType = getNumber(_paramConfig >> "type");
switch (_paramType) do {

    case TYPE_SLIDER: {
        [_paramConfig] call KISKA_fnc_paramsMenu_createCtrl_slider;
    };

    case TYPE_COMBO: {
        [_paramConfig,true] call KISKA_fnc_paramsMenu_createCtrl_list;
    };

    case TYPE_BINARY: {
        [_paramConfig] call KISKA_fnc_paramsMenu_createCtrl_binary;
    };

    case TYPE_LIST: {
        [_paramConfig,false] call KISKA_fnc_paramsMenu_createCtrl_list;
    };

    case TYPE_EDIT: {
        [_paramConfig] call KISKA_fnc_paramsMenu_createCtrl_edit;
    };

};



nil

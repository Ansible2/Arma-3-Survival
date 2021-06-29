/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_getDefaultParamValue

Description:
    Gets the configed default value of a param.

Parameters:
	0: _paramConfig : <CONFIG> - The config path of param to get the default value of

Returns:
	<NUMBER, STRING, or BOOL> - The default config value

Examples:
    (begin example)
        _default = [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam"
        ] call KISKA_fnc_paramsMenu_getDefaultParamValue;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_getDefaultParamValue";

params [
    ["_paramConfig",configNull,[configNull]]
];


if !([_paramConfig >> "isBool"] call BIS_fnc_getCfgDataBool) exitWith {
    [_paramConfig >> "default"] call BIS_fnc_getCfgData;
};


[_paramConfig >> "default"] call BIS_fnc_getCfgDataBool;

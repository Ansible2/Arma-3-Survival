/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_getParamNamespace

Description:
    Gets the configned namespace of a param

Parameters:
	0: _paramConfig : <CONFIG> - The config path of the param

Returns:
	<NAMESPACE> - the namespace

Examples:
    (begin example)
        _namespace = [
            missionConfigFile >> "KISKA_missionParams" >> "someCategory" >> "someParam"
        ] call KISKA_fnc_paramsMenu_getParamNamespace
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_getParamNamespace";

params [
    ["_paramConfig",configNull,[configNull]]
];

if (isNull _paramConfig) exitWith {
    ["A null config was passed",true] call KISKA_fnc_log;
    nil
};


private _namespace = [missionNamespace,localNamespace] select (getNumber(_paramConfig >> "namespace"));


_namespace

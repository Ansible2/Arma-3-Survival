#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_hashParams

Description:
    Creates a hashmap of all the current params in a mission.

    Staged changes will be saved.

Parameters:
    NONE

Returns:
	<HASHMAP> - A hash of all the saved params

Examples:
    (begin example)
        _hashmapOfParams = call KISKA_fnc_paramsMenu_hashParams;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_hashParams";

private _hashMap = createHashMap;

private _paramName = "";
private "_currentParamValue";
(GET_PARAM_CONFIGS_FULL) apply {
    _paramName = [_x] call KISKA_fnc_paramsMenu_getParamVarName;
    _currentParamValue = [_x] call KISKA_fnc_paramsMenu_getCurrentParamValue;
    _hashMap set [_paramName,_currentParamValue];
};


_hashMap

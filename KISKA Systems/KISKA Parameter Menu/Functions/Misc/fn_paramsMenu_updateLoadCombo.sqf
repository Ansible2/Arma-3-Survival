#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_updateLoadCombo

Description:
	Updates the drop down list of loadable playlists

Parameters:
	0: _loadCombo_ctrl : <CONTROL> - The control of the combobox
  	1: _goToIndex : <NUMBER> - What index should the load combo be set to after updating

Returns:
	NOTHING

Examples:
    (begin example)
		[control,0] spawn KISKA_fnc_paramsMenu_updateLoadCombo;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_updateLoadCombo";

if (!canSuspend) exitWith {
	["Needs to be run in scheduled, now running in scheduled",true] call KISKA_fnc_log;
	_this spawn KISKA_fnc_paramsMenu_updateLoadCombo;
};

disableSerialization;

params [
	["_loadCombo_ctrl",controlNull,[controlNull]],
	["_goToIndex",0,[123]]
];


private _savedProfilesHashMap = profilenamespace getVariable [PARAMS_PROFILES_VAR_STR,[]];

// if we are deleteing, the profile array may be empty, but we still need the list empty regardless
lbClear _loadCombo_ctrl;

if (_savedProfilesHashMap isNotEqualTo []) then {
    {
        _loadCombo_ctrl lbAdd _x;
    } forEach (keys _savedProfilesHashMap);
};

lbSort _loadCombo_ctrl;
_loadCombo_ctrl lbSetCurSel _goToIndex;


nil

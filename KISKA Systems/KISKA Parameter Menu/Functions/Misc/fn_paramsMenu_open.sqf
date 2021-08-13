#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_open

Description:
    Opens and inits the KISKA params menu.

Parameters:
    NONE

Returns:
	NOTHING

Examples:
    (begin example)
        [] spawn KISKA_fnc_paramsMenu_open;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_open";

if (!hasInterface) exitWith {};

if !(call KISKA_fnc_isAdminOrHost) exitWith {
    hint "You must be an admin or host to edit mission settings";
    nil
};

// indication bar?
if (!canSuspend) exitWith {
    [] spawn KISKA_fnc_paramsMenu_open;
};

disableSerialization;

openMap false;


private _parentDisplayIDD = 46;
if !(localNamespace getVariable ["KISKA_missionParams_preloadFinished",false]) then {
    _parentDisplayIDD = call KISKA_fnc_paramsMenu_getBriefingIDD;;
};

waitUntil {!isNull (findDisplay _parentDisplayIDD)};


private _display = (findDisplay _parentDisplayIDD) createDisplay "paramsMenu";
localNamespace setVariable [PARAMS_MENU_DISPLAY_VAR_STR,_display];
_display displayAddEventHandler ["Unload",{
    localNamespace setVariable [PARAMS_MENU_DISPLAY_VAR_STR,nil];
}];


_display setVariable [MESSAGE_BOX_CTRL_VAR_STR,_display displayCtrl PARAMS_MENU_MESSAGE_BOX_IDC];

private _controlsGroup = _display displayCtrl PARAMS_MENU_MAIN_CONTROL_GROUP_IDC;
_display setVariable [PARAMS_MENU_MAIN_CONTROL_GROUP_VAR_STR,_controlsGroup];


call KISKA_fnc_paramsMenu_cacheConfig;


if (isNil{localNamespace getVariable PARAMS_CURRENT_PROFILE_VAR_STR}) then {
    private _profileVarName = getText(missionConfigFile >> "KISKA_missionParams" >> "ProfileVarName");
    if (_profileVarName isEqualTo "") then {
        _profileVarName = PARAMS_DEFAULT_PROFILES_VAR_STR;
    };

    localNamespace setVariable [PARAMS_CURRENT_PROFILE_VAR_STR,_profileVarName];
};


[_display] call KISKA_fnc_paramsMenu_onLoad_categoryCombo;

[_display] call KISKA_fnc_paramsMenu_onLoad_saveAndLoadControls;

[_display] call KISKA_fnc_paramsMenu_onLoad_portControls;

(_display displayCtrl PARAMS_MENU_COMMIT_BUTTON_IDC) ctrlAddEventHandler ["ButtonClick",{
    call KISKA_fnc_paramsMenu_commitChanges;

    [] spawn {
        disableUserInput true;
        for "_i" from 1 to 5 do {
            ["Please wait..."] call KISKA_fnc_paramsMenu_logMessage;
            uisleep 1; // if in briefing menu, regular sleep is frozen
        };

        waitUntil {
            disableUserInput false;
            !userInputDisabled;
        };

        call KISKA_fnc_paramsMenu_refresh;
        ["Transmission Complete"] call KISKA_fnc_paramsMenu_logMessage;
    };

}];

(_display displayCtrl PARAMS_MENU_CLOSE_BUTTON_IDC) ctrlAddEventHandler ["ButtonClick",{
    params ["_control"];
    (ctrlParent _control) closeDisplay 2
}];


nil

#include "..\..\Headers\params menu common defines.hpp"

// requires restart indication
// indication bar?

if (!canSuspend) exitWith {
    [] spawn KISKA_fnc_paramsMenu_open;
};

disableSerialization;
/*
openMap true;

sleep 1;

// diable map pointer
((findDisplay 12) displayCtrl 51) ctrlEnable false;
*/

private _parentDisplay = -1;
if (localNamespace getVariable ["KISKA_missionParams_preloadFinished",false]) then {
    _parentDisplay = 46;
} else {
    _parentDisplay = call KISKA_fnc_paramsMenu_getBriefingIDD;;
};

waitUntil {!isNull (findDisplay _parentDisplay)};

private _display = (findDisplay _parentDisplay) createDisplay "paramsMenu";
localNamespace setVariable [PARAMS_MENU_DISPLAY_VAR_STR,_display];
_display displayAddEventHandler ["Unload",{
    localNamespace setVariable [PARAMS_MENU_DISPLAY_VAR_STR,nil];
}];


private _controlsGroup = _display displayCtrl PARAMS_MENU_MAIN_CONTROL_GROUP_IDC;
_display setVariable [PARAMS_MENU_MAIN_CONTROL_GROUP_VAR_STR,_controlsGroup];


call KISKA_fnc_paramsMenu_cacheConfig;


[_display] call KISKA_fnc_paramsMenu_onLoad_categoryCombo;

[_display] call KISKA_fnc_paramsMenu_onLoad_saveAndLoadControls;

[_display] call KISKA_fnc_paramsMenu_onLoad_portControls;

(_display displayCtrl PARAMS_MENU_COMMIT_BUTTON_IDC) ctrlAddEventHandler ["ButtonClick",{
    call KISKA_fnc_paramsMenu_commitChanges;
    call KISKA_fnc_paramsMenu_refresh;
}];

(_display displayCtrl PARAMS_MENU_CLOSE_BUTTON_IDC) ctrlAddEventHandler ["ButtonClick",{
    params ["_control"];
    (ctrlParent _control) closeDisplay 2
}];


nil

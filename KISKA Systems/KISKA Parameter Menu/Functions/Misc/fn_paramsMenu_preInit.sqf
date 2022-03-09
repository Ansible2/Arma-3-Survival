#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_preInit

Description:
    Adds the preload MissionEventHandler and button to open the parameter menu
     during the pre-mission briefing map.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
        PRE-INIT Function
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_preInit";

// PreloadFinished does not work on dedicated server
if (isDedicated) exitWith {};

if (call KISKA_fnc_isMainMenu) exitWith {
    ["Main menu detected, will not init",false] call KISKA_fnc_log;
    nil
};

addMissionEventHandler ["PreloadFinished", {
    call KISKA_fnc_paramsMenu_postPreload;
}];


if (!hasInterface) exitWith {};

// using CBA Grid to align button
#define GUI_GRID_WAbs			((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs			(GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W			(GUI_GRID_WAbs / 40)
#define GUI_GRID_H			(GUI_GRID_HAbs / 25)
#define GUI_GRID_X			(safezoneX)
#define GUI_GRID_Y			(safezoneY + safezoneH - GUI_GRID_HAbs)
#define POS_W_2(N) ((N) * GUI_GRID_W)
#define POS_H_2(N) ((N) * GUI_GRID_H)
#define POS_X_LOW(N) ((N) * GUI_GRID_W + GUI_GRID_X)
#define POS_Y_LOW(N) ((N) * GUI_GRID_H + GUI_GRID_Y)


// add in configue parameter button to briefing menu
[] spawn {
    private _idd = call KISKA_fnc_paramsMenu_getBriefingIDD;
    waitUntil {
        //sleep 0.1;
        if (
            !isNull (findDisplay _idd) OR
            {localNamespace getVariable ["KISKA_missionParams_preloadFinished",false]}
        ) exitWith {true};
        false
    };

    private _control = (findDisplay _idd) ctrlCreate ["RscButtonMenu", -1];
    _control ctrlSetText "Configure Parameters";
    private _xPosition = [POS_X_LOW(11.2),POS_X_LOW(11.2) + POS_W_2(10)] select (["CBA_Settings"] call KISKA_fnc_isPatchLoaded);
    _control ctrlSetPosition [_xPosition, POS_Y_LOW(23), POS_W_2(10), POS_H_2(1)];
    _control ctrlCommit 0.1;

    _control ctrlAddEventHandler ["ButtonClick",{
        if (isNull (localNamespace getVariable [PARAMS_MENU_DISPLAY_VAR_STR,displayNull])) then {
            call KISKA_fnc_paramsMenu_open;
        };
    }];
};


nil

/* ----------------------------------------------------------------------------
Function: KISKA_fnc_VDL_openDialog

Description:
    Opens the GUI for the VDL system.

Parameters:
    NONE

Returns:
    BOOL

Examples:
    (begin example)
        call KISKA_fnc_VDL_openDialog;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_VDL_openDialog";

if (!hasInterface) exitWith {false};

if !(missionNamespace getVariable ["KISKA_CBA_VDL_available",true]) exitWith {
    ["The View Distance Limiter Dialog is not available"] call KISKA_fnc_notification;
    false
};

if (missionNamespace getVariable ["KISKA_CBA_VDL_closeMap",true]) then {
    openMap false;
};


createDialog "KISKA_viewDistanceLimiter_dialog";

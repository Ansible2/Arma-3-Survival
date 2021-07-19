/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_dedicatedPreload

Description:
    This acts as a go-between for dedicated server preload event.

    It is told to execute by clients instead of a preload mission eventhandler
     given that they do not work on dedicated servers.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_dedicatedPreload";

if (!isDedicated OR {localNamespace getVariable ["KISKA_paramsMenu_serverToldToPreload",false]}) exitWith {};

localNamespace setVariable ["KISKA_paramsMenu_serverToldToPreload",true];

call KISKA_fnc_paramsMenu_postPreload;

#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_logMessage

Description:
    Prints a message to the log message box of the paramater menu.

Parameters:
	0: _message : <STRING> - The message to print

Returns:
	NOTHING

Examples:
    (begin example)
        ["hello world"] call KISKA_fnc_paramsMenu_logMessage;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_logMessage";

if (!hasInterface) exitWith {};

params ["_message"];

private _menuDisplay = GET_PARAMS_MENU_DISPLAY;
if (isNull _menuDisplay) exitWith {
    ["Parameter menu display is null!"] call KISKA_fnc_log;
    nil
};


private _messageBox_ctrl = _menuDisplay getVariable [MESSAGE_BOX_CTRL_VAR_STR,controlNull];
if ((lbSize _messageBox_ctrl) isEqualTo 50) then {
    _messageBox_ctrl lbDelete 0;
};
private _index = _messageBox_ctrl lbAdd _message;
_messageBox_ctrl lbSetCurSel _index;


nil

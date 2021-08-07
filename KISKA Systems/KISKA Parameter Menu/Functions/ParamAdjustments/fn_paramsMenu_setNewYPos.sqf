#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_setNewYPos

Description:
    Determines the new bottom Y coordinate for the main controls group listbox.
    This keeps controls in the list properly spaced (veritcally) from each other.

Parameters:
	0: _controlGroup : <STRING> - The control of the group to adjust position

Returns:
	NOTHING

Examples:
    (begin example)
        [myParamControlGroup] spawn KISKA_fnc_paramsMenu_setNewYPos;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_setNewYPos";

params [
    ["_controlGroup",controlNull,[controlNull]]
];


private _currentYPos = localNamespace getVariable [PARAMS_MENU_MAIN_GROUP_YPOS_VAR_STR,0];
private _controlClass = ctrlClassName _controlGroup;
private _controlTypeConfig = [[_controlClass]] call KISKA_fnc_findConfigAny;
if (isNull _controlTypeConfig) exitWith {
    [["Control class ", _controlClass, "was not found in any config!"],true] call KISKA_fnc_log;
    _currentYPos
};


private _positionOfControl = _currentYPos + VERTICAL_SPACE_BETWEEN_CONTROLS;
_controlGroup ctrlSetPositionY _positionOfControl;
_controlGroup ctrlCommit 0.1;

private _sizeOfControl = getNumber(_controlTypeConfig >> "h");
localNamespace setVariable [PARAMS_MENU_MAIN_GROUP_YPOS_VAR_STR,_currentYPos + _sizeOfControl];


nil

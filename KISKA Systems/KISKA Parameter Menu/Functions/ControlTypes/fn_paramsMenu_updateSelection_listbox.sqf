#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_updateSelection_listbox

Description:
    Updates the currently selected value for a listbox param control

Parameters:
	0: _listbox_ctrl : <CONTROL> - The listbox control to update
    1: _selectedIndex : <NUMBER> - The index selected in the listbox

Returns:
	NOTHING

Examples:
    (begin example)
        [listControl,0] call KISKA_fnc_paramsMenu_updateSelection_listbox;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_updateSelection_listbox";

params ["_listbox_ctrl", "_selectedIndex"];


_listbox_ctrl lbSetColor [(_listbox_ctrl getVariable [LIST_SELECTED_INDEX_VAR_STR,0]),COLOR_WHITE];
_listbox_ctrl lbSetSelectColor [(_listbox_ctrl getVariable [LIST_SELECTED_INDEX_VAR_STR,0]),COLOR_WHITE];


_listbox_ctrl lbSetColor [_selectedIndex,COLOR_GREEN];
_listbox_ctrl lbSetSelectColor [_selectedIndex,COLOR_GREEN];
_listbox_ctrl setVariable [LIST_SELECTED_INDEX_VAR_STR,_selectedIndex];


private "_value";
if (_listbox_ctrl getVariable [LIST_USE_VALUES_VAR_STR,false]) then {
    _value = _listbox_ctrl lbValue _selectedIndex;
} else {
    _value = _listbox_ctrl lbText _selectedIndex;
};


[_listbox_ctrl,_value] call KISKA_fnc_paramsMenu_setParamValue;


nil

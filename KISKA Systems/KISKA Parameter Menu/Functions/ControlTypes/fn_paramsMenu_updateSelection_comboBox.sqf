#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_updateSelection_comboBox

Description:
    Updates the currently selected value for a ComboBox param control

Parameters:
	0: _combo_ctrl : <CONTROL> - The combo box control to update
    1: _selectedIndex : <NUMBER> - The index selected in the combo box

Returns:
	NOTHING

Examples:
    (begin example)
        [listControl,0] call KISKA_fnc_paramsMenu_updateSelection_comboBox;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_updateSelection_comboBox";

params ["_combo_ctrl", "_selectedIndex"];

_combo_ctrl setVariable [LIST_SELECTED_INDEX_VAR_STR,_selectedIndex];

private "_value";
if (_combo_ctrl getVariable [LIST_USE_VALUES_VAR_STR,false]) then {
    _value = _combo_ctrl lbValue _selectedIndex;
} else {
    _value = _combo_ctrl lbText _selectedIndex;
};

[_combo_ctrl,_value] call KISKA_fnc_paramsMenu_setParamValue;


nil

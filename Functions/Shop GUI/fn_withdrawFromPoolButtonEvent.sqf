#include "..\..\Headers\GUI\shopGUICommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_withdrawFromPoolButtonEvent

Description:
	Takes the selected index and extracts it from the list

Parameters:
	0: _control : <CONTROL> - The control used to activate the function

Returns:
	NOTHING

Examples:
    (begin example)

		[myControl] call BLWK_fnc_withdrawFromPoolButtonEvent;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_control"];

// get currently selected
private _display = ctrlParent _control;
private _poolTreeCtrl = _display displayCtrl BLWK_SHOP_POOL_TREE_IDC;
private _selectedTreePath = tvCurSel _poolTreeCtrl;

if (count _selectedTreePath < 2) exitWith {
	hint parseText "<t color='#f51d1d'>You need to a valid entry.</t>"
};
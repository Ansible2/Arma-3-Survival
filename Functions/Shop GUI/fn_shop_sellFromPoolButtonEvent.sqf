#include "..\..\Headers\descriptionEXT\GUI\shopGUICommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shop_sellFromPoolButtonEvent

Description:
	Takes the selected index and extracts it from the list.
	Then provides the value of the item to the player's points.

Parameters:
	0: _control : <CONTROL> - The control used to activate the function

Returns:
	NOTHING

Examples:
    (begin example)

		[myControl] call BLWK_fnc_shop_sellFromPoolButtonEvent;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define BUILD_TREE 0
#define SUPPORT_TREE 1
disableSerialization;

params ["_control"];

// get currently selected
private _display = ctrlParent _control;
private _poolTreeCtrl = _display displayCtrl BLWK_SHOP_POOL_TREE_IDC;
private _selectedTreePath = tvCurSel _poolTreeCtrl;

if (count _selectedTreePath < 2) exitWith { // if a category or nothing selected
	hint parseText "<t color='#f51d1d'>You need a valid entry selected</t>";
};

// get which global pool to change
private _value = _poolTreeCtrl tvValue _selectedTreePath;
private _treeCategory = _selectedTreePath select 0;
private _indexInPoolArray = _selectedTreePath select 1;
switch (_treeCategory) do {
	case BUILD_TREE: {
		[TO_STRING(BLWK_SHOP_BUILD_POOL_GVAR),_indexInPoolArray] remoteExecCall ["KISKA_fnc_deleteAtArray",BLWK_allClientsTargetId,true];		
	};
	case SUPPORT_TREE: {
		[TO_STRING(BLWK_SHOP_SUPP_POOL_GVAR),_indexInPoolArray] remoteExecCall ["KISKA_fnc_deleteAtArray",BLWK_allClientsTargetId,true];
	};
};

[_value] call BLWK_fnc_addPoints;
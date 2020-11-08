#include "..\..\Headers\descriptionEXT\GUI\shopGUICommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_withdrawFromPoolButtonEvent

Description:
	Takes the selected index and extracts it from the list. 
	Then enacts a "purchase" of the item.

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
#define BUILD_TREE 0
#define SUPPORT_TREE 1

params ["_control"];

// get currently selected
private _display = ctrlParent _control;
private _poolTreeCtrl = _display displayCtrl BLWK_SHOP_POOL_TREE_IDC;
private _selectedTreePath = tvCurSel _poolTreeCtrl;

if (count _selectedTreePath < 2) exitWith {
	hint parseText "<t color='#f51d1d'>You need a valid entry selected</t>";
};

// get which global pool to change
private _indexInPurchaseArray = ([_poolTreeCtrl tvData _selectedTreePath] call BIS_fnc_parseNumberSafe) select 0;
private _indexInTree = _selectedTreePath select 1;

private _treeCategory = _selectedTreePath select 0;
switch (_treeCategory) do {
	case BUILD_TREE: {
		[TO_STRING(BLWK_SHOP_BUILD_POOL_GVAR),_indexInTree] remoteExecCall ["BLWK_fnc_deleteAtGlobalArray",BLWK_allClientsTargetId,true];
		[_indexInPurchaseArray,true] call BLWK_fnc_purchaseObject;
	};
	case SUPPORT_TREE: {
		[TO_STRING(BLWK_SHOP_SUPP_POOL_GVAR),_indexInTree] remoteExecCall ["BLWK_fnc_deleteAtGlobalArray",BLWK_allClientsTargetId,true];
		[_indexInPurchaseArray,true] call BLWK_fnc_purchaseSupport;
	};
};
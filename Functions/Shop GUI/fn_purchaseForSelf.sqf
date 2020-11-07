#include "..\..\Headers\GUI\shopGUICommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_purchaseForSelf

Description:
	Activates when a purchase for pool button is pressed.

	It will then add it to the corresponding global array and call for netowrk sync
	 to ensure it shows up in the tree view for the community pool.

Parameters:
	0: _control : <CONTROL> - The control used to activate the function

Returns:
	NOTHING

Examples:
    (begin example)

		[myControl] call BLWK_fnc_purchaseForSelf;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_control"];

private _ctrlIDC = ctrlIDC _control;

// find corresponding tree
private _controlInfo = switch (_ctrlIDC) do {
	case BLWK_SHOP_BUILD_PURCHASE_SELF_BUTT_IDC: {
		[TO_STRING(BLWK_SHOP_BUILD_POOL_GVAR),BLWK_SHOP_BUILD_TREE_IDC]
	};
	case BLWK_SHOP_SUPP_PURCHASE_SELF_BUTT_IDC: {
		[TO_STRING(BLWK_SHOP_SUPP_POOL_GVAR),BLWK_SHOP_SUPP_TREE_IDC]
	};
};

private _treeIDC = _controlInfo select 1;
private _tvCtrl = (ctrlParent _control) displayCtrl _treeIDC;

// check if the player has anything selected or something like a section header
private _tvSelectedPath = tvCurSel _tvCtrl;
if (_tvSelectedPath isEqualTo [] OR {(count _tvSelectedPath) isEqualTo 1}) exitWith {
	hint "You do not have a valid selection made";
};

// check if player has the points to afford it
private _cost = _tvCtrl tvValue _tvSelectedPath;
private _currentPlayerPoints = missionNamespace getVariable ["BLWK_playerKillPoints",0];
if (_cost > _currentPlayerPoints) exitWith {
	hint "You do not have enough for this item";
};



private _indexInArray = parseNumber (_tvCtrl tvData _tvSelectedPath);

// decide on purchase method
if (_ctrlIDC isEqualTo BLWK_SHOP_BUILD_PURCHASE_SELF_BUTT_IDC) exitWith {
	if !(isNil "BLWK_heldObject") then { // make sure they don't already have something in hand
		hint "Make sure you are not carrying an object before purchasing another one";
	} else {
		null = [_indexInArray] spawn BLWK_fnc_purchaseObject;
	};
};

if (_ctrlIDC isEqualTo BLWK_SHOP_SUPP_PURCHASE_SELF_BUTT_IDC) exitWith {
	// the comm menu can only support 10 items at a time
	if (count (player getVariable "BIS_fnc_addCommMenuItem_menu") isEqualTo 10) then {
		hint "Make sure you are not carrying an object before purchasing another one";
	} else {
		[_indexInArray] call BLWK_fnc_purchaseSupport;
	};
};
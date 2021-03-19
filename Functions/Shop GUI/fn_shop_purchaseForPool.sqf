#include "..\..\Headers\descriptionEXT\GUI\shopGUICommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shop_purchaseForPool

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
		[myControl] call BLWK_fnc_shop_purchaseForPool;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;

params ["_control"];

private _ctrlIDC = ctrlIDC _control;
private _controlInfo = switch (_ctrlIDC) do {
	case BLWK_SHOP_BUILD_PURCHASE_POOL_BUTT_IDC: {
		[TO_STRING(BLWK_SHOP_BUILD_POOL_GVAR),BLWK_SHOP_BUILD_TREE_IDC]
	};
	case BLWK_SHOP_SUPP_PURCHASE_POOL_BUTT_IDC: {
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

// this is the array index or class name in either BLWK_supports_array or BLWK_buildableObjectsHash respectively
private _data = _tvCtrl tvData _tvSelectedPath;
// it is used when buying the item in BLWK_fnc_purchaseObject or BLWK_fnc_purchaseSupport

private _text = _tvCtrl tvText _tvSelectedPath;
private _class = _tvCtrl tvTooltip _tvSelectedPath;

// to avoid transmitting the whole array over network as a public var, this is used instead
private _globalArrayString = _controlInfo select 0;
[_globalArrayString,[_text,_data,_class,_cost]] remoteExecCall ["KISKA_fnc_pushBackToArray",BLWK_allClientsTargetId,true];

// update player's points
missionNamespace setVariable ["BLWK_playerKillPoints",_currentPlayerPoints - _cost];
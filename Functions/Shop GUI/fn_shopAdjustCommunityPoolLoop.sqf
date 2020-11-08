#include "..\..\Headers\descriptionEXT\GUI\shopGUICommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shopAdjustCommunityPoolLoop

Description:
	Starts the loop that keeps the community pool of objects and supports synced.

Parameters:
	0: _display : <DISPLAY> - The display the loop should reference

Returns:
	NOTHING

Examples:
    (begin example)

		null = [myShopDisplay] spawn BLWK_fnc_shopAdjustCommunityPoolLoop;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_shopDisplay"];

if (!canSuspend) exitWith {
	"BLWK_fnc_shopAdjustCommunityPoolLoop must be run in scheduled environment" call BIS_fnc_error;
};


// initialize global vars if not done
if (isNil TO_STRING(BLWK_SHOP_BUILD_POOL_GVAR)) then {
	missionNamespace setVariable [TO_STRING(BLWK_SHOP_BUILD_POOL_GVAR),[]];
};
if (isNil TO_STRING(BLWK_SHOP_SUPP_POOL_GVAR)) then {
	missionNamespace setVariable [TO_STRING(BLWK_SHOP_SUPP_POOL_GVAR),[]];
};


waitUntil {!(isNull _shopDisplay)};

private _poolTreeCtrl = _shopDisplay displayCtrl BLWK_SHOP_POOL_TREE_IDC;

// if tree has nothing in it add default sections
if ((_poolTreeCtrl tvCount []) isEqualTo 0) then {
	_poolTreeCtrl tvAdd [[],"Objects"];
	_poolTreeCtrl tvAdd [[],"Supports"];
};

// populate list with what's current when the dialog is openned
private _fn_populateList = {
	params ["_list","_mainBranchIndex"];
	private ["_displayName_temp","_data_temp","_index_temp","_class_temp"];
	_list apply {
		_displayName_temp = _x select 0;
		_data_temp = _x select 1;
		_class_temp = _x select 2;

		_index_temp = _poolTreeCtrl tvAdd [[_mainBranchIndex],_displayName_temp];
		_poolTreeCtrl tvSetData [[_mainBranchIndex,_index_temp],_data_temp];
		_poolTreeCtrl tvSetTooltip [[_mainBranchIndex,_index_temp],_class_temp];
	};
};
// populate both supports and build items
{
	if !(_x isEqualTo []) then {
		[_x,_forEachIndex] call _fn_populateList;
	};
} forEach [BLWK_SHOP_BUILD_POOL_GVAR,BLWK_SHOP_SUPP_POOL_GVAR];



// for adjusting to changes in global array
private _fn_adjustTree = {
	params ["_displayedArray","_globalVar","_branchNumber","_treeCtrl"];

	systemchat "ran adjust tree";
	private _globalArray = missionNamespace getVariable _globalVar;
	
	// delete all entries if global is empty
	if (_globalArray isEqualTo []) exitWith {
		private _countOfEntries = _treeCtrl tvCount [_branchNumber];
		if (_countOfEntries > 0) then {
			for "_i" from 1 to _countOfEntries do {
				_treeCtrl tvDelete [_branchNumber,0];
			};
		};
	};

	private _countOfDisplayed = count _displayedArray - 1; // want index numbers -1
	private _countOfCurrent = count _globalArray - 1; // 0

	{	
		// faster means of checking to see if the select will result in a nil value
		// didn't want to double by using isNil {_supportPool_displayed select _forEachIndex} 
		if (_countOfDisplayed >= _forEachIndex) then { // if index is below, just change entries

			private _comparedIndex = _displayedArray select _forEachIndex;
			// check if entry needs to be changed
			if !(_comparedIndex isEqualTo _x) then {
				systemChat ("changed index " + (str _branchNumber));
				_treeCtrl tvSetText [[_branchNumber,_forEachIndex],_x select 0]; // update entry display name
				_treeCtrl tvSetData [[_branchNumber,_forEachIndex],_x select 1]; // update data array
				_treeCtrl tvSetTooltip [[_branchNumber,_forEachIndex],_x select 2]; // data array shown
			} else {
				systemChat ("didn't change index " + (str _branchNumber));
			};

		} else { // if there are more entries now, just add
			systemChat ("added index to " + (str _branchNumber));
			private _path = _treeCtrl tvAdd [[_branchNumber],_x select 0];
			_treeCtrl tvSetData [[_branchNumber,_path],_x select 1];
			_treeCtrl tvSetTooltip [[_branchNumber,_path],_x select 2]; 
		};

	} forEach _globalArray;

	if (_countOfDisplayed > _countOfCurrent) then {
		private _indexToDelete = _countOfCurrent + 1;
		for "_i" from _countOfCurrent to _countOfDisplayed do {
			systemChat ("deleted index " + (str _branchNumber));
			// deleting the same index because the tree will move down with each deletetion
			_treeCtrl tvDelete [_branchNumber,_indexToDelete];
		};
	};

	_globalArray
};

private _objectPool_displayed = +BLWK_SHOP_BUILD_POOL_GVAR;
private _supportPool_displayed = +BLWK_SHOP_SUPP_POOL_GVAR;

while {sleep 0.5; !(isNull _shopDisplay)} do {

	// object pool check
	if !(_objectPool_displayed isEqualTo BLWK_SHOP_BUILD_POOL_GVAR) then {
		[_objectPool_displayed,TO_STRING(BLWK_SHOP_BUILD_POOL_GVAR),0,_poolTreeCtrl] call _fn_adjustTree;		
		_objectPool_displayed = +BLWK_SHOP_BUILD_POOL_GVAR;
	};

	// support pool check
	if !(_supportPool_displayed isEqualTo BLWK_SHOP_SUPP_POOL_GVAR) then {		
		[_supportPool_displayed,TO_STRING(BLWK_SHOP_SUPP_POOL_GVAR),1,_poolTreeCtrl] call _fn_adjustTree;
		_supportPool_displayed = +BLWK_SHOP_SUPP_POOL_GVAR;
	};

};

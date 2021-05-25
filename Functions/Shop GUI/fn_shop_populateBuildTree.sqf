#include "..\..\Headers\Build Objects Properties Defines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shop_populateBuildTree

Description:
	Populates the build objects tree view with the build items.

	Activates from the control's onLoad event.

Parameters:
	0: _tv : <CONTROL> - The control of the tree view you want to populate

Returns:
	NOTHING

Examples:
    (begin example)
		[myTreeControl] call BLWK_fnc_shop_populateBuildTree;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
// CIPHER COMMENT: alot of this should be cached in the future for optimization
disableSerialization;

params ["_tv"];

private _categoriesList = [];

private [
	"_displayName_temp",
	"_category_temp",
	"_value_temp",
	"_categoryIndex_temp",
	"_itemIndex_temp",
	"_itemPath_temp",
	"_itemText_temp",
	"_customTooltip_temp"
];


{
	// add category if not already done previously
	_category_temp = _y select CATEGORY;
	_categoryIndex_temp = _categoriesList find _category_temp;
	if (_categoryIndex_temp isEqualTo -1) then {
		_categoryIndex_temp = _tv tvAdd [[],_category_temp];
		_categoriesList pushBack _category_temp;
	};
	
	// add item to list
	_displayName_temp = _y select DISPLAY_NAME;
	_value_temp = _y select PRICE;
	_itemText_temp = [_value_temp,_displayName_temp] joinString " - ";
	_itemIndex_temp = _tv tvAdd [[_categoryIndex_temp],_itemText_temp];	
	_itemPath_temp = [_categoryIndex_temp,_itemIndex_temp];
	
	_tv tvSetValue [_itemPath_temp,_value_temp];

	_tv tvSetData [_itemPath_temp,_x];

	_customTooltip_temp = getText(CONFIG_PATH >> _x >> "tooltip");
	if (_customTooltip_temp isEqualTo "") then {
		_tv tvSetTooltip [_itemPath_temp,_x];
	} else {
		_tv tvSetTooltip [_itemPath_temp,_customTooltip_temp];
	};
		
} forEach BLWK_buildableObjectsHash;


// sort all the sub trees
_tv tvSortByValueAll [[],true];
// organize the top trees alphabetically
_tv tvSort [[],false];
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
params ["_tv"];

disableSerialization;

private _categoriesList = [];

private [
	"_displayName_temp",
	"_category_temp",
	"_value_temp",
	"_categoryIndex_temp",
	"_itemIndex_temp",
	"_itemPath_temp",
	"_itemText_temp"
];

private _propertiesArray = [];
{
	_propertiesArray = BLWK_buidlableObjects_properties select _forEachIndex;

	_category_temp = _propertiesArray select CATEGORY;
	_categoryIndex_temp = _categoriesList findIf {_x == _category_temp};
	if (_categoryIndex_temp isEqualTo -1) then {
		_categoryIndex_temp = _tv tvAdd [[],_category_temp];
		_categoriesList pushBack _category_temp;
	};

	_displayName_temp = [configFile >> "cfgVehicles" >> _x] call BIS_fnc_displayName;
	// add item to list
	_value_temp = _propertiesArray select PRICE;
	_itemText_temp = format ["%1 - %2",_value_temp,_displayName_temp];
	_itemIndex_temp = _tv tvAdd [[_categoryIndex_temp],_itemText_temp];	
	_itemPath_temp = [_categoryIndex_temp,_itemIndex_temp];
	
	_tv tvSetValue [_itemPath_temp,_value_temp];

	private _data = str _forEachIndex; // save array index an class for use with buying the object 
	_tv tvSetData [_itemPath_temp,_data]; 
	_tv tvSetTooltip [_itemPath_temp,_x];
		
} forEach BLWK_buidlableObjects_classes;

// sort tv
for "_i" from 1 to (_tv tvCount []) do {
	_tv tvSortByValue [[(_i - 1)],true];
};
_tv tvSort [[],false];
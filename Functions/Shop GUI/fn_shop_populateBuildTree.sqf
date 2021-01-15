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
	"_class_temp",
	"_categoryIndex_temp",
	"_itemIndex_temp",
	"_itemPath_temp",
	"_itemText_temp"
];

{
	_category_temp = _x select 2;
	_categoryIndex_temp = _categoriesList findIf {_x == _category_temp};
	if (_categoryIndex_temp isEqualTo -1) then {
		_categoryIndex_temp = _tv tvAdd [[],_category_temp];
		_categoriesList pushBack _category_temp;
	};

	_class_temp = _x select 1;
	_displayName_temp = [configFile >> "cfgVehicles" >> _class_temp] call BIS_fnc_displayName;
	// add item to list
	_value_temp = _x select 0;
	_itemText_temp = format ["%1 - %2",_value_temp,_displayName_temp];
	_itemIndex_temp = _tv tvAdd [[_categoryIndex_temp],_itemText_temp];
	
	_itemPath_temp = [_categoryIndex_temp,_itemIndex_temp];

	
	_tv tvSetValue [_itemPath_temp,_value_temp];

	private _data = str _forEachIndex; // save array index an class for use with buying the object 
	_tv tvSetData [_itemPath_temp,_data]; 
	_tv tvSetTooltip [_itemPath_temp,_class_temp];		
} forEach BLWK_buildableObjects_array;
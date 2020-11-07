/* ----------------------------------------------------------------------------
Function: BLWK_fnc_populateBuildTree

Description:
	Populates the build objects tree view with the build items.

	Activates from the control's onLoad event.

Parameters:
	0: _tv : <CONTROL> - The control of the tree view you want to populate

Returns:
	NOTHING

Examples:
    (begin example)

		[myTreeControl] call BLWK_fnc_populateBuildTree;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_tv"];

private _categoriesList = [];

private [
	"_displayName_temp",
	"_category_temp",
	"_value_temp",
	"_class_temp",
	"_categoryIndex"
	,"_itemIndex",
	"_itemPath",
	"_itemText"
];

BLWK_buildableObjects_array apply {
	_value_temp = _x select 0;
	_class_temp = _x select 1;
	
	_category_temp = _x select 2;
	_categoryIndex = _categoriesList findIf {_x == _category_temp};
	if (_categoryIndex isEqualTo -1) then {
		_categoryIndex = _tv tvAdd [[],_category_temp];
		_categoriesList pushBack _category_temp;
	};

	_displayName_temp = [configFile >> "cfgVehicles" >> _class_temp] call BIS_fnc_displayName;
	// add item to list
	_itemText = format ["%1 - %2",_value_temp,_displayName_temp];
	_itemIndex = _tv tvAdd [[_categoryIndex],_itemText];
	
	_itemPath = [_categoryIndex,_itemIndex];
	_tv tvSetValue [_itemPath,_value_temp];
	_tv tvSetTooltip [_itemPath,_class_temp];		
};
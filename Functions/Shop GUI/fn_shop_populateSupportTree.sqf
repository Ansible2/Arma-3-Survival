/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shop_populateSupportTree

Description:
	Populates the support objects tree view with the build items or shows a
	 message if the support dish is not found yet

	Activates from the control's onLoad event.

Parameters:
	0: _tv : <CONTROL> - The control of the tree view you want to populate

Returns:
	NOTHING

Examples:
    (begin example)

		[myTreeControl] call BLWK_fnc_shop_populateSupportTree;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
// CIPHER COMMENT: alot of this should be cached in the future for optimization
disableSerialization;

params ["_tv"];

// if support dish was not found show message
if !(BLWK_supportDishFound) exitWith {
	_tv tvAdd [[],"Find the support dish to unlock"];

	[_tv] spawn {
		params ["_tv"];
		private _display = ctrlParent _tv;

		waitUntil { // if someone finds the dish while the shop is open, it will populate the list
			if (isNull _display) exitWith {true};
			if (BLWK_supportDishFound) exitWith {
				[_tv] call BLWK_fnc_shop_populateSupportTree;
				true
			};

			sleep 1;

			false 
		};
	};
};


// delete the message if the above loop activates while the message is still displayed
if (_tv tvCount [] > 0) then {
	tvClear _tv;
};

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
	_displayName_temp = getText(missionConfigFile >> "cfgCommunicationMenu" >> _class_temp >> "text");
	// add item to list
	_value_temp = _x select 0;
	_itemText_temp = format ["%1 - %2",_value_temp,_displayName_temp];
	_itemIndex_temp = _tv tvAdd [[_categoryIndex_temp],_itemText_temp];
	
	_itemPath_temp = [_categoryIndex_temp,_itemIndex_temp];

	_tv tvSetValue [_itemPath_temp,_value_temp];

	private _data = str _forEachIndex; // save array index in BLWK_supports_array for buying object

	_tv tvSetData [_itemPath_temp,_data];
	_tv tvSetTooltip [_itemPath_temp,_displayName_temp];		
} forEach BLWK_supports_array;
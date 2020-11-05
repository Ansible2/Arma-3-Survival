/* ----------------------------------------------------------------------------
Function: BLWK_fnc_openShopGUI

Description:
	Opens the dialog or GUI of the bulwark to let you purchase
	 supports and build objects.

	Executed from an action added in "BLWK_fnc_prepareBulwarkPlayer"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_openShopGUI;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	KillerStudio,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface OR {!canSuspend}) exitWith {};

disableSerialization;

// CIPHER COMMENT: this message method is a litle dumb and should be changed to just a dedicated text box on top that is either shown or not
#define SUPPORT_DISH_NOT_FOUND_MESSAGE(CTRL)\
	CTRL lbAdd " ";\
	CTRL lbAdd "";\
	CTRL lbAdd "         A Satellite Dish must be found";\
	CTRL lbAdd "             to unlock Support Menu"; 

#define PRICE_NAME_FORMAT "%1 - %2"
#define SHOP_DIALOG_IDD 9999

createDialog "bulwarkShopDialog";
waitUntil {!isNull (findDisplay SHOP_DIALOG_IDD)};


// buildable objects
private _buildableObjectsControl = (findDisplay SHOP_DIALOG_IDD) displayCtrl 1500;
private _displayNameTemp = "";
BLWK_buildableObjects_array apply {
	_displayNameTemp = [configFile >> "cfgVehicles" >> (_x select 1)] call BIS_fnc_displayName;
	_buildableObjectsControl lbAdd format [PRICE_NAME_FORMAT,_x select 0,_displayNameTemp];
};

// show buildable object preview
((findDisplay SHOP_DIALOG_IDD) displayCtrl 1500) ctrlAddEventHandler ['LBSelChanged', {
	private _currentlySelectedIndex = lbCurSel 1500;
  	private _previewPic = getText (configFile >> "CfgVehicles" >> ((BLWK_buildableObjects_array select _currentlySelectedIndex) select 1) >> "editorPreview");

  	ctrlSetText [1502, _previewPic];
}];


// supports
private _supportsControl = (findDisplay SHOP_DIALOG_IDD) displayCtrl 1501;
// if support dish was found, display purchasable support, else show message
if (BLWK_supportDishFound) then {
	private "_nameOfSupport"; 
	BLWK_supports_array apply {
		_nameOfSupport = getText(missionConfigFile >> "cfgCommunicationMenu" >> (_x select 1) >> "text");
		_supportsControl lbAdd format [PRICE_NAME_FORMAT, _x select 0,_nameOfSupport];
	};
} else {
  	SUPPORT_DISH_NOT_FOUND_MESSAGE(_supportsControl);
};







/*
BLWK_fnc_popList = {
	params ["_tv"];

	private _categoriesList = [];

	private ["_displayName_temp","_category_temp","_value","_class","_categoryIndex","_itemIndex","_itemPath","_itemText"];
	BLWK_buildableObjects_array apply {
		_value = _x select 0;
		_class = _x select 1;
		
		_category_temp = _x select 2;
		_categoryIndex = _categoriesList findIf {_x == _category_temp};
		if (_categoryIndex isEqualTo -1) then {
			_categoryIndex = _tv tvAdd [[],_category_temp];
			_categoriesList pushBack _category_temp;
		};

		_displayName_temp = [configFile >> "cfgVehicles" >> _class] call BIS_fnc_displayName;
		// add item to list
		_itemText = format ["%1 - %2",_value,_displayName_temp];
		_itemIndex = _tv tvAdd [[_categoryIndex],_itemText];
		
		_itemPath = [_categoryIndex,_itemIndex];
		_tv tvSetValue [_itemPath,_value];
		_tv tvSetTooltip [_itemPath,_class];		
	};

};
#define BLWK_SHOP_PREVIEW_IDC 97918
BLWK_fnc_exitMouseEvent = {
	params ["_tv"];

	// find out if something is currently selected
	private _fn_setImagePathDefault = {
		_imagePath = "preview.paa";
	};
	private _path = tvCurSel _tv;
	private "_imagePath";
	if (_path isEqualTo []) then {
		call _fn_setImagePathDefault; // go to default image if nothing selected
	} else {
		private _class = _tv tvToolTip _path;
		if (_class isEqualTo "") then { // in the event that the selected item is a category
			call _fn_setImagePathDefault;
		} else {
			_imagePath = getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
		};
	};
	
	private _display = ctrlParent _tv;
	private _imageCtrl = _display displayCtrl BLWK_SHOP_PREVIEW_IDC;
	_imageCtrl ctrlSetText _imagePath;
};

BLWK_fnc_updatePicture = {
	params ["_tv","_path"];

	private _fn_setImagePathDefault = {
		_imagePath = "preview.paa";
	};
	private _class = _tv tvToolTip _path;
	private "_imagePath";
	if (_class isEqualTo "") then { // check if what we're over is a category
		_path = tvCurSel _tv;
		_class = _tv tvToolTip _path;
		if (_class isEqualTo "") then { // check if something is selected
			call _fn_setImagePathDefault;
		} else {
			_imagePath = getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
		};
	} else {
		_imagePath = getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
	};

	private _display = ctrlParent _tv;
	private _imageCtrl = _display displayCtrl BLWK_SHOP_PREVIEW_IDC;
	_imageCtrl ctrlSetText _imagePath;
};
*/
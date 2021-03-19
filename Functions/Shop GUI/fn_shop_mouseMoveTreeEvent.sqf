#include "..\..\Headers\descriptionEXT\GUI\shopGUICommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shop_mouseMoveTreeEvent

Description:
	The event for when mousing over a tree. 
	Used for showing the image of an item in the preview pane.

	Can be added to any tree and only relevant info will allow a picture to be shown.

Parameters:
	0: _tv : <CONTROL> - The control of the tree view you want it to be active on
	1: _path : <ARRAY> - The tree view path of the value nearest to the mouse cursor

Returns:
	NOTHING

Examples:
    (begin example)

		[myTreeViewControl,[0,0]] call BLWK_fnc_shop_mouseMoveTreeEvent;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;

params ["_tv","_path"];

private _fn_setImagePathDefault = {
	_imagePath =  getMissionPath "\preview.paa";
};

private _class = _tv tvToolTip _path;
private "_imagePath";
if (_class isEqualTo "") then { // check if what we're over is a category
	_path = tvCurSel _tv;
	_class = _tv tvToolTip _path;
	if (_class isEqualTo "" OR {!isClass (configFile >> "CfgVehicles" >> _class)}) then { // check if something is selected
		call _fn_setImagePathDefault;
	} else {
		_imagePath = getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
	};
} else {
	_imagePath = getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
};

if (_imagePath isEqualTo "") then {
	call _fn_setImagePathDefault;
};

private _display = ctrlParent _tv;
private _imageCtrl = _display displayCtrl BLWK_SHOP_PREVIEW_IDC;
_imageCtrl ctrlSetText _imagePath;
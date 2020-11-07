/* ----------------------------------------------------------------------------
Function: BLWK_fnc_mouseExitTreeEvent

Description:
	Used in conjunction with BLWK_fnc_mouseMoveTreeEvent.

	Makes it so that should the mouse exit a tree the preview picture is not
	 left blank. If the tree has an item selected, that item will be shown
	 in the preview. If an invalid item is slected or nothing is, the preview
	 mission picture will be shown.

Parameters:
	0: _tv : <CONTROL> - The control of the tree view you want it to be active on

Returns:
	NOTHING

Examples:
    (begin example)

		[myTreeControl] call BLWK_fnc_mouseExitTreeEvent;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_tv"];

// find out if something is currently selected
private _fn_setImagePathDefault = {
	_imagePath = "..\..\preview.paa";
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
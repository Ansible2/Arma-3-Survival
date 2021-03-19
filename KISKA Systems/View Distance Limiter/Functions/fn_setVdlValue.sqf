#include "..\controlTypes.hpp"
#include "..\ViewDistanceLimiterCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_setAllVdlButton

Description:
	Takes the provided control's value and saves it to the corresponding global
	 variable.

Parameters:
	0: _controlToRead <CONTROL> - The control to get the value to save from
	
Returns:
	NOTHING 

Examples:
	(begin example)
		[_controlToRead] call KISKA_fnc_setVdlValue;
	(end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
if (!hasInterface) exitWith {};

params [
	["_controlToRead",controlNull,[controlNull]]
];

private _controlType = ctrlType _controlToRead;
if (!(_controlType isEqualTo CT_SLIDER) AND {!(_controlType isEqualTo CT_XSLIDER)}) then {
	_controlToRead = [_controlToRead] call KISKA_fnc_findVDLPartnerControl;
};

private _sliderPosition = sliderPosition _controlToRead;
private _sliderPositionString = str _sliderPosition;
private _controlIDC = ctrlIDC _controlToRead;
if (_controlIDC isEqualTo VDL_FPS_SLIDER_IDC) exitWith {
	VDL_GLOBAL_FPS = _sliderPosition;
	hint (["Target FPS is now:",_sliderPositionString] joinString " ");
};
if (_controlIDC isEqualTo VDL_FREQ_SLIDER_IDC) exitWith {
	VDL_GLOBAL_FREQ = _sliderPosition;
	hint (["Frequency of checks is now:",_sliderPositionString] joinString " ");
};
if (_controlIDC isEqualTo VDL_MIN_OBJ_DIST_SLIDER_IDC) exitWith {
	VDL_GLOBAL_MIN_DIST = _sliderPosition;
	hint (["Minimum object view distance is now:",_sliderPositionString] joinString " ");
};
if (_controlIDC isEqualTo VDL_MAX_OBJ_DIST_SLIDER_IDC) exitWith {
	VDL_GLOBAL_MAX_DIST = _sliderPosition;
	hint (["Maximum object view distance is now:",_sliderPositionString] joinString " ");
};
if (_controlIDC isEqualTo VDL_INCREMENT_SLIDER_IDC) exitWith {
	VDL_GLOBAL_INC = _sliderPosition;
	hint (["The increment of view distance is now:",_sliderPositionString] joinString " ");
};
if (_controlIDC isEqualTo VDL_TERRAIN_SLIDER_IDC) exitWith {
	VDL_GLOBAL_VIEW_DIST = _sliderPosition;
	hint (["Your overall view distance is now:",_sliderPositionString] joinString " ");
};
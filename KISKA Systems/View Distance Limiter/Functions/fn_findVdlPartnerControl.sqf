#include "..\ViewDistanceLimiterCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_findVdlPartnerControl

Description:
	Used to find tied together constants for controls so that they can be adjust simaltaneously.

Parameters:
	0: _controlIDC <NUMBER OR CONTROL> - The control with which you are searching for its partner
	
Returns:
	<CONTROL OR ARRAY of CONTROLS> 

Examples:
	(begin example)
		_partnerControl = [myControl] call KISKA_fnc_adjustVdlControls;	
	(end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
if (!hasInterface) exitWith {};

#define CONTROL(IDC) (findDisplay VIEW_DISTANCE_LIMITER_DIALOG_IDD) displayCtrl IDC

params [
	["_controlIDC",controlNull,[controlNull,123]]
];
if (_controlIDC isEqualType controlNull) then {
	_controlIDC = ctrlIDC _controlIDC;
};

// FPS
if (_controlIDC isEqualTo VDL_FPS_SLIDER_IDC) exitWith {CONTROL(VDL_FPS_TEXT_EDIT_IDC)};
if (_controlIDC isEqualTo VDL_FPS_TEXT_EDIT_IDC OR {_controlIDC isEqualTo VDL_SET_FPS_BUTTON_IDC}) exitWith {CONTROL(VDL_FPS_SLIDER_IDC)};
// Freq
if (_controlIDC isEqualTo VDL_FREQ_SLIDER_IDC) exitWith {CONTROL(VDL_FREQ_TEXT_EDIT_IDC)};
if (_controlIDC isEqualTo VDL_FREQ_TEXT_EDIT_IDC OR {_controlIDC isEqualTo VDL_SET_FREQ_BUTTON_IDC}) exitWith {CONTROL(VDL_FREQ_SLIDER_IDC)};
// Min Obj Dist
if (_controlIDC isEqualTo VDL_MIN_OBJ_DIST_SLIDER_IDC) exitWith {CONTROL(VDL_MIN_OBJ_DIST_TEXT_EDIT_IDC)};
if (_controlIDC isEqualTo VDL_MIN_OBJ_DIST_TEXT_EDIT_IDC OR {_controlIDC isEqualTo VDL_MIN_OBJ_DIST_BUTTON_IDC}) exitWith {CONTROL(VDL_MIN_OBJ_DIST_SLIDER_IDC)};
// Max Obj Dist
if (_controlIDC isEqualTo VDL_MAX_OBJ_DIST_SLIDER_IDC) exitWith {CONTROL(VDL_MAX_OBJ_DIST_TEXT_EDIT_IDC)};
if (_controlIDC isEqualTo VDL_MAX_OBJ_DIST_TEXT_EDIT_IDC OR {_controlIDC isEqualTo VDL_MAX_OBJ_DIST_BUTTON_IDC}) exitWith {CONTROL(VDL_MAX_OBJ_DIST_SLIDER_IDC)};
// Increment
if (_controlIDC isEqualTo VDL_INCREMENT_SLIDER_IDC) exitWith {CONTROL(VDL_INCREMENT_TEXT_EDIT_IDC)};
if (_controlIDC isEqualTo VDL_INCREMENT_TEXT_EDIT_IDC OR {_controlIDC isEqualTo VDL_INCREMENT_BUTTON_IDC}) exitWith {CONTROL(VDL_INCREMENT_SLIDER_IDC)};
// Terrain
if (_controlIDC isEqualTo VDL_TERRAIN_SLIDER_IDC) exitWith {CONTROL(VDL_TERRAIN_TEXT_EDIT_IDC)};
if (_controlIDC isEqualTo VDL_TERRAIN_TEXT_EDIT_IDC OR {_controlIDC isEqualTo VDL_TERRAIN_BUTTON_IDC}) exitWith {CONTROL(VDL_TERRAIN_SLIDER_IDC)};

// set all
if (_controlIDC isEqualTo VDL_SET_ALL_BUTTON_IDC) exitWith {
	[
		CONTROL(VDL_TERRAIN_SLIDER_IDC),
		CONTROL(VDL_INCREMENT_SLIDER_IDC),
		CONTROL(VDL_MAX_OBJ_DIST_SLIDER_IDC),
		CONTROL(VDL_MIN_OBJ_DIST_SLIDER_IDC),
		CONTROL(VDL_FREQ_SLIDER_IDC),
		CONTROL(VDL_FPS_SLIDER_IDC)
	]
};

controlNull
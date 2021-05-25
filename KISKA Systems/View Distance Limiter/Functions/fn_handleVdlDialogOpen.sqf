/* ----------------------------------------------------------------------------
Function: KISKA_fnc_handleVdlDialogOpen

Description:
	Handles the openning of the View Distance Limiter dialog to maker sure that
	 all the values shown are up to date with the globals.

	It is executed from the dialog's onLoad eventhandler in config.
	
Parameters:
	0: _display <NUMBER> - The display to the GUI
	
Returns:
	NOTHING 

Examples:
	(begin example)
		[displayNumber] call KISKA_fnc_handleVdlDialogOpen;
	(end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
if (!hasInterface) exitWith {};

#include "..\ViewDistanceLimiterCommonDefines.hpp"

params ["_display"];

private _controls = allControls _display; 
private _fn_checkControl = {
	private _controlIDCTemp = ctrlIDC _controlTemp;

	if (_controlIDCTemp isEqualTo VDL_SYSTEM_ON_CHECKBOX_IDC) exitWith {
		if (call KISKA_fnc_isVDLSystemRunning) then {_controlTemp cbSetChecked true};
	};
	// fps
	if (_controlIDCTemp isEqualTo VDL_FPS_TEXT_EDIT_IDC) exitWith {
		_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_FPS_STR,60]);
	};
	if (_controlIDCTemp isEqualTo VDL_FPS_SLIDER_IDC) exitWith {
		_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_FPS_STR,60]);
	};
	// check Freq
	if (_controlIDCTemp isEqualTo VDL_FREQ_TEXT_EDIT_IDC) exitWith {
		_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_FREQ_STR,3]);
	};
	if (_controlIDCTemp isEqualTo VDL_FREQ_SLIDER_IDC) exitWith {
		_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_FREQ_STR,3]);
	};
	// Min Obj Dist
	if (_controlIDCTemp isEqualTo VDL_MIN_OBJ_DIST_TEXT_EDIT_IDC) exitWith {
		_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_MIN_DIST_STR,500]);
	};
	if (_controlIDCTemp isEqualTo VDL_MIN_OBJ_DIST_SLIDER_IDC) exitWith {
		_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_MIN_DIST_STR,500]);
	};
	// Max Obj Dist
	if (_controlIDCTemp isEqualTo VDL_MAX_OBJ_DIST_TEXT_EDIT_IDC) exitWith {
		_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_MAX_DIST_STR,1700]);
	};
	if (_controlIDCTemp isEqualTo VDL_MAX_OBJ_DIST_SLIDER_IDC) exitWith {
		_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_MAX_DIST_STR,1700]);
	};
	// Increment
	if (_controlIDCTemp isEqualTo VDL_INCREMENT_TEXT_EDIT_IDC) exitWith {
		_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_INC_STR,25]);
	};
	if (_controlIDCTemp isEqualTo VDL_INCREMENT_SLIDER_IDC) exitWith {
		_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_INC_STR,25]);
	};
	// terrain
	if (_controlIDCTemp isEqualTo VDL_TERRAIN_TEXT_EDIT_IDC) exitWith {
		_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_VIEW_DIST_STR,viewDistance]);
	};
	if (_controlIDCTemp isEqualTo VDL_TERRAIN_SLIDER_IDC) exitWith {
		_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_VIEW_DIST_STR,viewDistance]);
	};
};

private ["_controlTemp","_controlIDCTemp"];
_controls apply {
	_controlTemp = _x;
	call _fn_checkControl;
};
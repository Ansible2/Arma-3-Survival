/*
//#define STUFF1 23
#define STUFF \
	[ \
		[ \
			"1", \
			"2", \
			"3" \
		], \
		2, \
		STUFF1 \
	]

// strings must be added with params
#define STUFF2(ROUND_NUM) ("It is round " + #ROUND_NUM)
#define COMPLETED_WAVE_NOTIFICATION(WAVE_NUM) ("Wave " + WAVE_NUM + " Complete")

_wave = 1;
hint COMPLETED_WAVE_NOTIFICATION(str _wave);

*/
/*
myDialog = {
	if (!hasInterface) exitWith {};
	disableSerialization;

	createDialog "myDialog";
	waitUntil {!isNull (findDisplay 9999)};
};
*/
#include "viewDistanceCommonDefines.hpp"

KISKA_fnc_isVDLSystemRunning = {
	if (!hasInterface) exitWith {false};
	private _isRunning = missionNamespace getVariable ["KISKA_VDL_run",false];

	_isRunning
};

KISKA_fnc_findVDLPartnerControl = {
	#define CONTROL(IDC) (findDisplay VIEW_DISTANCE_LIMITER_DIALOG_IDD) displayCtrl IDC
	
	params [
		["_controlIDC",controlNull,[controlNull,123]]
	];
	if (_controlIDC isEqualType controlNull) then {
		_controlIDC = ctrlIDC _controlIDC;
	};

	// FPS
	if (_controlIDC isEqualTo VDL_FPS_SLIDER_IDC) exitWith {CONTROL(VDL_FPS_TEXT_EDIT_IDC)};
	if (_controlIDC isEqualTo VDL_FPS_TEXT_EDIT_IDC) exitWith {CONTROL(VDL_FPS_SLIDER_IDC)};
	// Freq
	if (_controlIDC isEqualTo VDL_FREQ_SLIDER_IDC) exitWith {CONTROL(VDL_FREQ_TEXT_EDIT_IDC)};
	if (_controlIDC isEqualTo VDL_FREQ_TEXT_EDIT_IDC) exitWith {CONTROL(VDL_FREQ_SLIDER_IDC)};
	// Min Obj Dist
	if (_controlIDC isEqualTo VDL_MIN_OBJ_DIST_SLIDER_IDC) exitWith {CONTROL(VDL_MIN_OBJ_DIST_TEXT_EDIT_IDC)};
	if (_controlIDC isEqualTo VDL_MIN_OBJ_DIST_TEXT_EDIT_IDC) exitWith {CONTROL(VDL_MIN_OBJ_DIST_SLIDER_IDC)};
	// Max Obj Dist
	if (_controlIDC isEqualTo VDL_MAX_OBJ_DIST_SLIDER_IDC) exitWith {CONTROL(VDL_MAX_OBJ_DIST_TEXT_EDIT_IDC)};
	if (_controlIDC isEqualTo VDL_MAX_OBJ_DIST_TEXT_EDIT_IDC) exitWith {CONTROL(VDL_MAX_OBJ_DIST_SLIDER_IDC)};
	// Increment
	if (_controlIDC isEqualTo VDL_INCREMENT_SLIDER_IDC) exitWith {CONTROL(VDL_INCREMENT_TEXT_EDIT_IDC)};
	if (_controlIDC isEqualTo VDL_INCREMENT_TEXT_EDIT_IDC) exitWith {CONTROL(VDL_INCREMENT_SLIDER_IDC)};
	// Terrain
	if (_controlIDC isEqualTo VDL_TERRAIN_SLIDER_IDC) exitWith {CONTROL(VDL_TERRAIN_TEXT_EDIT_IDC)};
	if (_controlIDC isEqualTo VDL_TERRAIN_TEXT_EDIT_IDC) exitWith {CONTROL(VDL_TERRAIN_SLIDER_IDC)};

	controlNull
};

KISKA_fnc_handleVDLDialogOpen = {
	if (!hasInterface) exitWith {};
	params ["_display"];

	private _controls = allControls _display; 
	private _fn_checkControl = {
		private _controlIDCTemp = ctrlIDC _controlTemp;

		if (_controlIDCTemp isEqualTo VDL_SYSTEM_ON_CHECKBOX_IDC) exitWith {
			if (call KISKA_fnc_isVDLSystemRunning) then {_controlTemp cbSetChecked true};
		};
		// fps
		if (_controlIDCTemp isEqualTo VDL_FPS_TEXT_EDIT_IDC) exitWith {
			_controlTemp ctrlSetText str (missionNamespace getVariable ["KISKA_VDL_fps",60]);
		};
		if (_controlIDCTemp isEqualTo VDL_FPS_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable ["KISKA_VDL_fps",60]);
		};
		// check Freq
		if (_controlIDCTemp isEqualTo VDL_FREQ_TEXT_EDIT_IDC) exitWith {
			_controlTemp ctrlSetText str (missionNamespace getVariable ["KISKA_VDL_freq",3]);
		};
		if (_controlIDCTemp isEqualTo VDL_FREQ_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable ["KISKA_VDL_freq",3]);
		};
		// Min Obj Dist
		if (_controlIDCTemp isEqualTo VDL_MIN_OBJ_DIST_TEXT_EDIT_IDC) exitWith {
			_controlTemp ctrlSetText str (missionNamespace getVariable ["KISKA_VDL_minDist",500]);
		};
		if (_controlIDCTemp isEqualTo VDL_MIN_OBJ_DIST_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable ["KISKA_VDL_minDist",500]);
		};
		// Max Obj Dist
		if (_controlIDCTemp isEqualTo VDL_MAX_OBJ_DIST_TEXT_EDIT_IDC) exitWith {
			_controlTemp ctrlSetText str (missionNamespace getVariable ["KISKA_VDL_maxDist",1700]);
		};
		if (_controlIDCTemp isEqualTo VDL_MAX_OBJ_DIST_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable ["KISKA_VDL_maxDist",1700]);
		};
		// Increment
		if (_controlIDCTemp isEqualTo VDL_INCREMENT_TEXT_EDIT_IDC) exitWith {
			_controlTemp ctrlSetText str (missionNamespace getVariable ["KISKA_VDL_inc",25]);
		};
		if (_controlIDCTemp isEqualTo VDL_INCREMENT_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable ["KISKA_VDL_inc",25]);
		};
		// terrain
		if (_controlIDCTemp isEqualTo VDL_TERRAIN_TEXT_EDIT_IDC) exitWith {
			_controlTemp ctrlSetText str (missionNamespace getVariable ["KISKA_VDL_viewDist",viewDistance]);
		};
		if (_controlIDCTemp isEqualTo VDL_TERRAIN_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable ["KISKA_VDL_viewDist",viewDistance]);
		};
	};

	private ["_controlTemp","_controlIDCTemp"];
	_controls apply {
		_controlTemp = _x;
		call _fn_checkControl;
	};
};
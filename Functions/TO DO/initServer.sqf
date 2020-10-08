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
#include "controlTypes.hpp"

KISKA_fnc_isVDLSystemRunning = {
	if (!hasInterface) exitWith {false};
	private _isRunning = missionNamespace getVariable ["KISKA_VDL_run",false];

	_isRunning
};

KISKA_fnc_handleGUICheckBox = {
	params ["_control","_checked"];

	if (_checked) then {
		if !(call KISKA_fnc_isVDLSystemRunning) then {
			null = [] spawn KISKA_fnc_viewDistanceLimiter;
		} else {
			missionNamespace setVariable [VDL_GLOBAL_RUN,true];
		};
	} else {
		missionNamespace setVariable [VDL_GLOBAL_RUN,false];
	};
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
};

KISKA_fnc_setVDLValue = {
	#define HINT_CHANGE(VALUE) hint str VALUE
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
		missionNamespace setVariable [VDL_GLOBAL_FPS,_sliderPosition];
		hint (["Target FPS is now:",_sliderPositionString] joinString " ");
	};
	if (_controlIDC isEqualTo VDL_FREQ_SLIDER_IDC) exitWith {
		missionNamespace setVariable [VDL_GLOBAL_FREQ,_sliderPosition];
		hint (["Frequency of checks is now:",_sliderPositionString] joinString " ");
	};
	if (_controlIDC isEqualTo VDL_MIN_OBJ_DIST_SLIDER_IDC) exitWith {
		missionNamespace setVariable [VDL_GLOBAL_MIN_DIST,_sliderPosition];
		hint (["Minimum object view distance is now:",_sliderPositionString] joinString " ");
	};
	if (_controlIDC isEqualTo VDL_MAX_OBJ_DIST_SLIDER_IDC) exitWith {
		missionNamespace setVariable [VDL_GLOBAL_MAX_DIST,_sliderPosition];
		hint (["Maximum object view distance is now:",_sliderPositionString] joinString " ");
	};
	if (_controlIDC isEqualTo VDL_INCREMENT_SLIDER_IDC) exitWith {
		missionNamespace setVariable [VDL_GLOBAL_INC,_sliderPosition];
		hint (["The increment of view distance is now:",_sliderPositionString] joinString " ");
	};
	if (_controlIDC isEqualTo VDL_TERRAIN_SLIDER_IDC) exitWith {
		missionNamespace setVariable [VDL_GLOBAL_VIEW_DIST,_sliderPosition];
		hint (["Your overall view distance is now:",_sliderPositionString] joinString " ");
	};
};

KISKA_fnc_setAllVDL = {
	params ["_control"];
	private _partnerControls = [_control] call KISKA_fnc_findVDLPartnerControl;
	
	_partnerControls apply {
		[_x] call KISKA_fnc_setVDLValue;
	};

	hint "All changes applied";
};

KISKA_fnc_adjustControls = {
	params ["_control","_value"];

	private _controlType = ctrlType _control;
	//hint str _controlType;
	if (_controlType isEqualTo CT_EDIT) exitWith {
		private _text = ctrlText _control;
		private _number = ([_text] call BIS_fnc_parseNumberSafe) select 0;
		if !(_number isEqualTo 0) then {
			private _partnerControl = [_control] call KISKA_fnc_findVDLPartnerControl;
			
			// check to see if entered number fits inside slider range
			private _sliderRange = sliderRange _partnerControl;
			if ((_number >= (_sliderRange select 0)) AND {_number <= (_sliderRange select 1)}) then {
				_partnerControl sliderSetPosition _number;
			};
		};
	};
	if (_controlType isEqualTo CT_SLIDER OR {_controlType isEqualTo CT_XSLIDER}) exitWith {
		private _partnerControl = [_control] call KISKA_fnc_findVDLPartnerControl;
		_partnerControl ctrlSetText (str _value);
	};
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
			_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_FPS,60]);
		};
		if (_controlIDCTemp isEqualTo VDL_FPS_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_FPS,60]);
		};
		// check Freq
		if (_controlIDCTemp isEqualTo VDL_FREQ_TEXT_EDIT_IDC) exitWith {
			_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_FREQ,3]);
		};
		if (_controlIDCTemp isEqualTo VDL_FREQ_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_FREQ,3]);
		};
		// Min Obj Dist
		if (_controlIDCTemp isEqualTo VDL_MIN_OBJ_DIST_TEXT_EDIT_IDC) exitWith {
			_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_MIN_DIST,500]);
		};
		if (_controlIDCTemp isEqualTo VDL_MIN_OBJ_DIST_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_MIN_DIST,500]);
		};
		// Max Obj Dist
		if (_controlIDCTemp isEqualTo VDL_MAX_OBJ_DIST_TEXT_EDIT_IDC) exitWith {
			_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_MAX_DIST,1700]);
		};
		if (_controlIDCTemp isEqualTo VDL_MAX_OBJ_DIST_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_MAX_DIST,1700]);
		};
		// Increment
		if (_controlIDCTemp isEqualTo VDL_INCREMENT_TEXT_EDIT_IDC) exitWith {
			_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_INC,25]);
		};
		if (_controlIDCTemp isEqualTo VDL_INCREMENT_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_INC,25]);
		};
		// terrain
		if (_controlIDCTemp isEqualTo VDL_TERRAIN_TEXT_EDIT_IDC) exitWith {
			_controlTemp ctrlSetText str (missionNamespace getVariable [VDL_GLOBAL_VIEW_DIST,viewDistance]);
		};
		if (_controlIDCTemp isEqualTo VDL_TERRAIN_SLIDER_IDC) exitWith {
			_controlTemp sliderSetPosition (missionNamespace getVariable [VDL_GLOBAL_VIEW_DIST,viewDistance]);
		};
	};

	private ["_controlTemp","_controlIDCTemp"];
	_controls apply {
		_controlTemp = _x;
		call _fn_checkControl;
	};
};
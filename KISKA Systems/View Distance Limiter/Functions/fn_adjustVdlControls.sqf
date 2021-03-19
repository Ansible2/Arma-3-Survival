/* ----------------------------------------------------------------------------
Function: KISKA_fnc_adjustVdlControls

Description:
	Used to adjust the partnered field for the GUI.
	e.g. if you change a value with the slider, it adjusts the edit box's' number
	 and vice-versa

Parameters:
	0: _control <CONTROL> - The control that triggered the event
	1: _value <NUMBER> - Slider position value used to set the text inside an edit box

Returns:
	NOTHING 

Examples:
	(begin example)

	[myControl,20] call KISKA_fnc_adjustVdlControls;

	(end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
if (!hasInterface) exitWith {};

#include "..\controlTypes.hpp"

params ["_control","_value"];

private _controlType = ctrlType _control;

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
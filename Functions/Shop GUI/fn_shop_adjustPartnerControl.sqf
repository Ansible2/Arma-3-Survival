#include "..\..\Headers\descriptionEXT\GUI\shopGUICommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shop_adjustPartnerControl

Description:
	Keeps the edit box and slider controls in sync with each other.

	This is for the deposit and withdraw points modules.

Parameters:
	0: _control : <CONTROL> - The control being adjusted
	1: _value : <NUMBER> - The value of the slider control being adjusted

Returns:
	NOTHING

Examples:
    (begin example)

		[myShopDisplay] call BLWK_fnc_shop_adjustPartnerControl;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;

params ["_control","_value"];

private _controlType = ctrlType _control;

if (_controlType isEqualTo CT_EDIT) exitWith {
	private _text = ctrlText _control;
	private _number = ([_text] call BIS_fnc_parseNumberSafe) select 0;
	
	if !(_number isEqualTo 0) then {
		private _partnerControl = [_control] call BLWK_fnc_shop_getPartnerControl;
		
		// check to see if entered number fits inside slider range
		private _sliderRange = sliderRange _partnerControl;
		if ((_number >= (_sliderRange select 0)) AND {_number <= (_sliderRange select 1)}) then {
			_partnerControl sliderSetPosition _number;
		};
	};
};
if (_controlType isEqualTo CT_SLIDER OR {_controlType isEqualTo CT_XSLIDER}) exitWith {
	private _partnerControl = [_control] call BLWK_fnc_shop_getPartnerControl;
	_partnerControl ctrlSetText (str _value);
};
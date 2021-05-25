#include "..\..\Headers\descriptionEXT\GUI\shopGUICommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shop_depositPointsButtonPressedEvent

Description:
	Activates when the deposit points button is pressed.

	Takes out the number of points currently selected on the deposit slider.

Parameters:
	0: _control : <CONTROL> - The control used to activate the function

Returns:
	NOTHING

Examples:
    (begin example)

		[myControl] call BLWK_fnc_shop_depositPointsButtonPressedEvent;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;

params ["_control"];

private _display = ctrlParent _control;
private _sliderControl = _display displayCtrl BLWK_SHOP_POINTS_DEPOSIT_SLIDER_IDC;

private _depositAmount = sliderPosition _sliderControl;
if (_depositAmount <= 0) exitWith {};

private _currentPlayerPoints = missionNamespace getVariable ["BLWK_playerKillPoints",0];
if (_depositAmount > _currentPlayerPoints) exitWith {
	hint "This deposit amount is more then you have";
};

private _currentCommunityPoints = missionNamespace getVariable ["BLWK_communityKillPoints",0];

missionNamespace setVariable ["BLWK_playerKillPoints",_currentPlayerPoints - _depositAmount];
missionNamespace setVariable ["BLWK_communityKillPoints",_currentCommunityPoints + _depositAmount,true];
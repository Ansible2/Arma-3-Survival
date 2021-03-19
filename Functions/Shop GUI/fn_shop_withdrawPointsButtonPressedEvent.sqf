#include "..\..\Headers\descriptionEXT\GUI\shopGUICommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shop_withdrawPointsButtonPressedEvent

Description:
	Activates when the withdraw points button is pressed.

	Takes out the number of points currently selected on the withdraw slider.

Parameters:
	0: _control : <CONTROL> - The control used to activate the function

Returns:
	NOTHING

Examples:
    (begin example)

		[myControl] call BLWK_fnc_shop_withdrawPointsButtonPressedEvent;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;

params ["_control"];

private _display = ctrlParent _control;
private _sliderControl = _display displayCtrl BLWK_SHOP_POINTS_WITHDRAW_SLIDER_IDC;

private _withdrawAmount = sliderPosition _sliderControl;
if (_withdrawAmount <= 0) exitWith {};

private _currentCommunityPoints = missionNamespace getVariable ["BLWK_communityKillPoints",0];

if (_withdrawAmount > _currentPlayerPoints) exitWith {
	hint "This withdraw amount is more than what is in the pool";
};

private _currentPlayerPoints = missionNamespace getVariable ["BLWK_playerKillPoints",0];

missionNamespace setVariable ["BLWK_playerKillPoints",_currentPlayerPoints + _withdrawAmount];
missionNamespace setVariable ["BLWK_communityKillPoints",_currentCommunityPoints - _withdrawAmount,true];
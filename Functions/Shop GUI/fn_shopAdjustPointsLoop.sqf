#include "..\..\Headers\GUI\shopGUICommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shopAdjustPointsLoop

Description:
	Starts the loop that keeps the community points synced between player.

	Also handles updating the controls for player points when they spend
	 points.

Parameters:
	0: _display : <DISPLAY> - The display the loop should reference

Returns:
	NOTHING

Examples:
    (begin example)

		null = [myShopDisplay] spawn BLWK_fnc_shopAdjustPointsLoop;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_shopDisplay"];

// sliderSetSpeed command is currently broken, awaiting fix
// https://feedback.bistudio.com/T154871
/*
private _fn_adjustSliderRange = {
	params ["_sliderCtrl","_sliderMax"];

	if (_sliderMax isEqualTo 0) exitWith {
		_sliderCtrl sliderSetRange [0,0];
		_sliderCtrl sliderSetPosition 0;
		_sliderCtrl sliderSetSpeed [0,0];
	};

	_sliderCtrl sliderSetPosition round (_sliderMax / 2); // always set it to the halfway mark
	// this should auto trigger the linked event between the slider and its edit box so we shouldn't need
	// to do a manual call of BLWK_fnc_adjustPartneredControl if it has an event

	_sliderCtrl sliderSetRange [0,_sliderMax]; // always set max
	if (_sliderMax <= 100) exitWith {
		hint "slider step 1";
		_sliderCtrl sliderSetSpeed [10,1];
	};
	if (_sliderMax <= 1000) exitWith {
		hint "slider step 2";
		_sliderCtrl sliderSetSpeed [20,10];
	};
	if (_sliderMax <= 2000) exitWith {
		hint "slider step 3";
		_sliderCtrl sliderSetSpeed [50,20];
	};
	if (_sliderMax <= 5000) exitWith {
		hint "slider step 4";
		_sliderCtrl sliderSetSpeed [100,25];
	};
	if (_sliderMax > 5000) exitWith {
		_sliderCtrl sliderSetSpeed [100,100];
	};

};
*/
private _fn_adjustSliderRangeWorking = {
	params ["_sliderCtrl","_sliderMax"];

	if (_sliderMax isEqualTo 0) exitWith {
		[_sliderCtrl,0] call BLWK_fnc_adjustPartneredControl;
		_sliderCtrl sliderSetRange [0,0];
		_sliderCtrl sliderSetPosition 0;
	};

	private _sliderMid = round (_sliderMax / 2);
	[_sliderCtrl,_sliderMid] call BLWK_fnc_adjustPartneredControl;
	_sliderCtrl sliderSetRange [0,_sliderMax];
	_sliderCtrl sliderSetPosition _sliderMid;
};

waitUntil {!(isNull _shopDisplay)};
private _depositSliderCtrl = _shopDisplay displayCtrl BLWK_SHOP_POINTS_DEPOSIT_SLIDER_IDC;
private _withdrawSliderCtrl = _shopDisplay displayCtrl BLWK_SHOP_POINTS_WITHDRAW_SLIDER_IDC;

private _depositPoints_displayed = -1; // these start at -1 to cause the _fn_adjustSliderRange to run initially
private _withdrawPoints_displayed = -1;
private ["_depositPoints_current","_withdrawPoints_current"];
while {sleep 0.1; !(isNull _shopDisplay)} do {
	
	// adjust for when a player spends points
	_depositPoints_current = missionNamespace getVariable ["BLWK_playerKillPoints",0];
	if (_depositPoints_displayed != _depositPoints_current) then {
		[_depositSliderCtrl,_depositPoints_current] call _fn_adjustSliderRangeWorking;
		_depositPoints_displayed = _depositPoints_current;
	};

	_withdrawPoints_current = missionNamespace getVariable ["BLWK_communityKillPoints",0];
	if (_withdrawPoints_displayed != _withdrawPoints_current) then {
		[_withdrawSliderCtrl,_withdrawPoints_current] call _fn_adjustSliderRangeWorking;	
		_withdrawPoints_displayed = _withdrawPoints_current;
	};
};
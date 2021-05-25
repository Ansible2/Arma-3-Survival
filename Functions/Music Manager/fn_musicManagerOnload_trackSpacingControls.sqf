#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_trackSpacingControls

Description:
	Adds functionality to the controls used for track spacing in the Music Manager's
	 connection to the KISKA random music system.

Parameters:
	0: _comboControl : <CONTROL> - The control for the format combo box
	1: _editBoxControl : <CONTROL> - The control for the edit box
	2: _buttonControl : <CONTROL> - The control for button to commit the setting

Returns:
	NOTHING

Examples:
    (begin example)
		[
			_comboControl,
			_editBoxControl,
			_buttonControl
		] spawn BLWK_fnc_musicManagerOnLoad_trackSpacingControls;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_trackSpacingControls";

params ["_comboControl","_editBoxControl","_buttonControl"];

// KISKA_fnc_getVariableTarget needs a scheduled environment
if (!canSuspend) exitWith {
	["Needs to be run in scheduled, now running in scheduled",true] call KISKA_fnc_log;
	_this spawn BLWK_fnc_musicManagerOnLoad_trackSpacingControls;
};

_comboControl ctrlSetFont "PuristaLight";

// add settings to combo box
_comboControl lbAdd "Random Max";
_comboControl lbSetTooltip [0,"You will get a random number between 0 and this number."];

_comboControl lbAdd "Random Bell Curve";
_comboControl lbSetTooltip [1,"[min,mid,max]. Time between tracks will likely be close to the 'mid' value but can be anything between 'min' and 'max'."];

_comboControl lbAdd "Exact Time Between";
_comboControl lbSetTooltip [2,"Time between tracks will ALWAYS be this many seconds."];


// get current spacing setting from server
private _currentSpacingSetting = ["KISKA_randomMusic_timeBetween",missionNamespace] call KISKA_fnc_getVariableTarget;
if (_currentSpacingSetting isEqualTo -1) then {
	_comboControl lbSetCurSel 1; // set to random bell curve by default
	_editBoxControl ctrlSetText "[1,2,3]";
} else {
	if (_currentSpacingSetting isEqualType []) then {
		// if random bell curve
		if (_currentSpacingSetting isEqualTypeArray [1,2,3]) then {
			_comboControl lbSetCurSel 1;
		} else { // if random max
			_comboControl lbSetCurSel 0;
		};
	} else { // if exact time
		_comboControl lbSetCurSel 2;
	};

	_editBoxControl ctrlSetText (str _currentSpacingSetting);
};

// combo change event
_comboControl ctrlAddEventHandler ["LBSelChanged",{
	params ["_control", "_selectedIndex"];

	private _editControl = (uiNamespace getVariable "BLWK_musicManager_control_spacingEdit");
	switch (_selectedIndex) do {
		case 0:{ // random max
			_editControl ctrlSetText "[1]";
		};
		case 1:{ // random bell curve
			_editControl ctrlSetText "[1,2,3]";
		};
		case 2:{ // exact time
			_editControl ctrlSetText "1";
		};
	};
}];


// button event
_buttonControl ctrlAddEventHandler ["ButtonClick",{
	params ["_control"];

	private _editControl = (uiNamespace getVariable "BLWK_musicManager_control_spacingEdit");
	private _editControlText = ctrlText _editControl;
	private _textCompiled = call compile _editControlText;

	if (
		(_textCompiled isEqualType []) AND
		{!((count _textCompiled) isEqualTo 1) AND
		{!((count _textCompiled) isEqualTo 3) OR !(_textCompiled isEqualTypeParams [1,2,3])}}
	) then {
		hint "Format not accepted for track spacing!"
	} else {
		// send to server
		missionNamespace setVariable ["KISKA_randomMusic_timeBetween",_textCompiled,[0,2] select isMultiplayer];
		hint ("Track spacing set to " + (str _textCompiled));
	};
}];


nil

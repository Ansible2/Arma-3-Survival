#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"

params ["_comboControl","_editBoxControl","_buttonControl"];

_comboControl ctrlSetFont "PuristaLight";

// combo box populate
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

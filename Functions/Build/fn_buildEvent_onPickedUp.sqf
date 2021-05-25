#include "..\..\Headers\Build Objects Properties Defines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_buildEvent_onPickedUp

Description:
	Executes an object's configed script as entered in under its BLWK_buildableItems
	 entry.

	Executes from "BLWK_fnc_pickupObject" after object is transfered to the player
	 and actions have been added.

Parameters:
	0: _object : <OBJECT> - The picked up object

Returns:
	NOTHING

Examples:
    (begin example)
		[_objectPickedUp] call BLWK_fnc_buildEvent_onPickedUp;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_buildEvent_onPickedUp";

params [
	["_object",objNull,[objNull]]
];

if (isNull _object) exitWith {
	["_object is a null object, exiting...",true] call KISKA_fnc_log;
	nil
};


private _code = getText(CONFIG_PATH >> (typeOf _object) >> "onPickedUp");
if (_code isEqualTo "") exitWith {};

call (compile _code);


nil

#include "..\..\Headers\Build Objects Properties Defines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_buildEvent_onSold

Description:
	Executes an object's configed script as entered in under its BLWK_buildableItems
	 entry.

	Executes from "BLWK_fnc_sellObject" before the object is deleted.

Parameters:
	0: _object : <OBJECT> - The object being sold

Returns:
	NOTHING

Examples:
    (begin example)
		[_object] call BLWK_fnc_buildEvent_onSold;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_buildEvent_onSold";

params [
	["_object",objNull,[objNull]]
];


if (isNull _object) exitWith {
	["_object is a null object, exiting...",true] call KISKA_fnc_log;
};


private _code = getText(CONFIG_PATH >> (typeOf _object) >> "onSold");
if (_code isEqualTo "") exitWith {};

call (compile _code);


nil
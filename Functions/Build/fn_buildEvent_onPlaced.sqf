#include "..\..\Headers\Build Objects Properties Defines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_buildEvent_onPlaced

Description:
	Executes an object's configed script as entered in under its BLWK_buildableItems
	 entry.

	Executes from "BLWK_fnc_placeObject" after the object is down.

Parameters:
	0: _object : <OBJECT> - The object being placed
	1: _wasSnapped : <BOOL> - If the object was snapped to the surface

Returns:
	NOTHING

Examples:
    (begin example)
		[_object] call BLWK_fnc_buildEvent_onPlaced;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_buildEvent_onPlaced";

params [
	["_object",objNull,[objNull]],
	["_wasSnapped",false,[true]]
];

if (isNull _object) exitWith {
	["_object is a null object, exiting...",true] call KISKA_fnc_log;
	nil
};


private _code = getText(CONFIG_PATH >> (typeOf _object) >> "onPlaced");
if (_code isEqualTo "") exitWith {};

call (compile _code);


nil

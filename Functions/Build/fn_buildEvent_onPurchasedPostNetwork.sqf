#include "..\..\Headers\Build Objects Properties Defines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_buildEvent_onPurchasedPostNetwork

Description:
	Executes an object's configed script as entered in under its BLWK_buildableItems
	 entry.

	Executes from "BLWK_fnc_purchaseObject" after an object's actions are
	 synced across the network.

Parameters:
	0: _object : <OBJECT> - The purchased object

Returns:
	NOTHING

Examples:
    (begin example)
		[_purchasedObject] call BLWK_fnc_buildEvent_onPurchasedPostNetwork;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_buildEvent_onPurchasedPostNetwork";

params [
	["_object",objNull,[objNull]]
];

if (isNull _object) exitWith {
	["_object is a null object, exiting...",true] call KISKA_fnc_log;
	nil
};


private _code = getText(CONFIG_PATH >> (typeOf _object) >> "onPurchasedPostNetwork");
if (_code isEqualTo "") exitWith {};

call (compile _code);


nil

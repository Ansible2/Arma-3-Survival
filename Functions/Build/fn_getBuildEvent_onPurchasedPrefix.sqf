#include "..\..\Headers\Build Objects Properties Defines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_getBuildEvent_onPurchasedPrefix

Description:
	Retrieves the prefix function from the object class in BLWK_buildableItems.

Parameters:
	0: _objectClass : <STRING> - The class of the object as it appears in BLWK_buildableItems
	1: _compile : <BOOL> - Should the return be compiled code or simply the uncompiled string

Returns:
	<STRING or CODE> - The (un)compiled function from the items class in BLWK_buildableItems

Examples:
    (begin example)
		_prefixFunction = ["someObjectClass"] call BLWK_fnc_getBuildEvent_onPurchasedPrefix;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_getBuildEvent_onPurchasedPrefix";

params [
	["_objectClass","",[""]],
	["_compile",false,[true]]
];

if (_objectClass isEqualTo "") exitWith {
	["_objectClass is an empty string!",true] call KISKA_fnc_log;
	
	if (_compile) then {
		{}
	} else {
		""
	};
};

private	_return = getText(CONFIG_PATH >> _objectClass >> "onPurchasedPrefix");

if (_return isEqualTo "") exitWith {
	if (_compile) then {
		{}
	} else {
		""
	};
};

if (_compile) then {
	_return = compileFinal _return;
};


_return
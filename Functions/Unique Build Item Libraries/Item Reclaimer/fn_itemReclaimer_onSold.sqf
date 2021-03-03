/* ----------------------------------------------------------------------------
Function: BLWK_fnc_itemReclaimer_onSold

Description:
	Performs the sale of any objects in the reclaimer box when before it is sold
	 back.

	Executed from its onSold event added in the config "main build items.hpp"

Parameters:
	0: _reclaimerObject : <OBJECT> - The item reclaimer object

Returns:
	NOTHING

Examples:
    (begin example)
		[anObject] call BLWK_fnc_itemReclaimer_onSold;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_itemReclaimer_onSold";

params ["_reclaimerObject"];

if (isNull _reclaimerObject) exitWith {
	["_object was null, exiting...",true] call KISKA_fnc_log;
	nil
};

[_reclaimerObject] call BLWK_fnc_itemReclaimer_reclaim;
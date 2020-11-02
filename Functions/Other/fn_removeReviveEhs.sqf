/* ----------------------------------------------------------------------------
Function: BLWK_fnc_removeReviveEhs

Description:
	Removes the events associated with the vanilla revive system.
	Likely called on death of a unit.

	Executed from "onPlayerKilled.sqf"

Parameters:
	0: _unit : <OBJECT> - The unit that should have the eventhandlers removed from

Returns:
	NOTHING

Examples:
    (begin example)

		[unitToRemoveFrom] call BLWK_fnc_removeReviveEhs;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_unit"];

_unit removeEventHandler ["handleDamage",BLWK_handleDamageEh_ID];
_unit removeEventHandler ["animStateChanged",BLWK_animStateChangedEh_ID];
BLWK_animStateChangedEh_ID = nil;
BLWK_handleDamageEh_ID = nil;
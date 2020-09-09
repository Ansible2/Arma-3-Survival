/* ----------------------------------------------------------------------------
Function: BLWK_fnc_enableCollisionWithPlayer

Description:
	When an object is picked up, it's collision is disabled.
	This resets it.

	Executed from ""

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_enableCollisionWithPlayer;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

params ["_object"];

if (isNull _object) exitWith {};

waitUntil {player isEqualTo player};

_object enableCollisionWith player;
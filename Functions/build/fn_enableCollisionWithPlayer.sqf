/* ----------------------------------------------------------------------------
Function: BLWK_fnc_enableCollisionWithPlayer

Description:
	When an object is picked up, it's collision is disabled to avoid hitting other players.
	This resets it.

	Executed from "BLWK_fnc_placeObject"

Parameters:
	0: _object : <OBJECT> - The object to enable collision with

Returns:
	NOTHING

Examples:
    (begin example)

		null = [myObject] spawn BLWK_fnc_enableCollisionWithPlayer;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface OR {!canSuspend}) exitWith {};

params ["_object"];

if (isNull _object) exitWith {};

waitUntil {player isEqualTo player};

_object enableCollisionWith player;
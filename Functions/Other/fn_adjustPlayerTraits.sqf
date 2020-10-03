/* ----------------------------------------------------------------------------
Function: BLWK_fnc_adjustPlayerTraits

Description:
	Reduces recoil, aim sway, and removes stamina from a unit.
	Also adds medic and engineer traits to the unit.

	Executed from "initPlayerLocal.sqf" & "onPlayerRespawn.sqf"

Parameters:
	0: _player : <OBJECT> - The unit to adjust the traits for

Returns:
	NOTHING

Examples:
    (begin example)

		[player] call BLWK_fnc_adjustPlayerTraits;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params [
	["_player",player,[objNull]]
];

_player setCustomAimCoef 0.2;
_player setUnitRecoilCoefficient 0.5;
_player enableStamina false;

_player setUnitTrait ["Medic",true];
_player setUnitTrait ["Engineer",true];
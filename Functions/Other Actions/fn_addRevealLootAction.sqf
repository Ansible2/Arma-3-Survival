#include "..\..\Headers\Loot Reveal Types.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addRevealLootAction

Description:
	Adds the action to the box that adds loot location markers to the map

	Executed from "BLWK_fnc_spawnLoot"

Parameters:
	0: _lootRevealBox : <OBJECT> - The box to add the action to

Returns:
	NOTHING

Examples:
    (begin example)
		[myBox] spawn BLWK_fnc_addRevealLootAction;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_addRevealLootAction";

#define DELETE_BOX_AND_NIL \
	missionNamespace setVariable ["BLWK_lootRevealerBox",nil,true]; \
	deleteVehicle (_this select 0);


if (!hasInterface) exitWith {};

params ["_lootRevealBox"];

if (isNull _lootRevealBox) exitWith {
	["_lootRevealBox is a null object, exiting..."] call KISKA_fnc_log;
};

// CIPHER COMMENT: may be a dirty edit, but don't really want anything else on this...
removeAllActions _lootRevealBox;

waitUntil {!isNil "BLWK_multipleLootReveals"};


if (BLWK_multipleLootReveals) then {
	_lootRevealBox addAction [
		"<t color='#29a318'>-- Reveal Equipment Locations --</t>",
		{
			[TYPE_EQUIPMENT] remoteExec ["BLWK_fnc_lootReveal",0];
			DELETE_BOX_AND_NIL
		},
		nil,
		1,
		true,
		false,
		"",
		"",
		2.5
	];
	_lootRevealBox addAction [
		"<t color='#fa05c1'>-- Reveal Weapon Locations --</t>",
		{
			[TYPE_WEAPONS] remoteExec ["BLWK_fnc_lootReveal",0];
			DELETE_BOX_AND_NIL
		},
		nil,
		1,
		true,
		false,
		"",
		"",
		2.5
	];
	_lootRevealBox addAction [
		"<t color='#b09c45'>-- Reveal Item Locations --</t>",
		{
			[TYPE_ITEMS] remoteExec ["BLWK_fnc_lootReveal",0];
			DELETE_BOX_AND_NIL
		},
		nil,
		1,
		true,
		false,
		"",
		"",
		2.5
	];
	_lootRevealBox addAction [
		"<t color='#0563fa'>-- Reveal Ammo Locations --</t>",
		{
			[TYPE_AMMO] remoteExec ["BLWK_fnc_lootReveal",0];
			DELETE_BOX_AND_NIL
		},
		nil,
		1,
		true,
		false,
		"",
		"",
		2.5
	];
	_lootRevealBox addAction [
		"<t color='#696969'>-- Reveal Unique Item Locations --</t>",  // random hex I promise
		{
			[TYPE_UNIQUE] remoteExec ["BLWK_fnc_lootReveal",0];
			DELETE_BOX_AND_NIL
		},
		nil,
		1,
		true,
		false,
		"",
		"",
		2.5
	];
} else {
	_lootRevealBox addAction [
		"<t color='#ff00ff'>-- Reveal Loot Locations --</t>",
		{
			[TYPE_ALL] remoteExec ["BLWK_fnc_lootReveal",0];
			DELETE_BOX_AND_NIL
		},
		nil,
		1,
		true,
		false,
		"",
		"",
		2.5
	];
};

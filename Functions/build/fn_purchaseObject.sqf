/* ----------------------------------------------------------------------------
Function: BLWK_fnc_purchaseObject

Description:
	Creates the object purchased from the bulwark 

	Executed from "BLWK_fnc_purchaseForSelf" under the 
	 "bulwarkShopDialog_supports_purchaseForSelfButton" class.
	And from "bulwarkShopDialog_buildableObjects_purchaseForSelfButton" class.

	Both classes are located in headers\descriptionEXT\GUI\shopGUI.hpp

Parameters:
	0: _selectedIndex : <NUMBER> - The index of the item in BLWK_buildableObjects_array
	1: _free : <BOOL> - Is this item free or not?

Returns:
	NOTHING

Examples:
    (begin example)

		null = [0] spawn BLWK_fnc_purchaseObject;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface OR {!canSuspend}) exitWith {};

params [
	"_selectedIndex",
	["_free",false]
];

(BLWK_buildableObjects_array select _selectedIndex) params [
	"_price",
	"_className",
	"", // don't need shop category
	"", // don't need attachment info
	"_hasAi",
	["_indestructable",false]
];

/*
// Script was passed an invalid number
if (_className isEqualTo "") exitWith {};
*/

// CIPHER COMMENT: Potentially need to add the object to curator

private "_purchasedObject";

if (_hasAi) then {
	_purchasedObject = ([[0,0,300], 0, _className, west] call BIS_fnc_spawnVehicle) select 0;
} else {
	_purchasedObject = _className createVehicle [0,0,0];
};

if (_indestructable) then {
	_purchasedObject allowDamage false;
};


if !(_free) then {
	[_price] call BLWK_fnc_subtractPoints;
};

closeDialog 0;

clearItemCargoGlobal _purchasedObject;
clearWeaponCargoGlobal _purchasedObject;
clearMagazineCargoGlobal _purchasedObject;
clearBackpackCargoGlobal _purchasedObject;

// attach object to player
null = [_purchasedObject,player,true] spawn BLWK_fnc_pickupObject;

sleep 1;

// give all players the ability to manipulate the object
[_purchasedObject] remoteExecCall ["BLWK_fnc_addBuildableObjectActions",BLWK_allClientsTargetID,true];
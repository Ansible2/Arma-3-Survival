/* ----------------------------------------------------------------------------
Function: BLWK_fnc_purchaseObject

Description:
	Creates the object purchased from the shop 

	Executed from "BLWK_fnc_purchaseForSelf" under the 
	 "theCrateShopDialogsupports_purchaseForSelfButton" class.
	And from "theCrateShopDialogbuildableObjects_purchaseForSelfButton" class.

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
	["_indestructable",false],
	["_keepInventory",false],
	["_doDetectCollision",false]
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

if !(_keepInventory) then {
	clearItemCargoGlobal _purchasedObject;
	clearWeaponCargoGlobal _purchasedObject;
	clearMagazineCargoGlobal _purchasedObject;
	clearBackpackCargoGlobal _purchasedObject;
};

// attach object to player
null = [_purchasedObject,player,true] spawn BLWK_fnc_pickupObject;

sleep 1;
[_purchasedObject] call BLWK_fnc_addBuildableObjectActions; // give local player object actions

if (_doDetectCollision) then {
	// only the AI needs to know about it
	_purchasedObject setVariable ["BLWK_collisionObject",true,BLWK_theAIHandlerOwnerID];
};

/*
	Due to network issues with setOwner
	objects that are too quickly manipulated by other players after being set down
	by the intial purchaser will vanish/teleport to [0,0,0]
	Have to wait about 10 seconds after being set down for things to "sync up"
*/
waitUntil {
	if !(_purchasedObject getVariable "BLWK_objectPickedUp") exitWith {true};
	if !(alive _purchasedObject) exitWith {true};
	sleep 1;
	false
};

sleep 10;

// give remote players the ability to manipulate the object
[_purchasedObject] remoteExecCall ["BLWK_fnc_addBuildableObjectActions",-clientOwner,true];
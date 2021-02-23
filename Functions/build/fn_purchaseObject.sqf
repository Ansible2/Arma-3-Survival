#include "..\..\Headers\Build Objects Properties Defines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_purchaseObject

Description:
	Creates the object purchased from the shop 

	Executed from "BLWK_fnc_shop_purchaseForSelf" under the 
	 "theCrateShopDialogsupports_purchaseForSelfButton" class.
	And from "theCrateShopDialogbuildableObjects_purchaseForSelfButton" class.

	Both classes are located in headers\descriptionEXT\GUI\shopGUI.hpp

Parameters:
	0: _selectedIndex : <NUMBER> - The index of the item in BLWK_buildableObjects_classes
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

private _className = BLWK_buildableObjects_classes select _selectedIndex;
private _propertiesArray = BLWK_buildableObjects_properties select _selectedIndex;


// prefix event
private _prefixFunction = [_className,true] call BLWK_fnc_getBuildEvent_onPurchasedPrefix;
if (_prefixFunction isEqualTo {}) then {
	[_className,_propertiesArray] call _prefixFunction;
};


private "_purchasedObject";
if (_propertiesArray select HAS_AI) then {
	_purchasedObject = ([[0,0,300], 0, _className, west] call BIS_fnc_spawnVehicle) select 0;
} else {
	_purchasedObject = _className createVehicle [0,0,0];
};

if (_propertiesArray select INDESTRUCTABLE) then {
	_purchasedObject allowDamage false;
	_purchasedObject setVariable ["ace_cookoff_enable", false, true];
};


if !(_free) then {
	[_propertiesArray select PRICE] call BLWK_fnc_subtractPoints;
};

// close the shop dialog
closeDialog 0;

if !(_propertiesArray select KEEP_INVENTORY) then {
	clearItemCargoGlobal _purchasedObject;
	clearWeaponCargoGlobal _purchasedObject;
	clearMagazineCargoGlobal _purchasedObject;
	clearBackpackCargoGlobal _purchasedObject;
};

// attach object to player
null = [_purchasedObject,player,true] spawn BLWK_fnc_pickupObject;

sleep 1;
[_purchasedObject] call BLWK_fnc_addBuildableObjectActions; // give local player object actions

if (_propertiesArray select DETECT_COLLISION) then {
	// only the AI needs to know about the collision property
	_purchasedObject setVariable ["BLWK_collisionObject",true,BLWK_theAIHandlerOwnerID];
};


// postfix event
[_purchasedObject] call BLWK_fnc_buildEvent_onPurchasedPostfix;


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


// postnetwork event
[_purchasedObject] call BLWK_fnc_buildEvent_onPurchasedPostNetwork;
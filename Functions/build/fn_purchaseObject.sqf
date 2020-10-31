/* ----------------------------------------------------------------------------
Function: BLWK_fnc_purchaseObject

Description:
	Creates the object purchased from the bulwark 

	Executed from "bulwarkShopGUI.hpp" under the "bulwarkShopDialog_buildButton" class

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_purchaseObject;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface OR {!canSuspend}) exitWith {};
// get the current slected list index from the purchase GUI when you press the button
private _selectedIndex = lbCurSel 1500;
if (isNil "_selectedIndex") exitWith {
	hint "Invalid selection";
};

(BLWK_buildableObjects_array select _selectedIndex) params [
	"_price",
	"_className",
	"_hasAi",
	"", // don't need attachment info
	["_indestructable",false]
];

// Script was passed an invalid number
if (_className isEqualTo "") exitWith {};

// CIPHER COMMENT: Potentially need to add the object to curator
if !(isNil "BLWK_heldObject") exitWith {
	hint "Make sure you are not carrying an object before purchasing another one";
};
if ((missionNamespace getVariable ["BLWK_playerKillPoints",0]) >= _price) then {
	private "_purchasedObject";

    if (_hasAi) then {
      	_purchasedObject = ([[0,0,300], 0, _className, west] call BIS_fnc_spawnVehicle) select 0;
	} else {
		_purchasedObject = _className createVehicle [0,0,0];
	};

	if (_indestructable) then {
		_purchasedObject allowDamage false;
	};

	[_price] call BLWK_fnc_subtractPoints;

	closeDialog 0;

	clearItemCargoGlobal _purchasedObject;
	clearWeaponCargoGlobal _purchasedObject;
	clearMagazineCargoGlobal _purchasedObject;
	clearBackpackCargoGlobal _purchasedObject;

	waitUntil {player isEqualTo player};

	// attach object to player
	null = [_purchasedObject,player,true] spawn BLWK_fnc_pickupObject;
	
	sleep 1;

	// give all players the ability to manipulate the object
	[_purchasedObject] remoteExecCall ["BLWK_fnc_addBuildableObjectActions",BLWK_allClientsTargetID,true];
} else {
	private _displayName = [configFile >> "cfgVehicles" >> _className] call BIS_fnc_displayName;
	null = [format ["<t size='0.6' color='#ff3300'>Not enough points for: %1!</t>", _displayName], -0, -0.02, 2, 0.1] spawn BIS_fnc_dynamicText;
};
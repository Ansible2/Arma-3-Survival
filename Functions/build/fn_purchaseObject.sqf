/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pickupObject

Description:
	Creates the object purchased from the bulwark 

	Executed from ""

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
// get the current slected list index from the purchase GUI when you press the button
private _selectedIndex = lbCurSel 1500;

if (isNil _selectedIndex) exitWith {
	hint "Invalid selection";
};

(BLWK_buildableObjects_array select _selectedIndex) params [
	"_price",
	"_displayName",
	"_className",
	"_hasAi"
];

// Script was passed an invalid number
if (_className isEqualTo "") exitWith {};

private "_purchasedObject";
private _playerKillpoints = missionNamespace getVariable ["BLWK_playerKillPoints",0];

// does the player have enough money and are they holding an object 
// CIPHER COMMENT: Should probably just exit GUI fnc if the person is holding an object or make it unavailable
// see fn_openShopGUI to change
// CIPHER COMMENT: Potentially need to add the object to curator
if (_playerKillpoints >= _price AND {!(isNil "BLWK_heldObject")}) then {
    if (_hasAi) then {
      	_purchasedObject = ([[0,0,300], 0, _className, west] call BIS_fnc_spawnVehicle) select 0;
	} else {
		_purchasedObject = _className createVehicle [0,0,0];
	};

	if (_className == "B_HMG_01_A_F") then {
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
	[_purchasedObject,player,true] call BLWK_fnc_pickupObject;
	
	sleep 1;

	// give all players the ability to manipulate the object
	[_purchasedObject] remoteExecCall ["BLWK_fnc_addBuildableObjectActions",BLWK_allClientsTargetID,true];
} else {
	[format ["<t size='0.6' color='#ff3300'>Not enough points for: %1!</t>", _displayName], -0, -0.02, 2, 0.1] call BIS_fnc_dynamicText;
};
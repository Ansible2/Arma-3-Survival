/* ----------------------------------------------------------------------------
Function: BLWK_fnc_itemReclaimer_init

Description:
	Initializes the item reclaimer object.

	Executed from its onPurchasedPostFix event added in the config "main build items.hpp"

Parameters:
	0: _reclaimerObject : <OBJECT> - The item reclaimer object

Returns:
	NOTHING

Examples:
    (begin example)
		[anObject] call BLWK_fnc_itemReclaimer_init;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_itemReclaimer_init";

params ["_reclaimerObject"];

if (isNull _reclaimerObject) exitWith {
	["_reclaimerObject was null, exiting...",true] call KISKA_fnc_log;
	nil
};

// create a storage box for the dumbster and then hide it
private _storageBox = "Box_NATO_Ammo_F" createVehicle (position player);
// delete all inventory
clearItemCargoGlobal _storageBox;
clearBackpackCargoGlobal _storageBox;
clearWeaponCargoGlobal _storageBox;
clearMagazineCargoGlobal _storageBox;
[_storageBox] remoteExecCall ["hideObjectGlobal",2];
_storageBox allowDamage false;
[_storageBox] call BLWK_fnc_addAllowDamageEH;

// storage box needs to be within 5m of player when using GEAR action command
_storageBox attachTo [_reclaimerObject,[0,0,0]];

_reclaimerObject setVariable ["BLWK_reclaimBox",_storageBox,true];

[_reclaimerObject] remoteExecCall ["BLWK_fnc_itemReclaimer_addActions",BLWK_allClientsTargetId,_reclaimerObject];
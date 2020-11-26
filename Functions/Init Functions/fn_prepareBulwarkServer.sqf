/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareBulwarkServer

Description:
	Creates and sets up The Crate, syncs the box global to all machines.
	Also adds the desired number of medkits

	Executed from "BLWK_fnc_preparePlayArea"

Parameters:
	NONE

Returns:
	OBJECT - the main crate object

Examples:
    (begin example)

		call BLWK_fnc_prepareBulwarkServer;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

// create Crate
_mainCrate = createVehicle ["B_supplyCrate_F", [0,0,0], [], 0, "NONE"];

clearItemCargoGlobal _mainCrate;
clearWeaponCargoGlobal _mainCrate;
clearMagazineCargoGlobal _mainCrate;
clearBackpackCargoGlobal _mainCrate;
_mainCrate allowDamage false;

private _bulwarkLaptop = createVehicle ["Land_Laptop_device_F", [0,0,0], [], 0, "NONE"];
_bulwarkLaptop allowDamage false;
_bulwarkLaptop setObjectTextureGlobal [0,"preview.paa"];
//[_bulwarkLaptop,[0,"preview.paa"]] remoteExec ["setObjectTexture",BLWK_allClientsTargetID,true];
_bulwarkLaptop attachTo [_mainCrate, [0,0.1,0.6]];
_bulwarkLaptop setDir 180;

// add medkits
if (BLWK_numMedKits > 0) then {
	_mainCrate addItemCargoGlobal ["Medikit", BLWK_numMedKits];
};


_mainCrate
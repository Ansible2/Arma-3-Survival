/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareBulwarkServer

Description:
	Creates and sets up the bulwark, syncs the box global to all machines.
	Also adds the desired number of medkits

	Executed from "BLWK_fnc_preparePlayArea"

Parameters:
	NONE

Returns:
	OBJECT - the bulwark object

Examples:
    (begin example)

		call BLWK_fnc_prepareBulwarkServer;

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

// create bulwark
_bulwarkBox = createVehicle ["B_supplyCrate_F", [0,0,0], [], 0, "NONE"];

clearItemCargoGlobal _bulwarkBox;
clearWeaponCargoGlobal _bulwarkBox;
clearMagazineCargoGlobal _bulwarkBox;
clearBackpackCargoGlobal _bulwarkBox;
_bulwarkBox allowDamage false;

private _bulwarkLaptop = createVehicle ["Land_Laptop_device_F", [0,0,0], [], 0, "NONE"];
_bulwarkLaptop allowDamage false;
_bulwarkLaptop setObjectTextureGlobal [0,"preview.paa"];
//[_bulwarkLaptop,[0,"preview.paa"]] remoteExec ["setObjectTexture",BLWK_allClientsTargetID,true];
_bulwarkLaptop attachTo [_bulwarkBox, [0,0.1,0.6]];
_bulwarkLaptop setDir 180;

// add medkits
if (BLWK_numMedKits > 0) then {
	_bulwarkBox addItemCargoGlobal ["Medikit", BLWK_numMedKits];
};


_bulwarkBox
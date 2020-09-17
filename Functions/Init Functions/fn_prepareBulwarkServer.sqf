/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareBulwarkServer

Description:
	Creates and sets up the bulwark, syncs the box global to all machines.
	Also adds the desired number of medkits

	Executed from ""

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_prepareBulwarkServer;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

// create bulwark
bulwarkBox = createVehicle ["B_supplyCrate_F", [0,0,0], [], 0, "NONE"];
publicVariable "bulwarkBox";

clearItemCargoGlobal bulwarkBox;
clearWeaponCargoGlobal bulwarkBox;
clearMagazineCargoGlobal bulwarkBox;
clearBackpackCargoGlobal bulwarkBox;
bulwarkBox allowDamage false;

private _bulwarkLaptop = createVehicle ["Land_Laptop_device_F", [0,0,0], [], 0, "NONE"];
_bulwarkLaptop allowDamage false;
_bulwarkLaptop setObjectTextureGlobal [0,"preview.paa"];
//[_bulwarkLaptop,[0,"preview.paa"]] remoteExec ["setObjectTexture",BLWK_allPlayersTargetID,true];
_bulwarkLaptop attachTo [bulwarkBox, [0,0.1,0.6]];
_bulwarkLaptop setDir 180;

// add medkits
if (BLWK_numMedKits > 0) then {
	bulwarkBox addItemCargoGlobal ["Medikit", BLWK_numMedKits];
};
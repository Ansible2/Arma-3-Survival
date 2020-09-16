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

// usue nearObjects to get the buildings around bulwark, much faster


// push player relavent actions and the loop to show the bulwark icon
[bulwarkBox] remoteExec ["BLWK_fnc_prepareBulwarkPlayer",BLWK_allPlayersTargetID,true];

// add medkits
if (BLWK_numMedKits > 0) then {
	bulwarkBox addItemCargoGlobal ["Medikit", BLWK_numMedKits];
};
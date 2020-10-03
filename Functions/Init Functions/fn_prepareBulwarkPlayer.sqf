/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareBulwarkPlayer

Description:
	Creates the bulwark icon on the player's screen
	Adds actions for the bulwark manipulation
	Adds an event to tell players how to make medkits with it

	Executed from "BLWK_fnc_preparePlayArea"

Parameters:
	0: _bulwark : <OBJECT> - The bulwark

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_prepareBulwarkPlayer;

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
//CIPHER COMMENT: it might be better to just have a waitUntil{!isNil "bulwarkBox"} from the publicvar and put this in the initPlayerLocal

if (!canSuspend) exitWith {};

params ["_bulwark"];

if (!hasInterface) exitWith {bulwarkBox = _bulwark};

//CIPHER COMMENT: maybe make these into hold actions
_bulwark addAction [ 
	"<t color='#ff0000'>-- Heal Yourself 500p --</t>",  
	{
		null = [_this select 1] spawn BLWK_fnc_healPlayer;
	}, 
	nil, 
	1,  
	true,  
	false,  
	"", 
	"", 
	2.5 
];
_bulwark addAction [ 
	"<t color='#00ff00'>-- Open Shop --</t>",  
	{
		null = [] spawn BLWK_fnc_openShopGUI;
	}, 
	nil, 
	1.5,  
	true,  
	false,  
	"", 
	"", 
	2.5 
];

[_bulwark] call BLWK_fnc_addBuildObjectActions;


_bulwark addEventHandler ["ContainerOpened",{
	params ["_bulwark"];
	if !(BLWK_dontUseRevive) then {
		hint "You can place 15 First Aid Kits in the Bulwark to make automatically make a Medkit";
		// only show once
		_bulwark removeEventHandler ["ContainerOpened",_thisEventHandler];
	};
}];
// start and end medkit check loop on server when openned and closed
_bulwark addEventHandler ["ContainerOpened",{
	if !(BLWK_dontUseRevive) then {
		player setVariable ["BLWK_lookingInBulwark",true,2];
		remoteExec ["BLWK_fnc_faksToMedkitLoop",2];
	};
}];
_bulwark addEventHandler ["ContainerClosed",{
	if !(BLWK_dontUseRevive) then {
		player setVariable ["BLWK_lookingInBulwark",false,2];
	};
}];


// hosted server will already have it defined
if (isNil "bulwarkBox") then {
	bulwarkBox = _bulwark;
};

// drawing bulwark icon
waitUntil {!isNil "bulWarkBox"};
addMissionEventHandler [{
	drawIcon3D ["", [1,1,1,0.5], (getPosATLVisual bulwarkBox) vectorAdd [0, 0, 1.5], 1, 1, 0, "Bulwark", 0, 0.04, "RobotoCondensed", "center", true];
}];
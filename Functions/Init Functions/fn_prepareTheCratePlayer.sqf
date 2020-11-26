/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareTheCratePlayer

Description:
	Creates The Crate icon on the player's screen
	Adds actions for the The Crate's manipulation
	Adds an event to tell players how to make medkits with it

	Executed from "BLWK_fnc_preparePlayArea"

Parameters:
	0: _mainCrate : <OBJECT> - The Crate

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_prepareTheCratePlayer;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
//CIPHER COMMENT: it might be better to just have a waitUntil{!isNil "BLWK_mainCrate"} from the publicvar and put this in the initPlayerLocal

if (!canSuspend) exitWith {};

params ["_mainCrate"];

if (!hasInterface) exitWith {BLWK_mainCrate = _mainCrate};

//CIPHER COMMENT: maybe make these into hold actions
_mainCrate addAction [ 
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
_mainCrate addAction [ 
	"<t color='#00ff00'>-- Open Shop --</t>",  
	{
		call BLWK_fnc_openShop;
	}, 
	nil, 
	1000,  
	true,  
	false,  
	"", 
	"", 
	2.5 
];

[_mainCrate] call BLWK_fnc_addBuildableObjectActions;


_mainCrate addEventHandler ["ContainerOpened",{
	params ["_mainCrate"];
	if !(BLWK_dontUseRevive) then {
		
		hint (format ["You can place %1 First Aid Kits in the The Crate to make automatically make a Medkit",BLWK_faksToMakeMedkit]);
		// only show once
		_mainCrate removeEventHandler ["ContainerOpened",_thisEventHandler];
	};
}];
// start and end medkit check loop on server when openned and closed
_mainCrate addEventHandler ["ContainerOpened",{
	if !(BLWK_dontUseRevive) then {
		player setVariable ["BLWK_lookingInTheCrate",true,2];
		remoteExec ["BLWK_fnc_faksToMedkitLoop",2];
	};
}];
_mainCrate addEventHandler ["ContainerClosed",{
	if !(BLWK_dontUseRevive) then {
		player setVariable ["BLWK_lookingInTheCrate",false,2];
	};
}];


// hosted server will already have it defined
if (isNil "BLWK_mainCrate") then {
	BLWK_mainCrate = _mainCrate;
};

addMissionEventHandler ["Draw3D",{
	drawIcon3D ["", [1,1,1,0.5], (getPosATLVisual BLWK_mainCrate) vectorAdd [0, 0, 1.5], 1, 1, 0, "The Crate", 0, 0.04, "RobotoCondensed", "center", true];
}];
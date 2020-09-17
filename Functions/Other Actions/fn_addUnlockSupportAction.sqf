/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addUnlockSupportAction

Description:
	Adds the action to unlock the bulwark support menu

	Executed from ""

Parameters:
	0: _satelliteDish : <OBJECT> - The dish to add the action to

Returns:
	NOTHING

Examples:
    (begin example)

		[mySatDish] call BLWK_fnc_addUnlockSupportAction;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params ["_satelliteDish"];

if (isNull _satelliteDish) exitWith {};

// CIPHER COMMENT: may be a dirty edit, but don't really want anything else on this...
removeAllActions _satelliteDish;

_satelliteDish addAction [ 
	"<t color='#ff00ff'>-- Unlock Support Menu --</t>",  
	{
		missionNamespace setVariable ["BLWK_supportDish",nil,true];
		missionNamespace setVariable ["BLWK_supportDishFound",true,true];
		
		private _onlyPlayers = call CBAP_fnc_players;
		["TaskAssigned",["Support","Support Menu Unlocked at Bulwark Box"]] remoteExec ["BIS_fnc_showNotification",_onlyPlayers];
		["comNoise"] remoteExec ["playSound",_onlyPlayers];

		[BLWK_pointsForKill * 20] call BLWK_fnc_addPoints;

		deleteVehicle (_this select 0);
	}, 
	nil, 
	1,  
	true,  
	false,  
	"", 
	"", 
	2.5 
];
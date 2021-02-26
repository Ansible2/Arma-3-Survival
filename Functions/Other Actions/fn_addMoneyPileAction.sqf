/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addMoneyPileAction

Description:
	Adds the action to get the points from a money pile.

	Executed from "BLWK_fnc_spawnLoot"

Parameters:
	0: _moneyPile : <OBJECT> - The pile of money to add the action to

Returns:
	NOTHING

Examples:
    (begin example)

		[moneyPile] call BLWK_fnc_addMoneyPileAction;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params ["_moneyPile"];

if (isNull _moneyPile) exitWith {};

// CIPHER COMMENT: may be a dirty edit, but don't really want anything else on this...
removeAllActions _moneyPile;

_moneyPile addAction [ 
	"<t color='#00ff00'>-- Collect Points --</t>",  
	{
		missionNamespace setVariable ["BLWK_moneyPile",nil,true];
		["pointsLootSound"] remoteExecCall ["playSound",(call CBAP_fnc_players)];
		[30 * BLWK_pointsForKill] call BLWK_fnc_addPoints;

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
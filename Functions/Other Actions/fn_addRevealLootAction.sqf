/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addRevealLootAction

Description:
	Adds the action to the weapon box to... spin it... imagine that...

	Executed from ""

Parameters:
	0: _randomWeaponBox : <OBJECT> - The box to add the action to

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_addRevealLootAction;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params ["_lootRevealBox"];

if (isNull _lootRevealBox) exitWith {};

// CIPHER COMMENT: may be a dirty edit, but don't really want anything else on this...
removeAllActions _lootRevealBox;

_lootRevealBox addAction [ 
	"<t color='#ff00ff'>-- Reveal Loot Locations --</t>",  
	{
		["IntelAdded",["Loot locations added to map"]] remoteExec ["BIS_fnc_showNotification",(call CBAP_fnc_players),true];
		missionNamespace setVariable ["BLWK_lootRevealerBox",nil,true];
		remoteExec ["BLWK_fnc_createLootMarkers",2];

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
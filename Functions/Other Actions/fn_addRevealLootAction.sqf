/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addRevealLootAction

Description:
	Adds the action to the box that adds loot location markers to the map

	Executed from "BLWK_fnc_spawnLoot"

Parameters:
	0: _lootRevealBox : <OBJECT> - The box to add the action to

Returns:
	NOTHING

Examples:
    (begin example)

		[myBox] spawn BLWK_fnc_addRevealLootAction;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params ["_lootRevealBox"];

if (isNull _lootRevealBox) exitWith {};

// CIPHER COMMENT: may be a dirty edit, but don't really want anything else on this...
removeAllActions _lootRevealBox;

waitUntil {!isNil "BLWK_multipleLootReveals"};


if (BLWK_multipleLootReveals) then {
	_lootRevealBox addAction [ 
		"<t color='#29a318'>-- Reveal Equipment Locations --</t>",  
		{
			["IntelAdded",["Equipment Locations Added To Map"]] remoteExec ["BIS_fnc_showNotification",(call CBAP_fnc_players)];
			[["headgear","backpack","uniform","vest"]] remoteExec ["BLWK_fnc_createLootMarkers",2];

			// delete box
			missionNamespace setVariable ["BLWK_lootRevealerBox",nil,true];
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
	_lootRevealBox addAction [ 
		"<t color='#fa05c1'>-- Reveal Weapon Locations --</t>",  
		{
			["IntelAdded",["Weapon Locations Added To Map"]] remoteExec ["BIS_fnc_showNotification",(call CBAP_fnc_players)];
			[["weapon"]] remoteExec ["BLWK_fnc_createLootMarkers",2];

			// delete box
			missionNamespace setVariable ["BLWK_lootRevealerBox",nil,true];
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
	_lootRevealBox addAction [ 
		"<t color='#b09c45'>-- Reveal Item Locations --</t>",  
		{
			["IntelAdded",["Item Locations Added To Map"]] remoteExec ["BIS_fnc_showNotification",(call CBAP_fnc_players)];
			[["item"]] remoteExec ["BLWK_fnc_createLootMarkers",2];

			// delete box
			missionNamespace setVariable ["BLWK_lootRevealerBox",nil,true];
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
	_lootRevealBox addAction [ 
		"<t color='#0563fa'>-- Reveal Ammo Locations --</t>",  
		{
			["IntelAdded",["Ammo Locations Added To Map"]] remoteExec ["BIS_fnc_showNotification",(call CBAP_fnc_players)];
			[["magazine"]] remoteExec ["BLWK_fnc_createLootMarkers",2];

			// delete box
			missionNamespace setVariable ["BLWK_lootRevealerBox",nil,true];
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
	_lootRevealBox addAction [ 
		"<t color='#696969'>-- Reveal Unique Item Locations --</t>",  // random hex I promise
		{
			["IntelAdded",["Unique item Locations Added To Map"]] remoteExec ["BIS_fnc_showNotification",(call CBAP_fnc_players)];
			[["unique"]] remoteExec ["BLWK_fnc_createLootMarkers",2];

			// delete box
			missionNamespace setVariable ["BLWK_lootRevealerBox",nil,true];
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
} else {
	_lootRevealBox addAction [ 
		"<t color='#ff00ff'>-- Reveal Loot Locations --</t>",  
		{
			["IntelAdded",["Loot Locations Added To Map"]] remoteExec ["BIS_fnc_showNotification",(call CBAP_fnc_players)];
			missionNamespace setVariable ["BLWK_lootRevealerBox",nil,true];
			[["all"]] remoteExec ["BLWK_fnc_createLootMarkers",2];
			
			// delete box
			missionNamespace setVariable ["BLWK_lootRevealerBox",nil,true];
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
};
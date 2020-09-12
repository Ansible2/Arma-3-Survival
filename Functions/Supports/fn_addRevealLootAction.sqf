if (!hasInterface) exitWith {};

params ["_lootRevealBox"];

if (isNull _lootRevealBox) exitWith {};

// CIPHER COMMENT: may be a dirty edit, but don't really want anything else on this...
removeAllActions _lootRevealBox;

_lootRevealBox addAction [ 
	"<t color='#ff00ff'>-- Reveal Loot Locations --</t>",  
	{
		["IntelAdded",["Loot locations added to map"]] remoteExec ["BIS_fnc_showNotification",BLWK_allPlayersTargetID,true];
		remoteExec ["BLWK_fnc_createLootMarkers",2];
	}, 
	nil, 
	1,  
	true,  
	false,  
	"", 
	"", 
	2.5 
];
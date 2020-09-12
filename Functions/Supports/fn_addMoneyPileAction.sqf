if (!hasInterface) exitWith {};

params ["_moneyPile"];

if (isNull _moneyPile) exitWith {};

// CIPHER COMMENT: may be a dirty edit, but don't really want anything else on this...
removeAllActions _moneyPile;

_moneyPile addAction [ 
	"<t color='#00ff00'>-- Collect Points --</t>",  
	{
		missionNamespace setVariable ["BLWK_moneyPile",nil,true];
		[50 * BLWK_pointsForKill] call BLWK_fnc_addPoints;

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
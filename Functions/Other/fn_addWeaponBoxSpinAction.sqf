if (!hasInterface) exitWith {};

params ["_randomWeaponBox"];

if (isNull _randomWeaponBox) exitWith {};

_randomWeaponBox addAction [ 
	"<t color='#FF0000'>-- Spin The Box --</t>",  
	{
		null = [] spawn BLWK_fnc_spinRandomWeaponBox; 
	}, 
	nil, 
	100,  
	true,  
	false,  
	"", 
	"!(missionNamespace getVariable ['BLWK_randomWeaponBoxInUse',false])", 
	2.5 
];
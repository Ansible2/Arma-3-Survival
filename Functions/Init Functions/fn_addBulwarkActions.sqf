if (hasInterface) exitWith {};

params ["_bulwark"];

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
		[_this select 1] spawn bulwark_fnc_purchaseGui;
	}, 
	nil, 
	1.5,  
	true,  
	false,  
	"", 
	"", 
	2.5 
];
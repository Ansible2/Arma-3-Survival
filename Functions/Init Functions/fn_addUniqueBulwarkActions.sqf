if (!hasInterface) exitWith {};

//CIPHER COMMENT: maybe make these into hold actions
bulwarkBox addAction [ 
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

bulwarkBox addAction [ 
	"<t color='#ff0000'>-- Heal Yourself 500p --</t>",  
	{
		call BLWK_fnc_healPlayer;
	}, 
	nil, 
	1,  
	true,  
	false,  
	"", 
	"", 
	2.5 
];

bulwarkBox addAction [ 
	"<t color='#ff0000'>-- Heal Yourself 500p --</t>",  
	{
		call BLWK_fnc_healPlayer;
	}, 
	nil, 
	1,  
	true,  
	false,  
	"", 
	"", 
	2.5 
];
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addBuildableObjectActions

Description:
	Adds all the actions to an object in order to manipulate it in the world.

	Executed from "BLWK_fnc_purchaseObject"

Parameters:
	0: _object : <OBJECT> - The object to add the actions to

Returns:
	BOOL

Examples:
    (begin example)

		[myObject] call BLWK_fnc_addBuildableObjectActions;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {false};

params [
	["_object",objNull,[objNull]]
];

if (isNull _object) exitWith {false};

// CIPHER COMMENT: maybe make sell into a hold action?
// sell object
if (!_object isEqualTo bulwarkBox AND {!(_object isEqualTo BLWK_randomWeaponBox)}) then {
	_object addAction [ 
		"<t color='#ff0000'>-- Sell Object Back --</t>",  
		{
			params ["_object","_caller"];

			if (_object isEqualTo bulwarkBox OR {(_object isEqualTo BLWK_randomWeaponBox)}) exitWith {
				hint "You can't sell this item";
			};

			[_object,_caller] call BLWK_fnc_sellObject;
		}, 
		nil, 
		90,  
		false,  
		false,  
		"true", 
		"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
		5 
	];
};

// move up
_object addAction [ 
	"<t color='#00ffff'>-- Move Object Up --</t>",  
	{
		params ["_object"];
		[_object,true] call BLWK_fnc_moveUpOrDown;
	}, 
	nil, 
	95,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	5 
];


// move down
_object addAction [ 
	"<t color='#00ff00'>-- Move Object Down --</t>",  
	{
		params ["_object"];
		[_object,false] call BLWK_fnc_moveUpOrDown;
	}, 
	nil, 
	94,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	5 
];

// pick up
_object addAction [ 
	"<t color='#ffffff'>-- Pickup Object --</t>",  
	{
		params ["_object","_caller"];
		[_object,_caller] call BLWK_fnc_pickupObject;
	}, 
	nil, 
	100,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	5 
];

// rotate left
_object addAction [
	"<t color='#ff00bf'>-- Rotate Object Left --</t>",
	{
		params ["_object"];
		[_object,false] call BLWK_fnc_rotateObject;
	},
	_object,
	92,
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	5
];

// rotate right
_object addAction [
	"<t color='#7e33ff'>-- Rotate Object Right --</t>",
	{
		params ["_object"]
		[_object,true] call BLWK_fnc_rotateObject;
	},
	nil,
	93,
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	5
];

// Reset Rotation
_object addAction [ 
	"<t color='#ffff00'>-- Reset Object Rotation --</t>",  
	{
		params ["_object"];
		[_object] call BLWK_fnc_resetObjectRotation;
	}, 
	nil, 
	91,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	5
];


true
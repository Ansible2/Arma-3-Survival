/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addBuildableObjectActions

Description:
	Adds all the actions to an object in order to manipulate it in the world.

	Executed from ""

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

// sell object
_object addAction [ 
	"<t color='#ff0000'>-- Sell Object Back --</t>",  
	{
		params ["_objectWithActions","_caller"];
		[_objectWithActions,_caller] call BLWK_fnc_sell;
	}, 
	nil, 
	1,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	5 
];

// move up
_object addAction [ 
	"<t color='#00ffff'>-- Move Up --</t>",  
	{
		params ["_objectWithActions","_caller"];
		[_objectWithActions,_caller,true] call BLWK_fnc_moveUpOrDown;
	}, 
	nil, 
	2,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	5 
];


// move down
_object addAction [ 
	"<t color='#00ff00'>-- Move Down --</t>",  
	{
		params ["_objectWithActions","_caller"];
		[_objectWithActions,_caller,false] call BLWK_fnc_moveUpOrDown;
	}, 
	nil, 
	2,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	5 
];

// pick up
_object addAction [ 
	"<t color='#ffffff'>-- Pickup --</t>",  
	{
		params ["_objectWithActions","_caller"];
		[_objectWithActions,_caller] call BLWK_fnc_pickup;
	}, 
	nil, 
	2,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	5 
];

// reset rotation
_object addAction [ 
	"<t color='#ffffff'>-- Reset Rotation --</t>",  
	{
		params ["_objectWithActions","_caller"];
		[_objectWithActions,_caller] call BLWK_fnc_pickup;
	}, 
	nil, 
	2,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	5 
];

true
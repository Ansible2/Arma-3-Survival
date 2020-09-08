/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addPickedUpObjectActions

Description:
	Adds a number of actions to the player to manipulate a picked up object.
	Why the player? To avoid an inability to perform an action if you are not looking
	at the object.

	Executed from ""

Parameters:
	0: _object : <OBJECT> - The picked up object
	1: _player : <OBJECT> - The person who picked up the object

Returns:
	Nothing

Examples:
    (begin example)

		[myObject,player] call BLWK_fnc_addPickedUpObjectActions;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_object",objNull,[objNull]],
	["_player",player,[objNull]]
];

// drop action
_player addAction [
	"<t color='#ed601f'>-- Drop Object --</t>",
	{
		private _player = _this select 0;
		private _dropCrate_actionID = param [2,0,[123]];
		private _crate = param [3];

		[_crate,_caller,BLWK_dropCurrentObject_actionID] call KISKA_fnc_dropCrate;
	},
	_object,
	100,
	true,
	true
];

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

// rotate left
_player addAction [
	"<t color='#ed601f'>-- Drop Object --</t>",
	{
		
	},
	_object,
	90,
	true,
	true
];

// rotate right
_player addAction [
	"<t color='#ed601f'>-- Drop Object --</t>",
	{
		
	},
	_object,
	91,
	true,
	true
];

BLWK_heldObjectActionIDs = [_dropActionID,_moveUpActionID]
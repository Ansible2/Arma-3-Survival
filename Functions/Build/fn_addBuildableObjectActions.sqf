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

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {false};

params [
	["_object",objNull,[objNull]]
];

if (isNull _object) exitWith {false};

private _objectType = typeOf _object;
private _objectName = [configFile >> "cfgVehicles" >> _objectType] call BIS_fnc_displayName;

private _actionDistance = ((_object call BIS_fnc_boundingBoxDimensions) select 1) + 2;
if (_actionDistance < 5) then {
	_actionDistance = 5;
};


// CIPHER COMMENT: maybe make sell into a hold action?
// sell object
if (!(_object isEqualTo bulwarkBox) AND {!(_object isEqualTo BLWK_randomWeaponBox)}) then {
	_object addAction [ 
		"<t color='#ff0000'>-- Sell " + _objectName + " Back --</t>",  
		{
			params ["_object","_caller"];

			if (_object isEqualTo bulwarkBox OR {(_object isEqualTo BLWK_randomWeaponBox)}) exitWith {
				hint parseText "<t color='#ff0000'>You can't sell this item</t>";
			};

			[_object,_caller] call BLWK_fnc_sellObject;
		}, 
		nil, 
		90,  
		false,  
		false,  
		"true", 
		"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
		_actionDistance 
	];
};

// move up
_object addAction [ 
	"<t color='#00ffff'>-- Move " + _objectName + " Up --</t>",  
	{
		[_this select 0,true] call BLWK_fnc_moveUpOrDown;
	}, 
	nil, 
	95,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	_actionDistance 
];


// move down
_object addAction [ 
	"<t color='#00ff00'>-- Move " + _objectName + " Down --</t>",  
	{
		[_this select 0,false] call BLWK_fnc_moveUpOrDown;
	}, 
	nil, 
	94,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	_actionDistance 
];

// pick up
_object addAction [ 
	"<t color='#ffffff'>-- Pickup " + _objectName + " --</t>",  
	{
		params ["_object","_caller"];
		null = [_object,_caller] spawn BLWK_fnc_pickupObject;
	}, 
	nil, 
	100,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	_actionDistance 
];

// rotate left
_object addAction [
	"<t color='#ffff00'>-- Rotate " + _objectName + " Left --</t>",
	{
		[_this select 0,false] call BLWK_fnc_rotateObject;
	},
	_object,
	92,
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	_actionDistance
];

// rotate right
_object addAction [
	"<t color='#cc33ff'>-- Rotate " + _objectName + " Right --</t>",
	{
		[_this select 0,true] call BLWK_fnc_rotateObject;
	},
	nil,
	93,
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	_actionDistance
];

// Reset Rotation
_object addAction [ 
	"<t color='#ff00bf'>-- Reset " + _objectName + " Rotation --</t>",  
	{
		[_this select 0] call BLWK_fnc_resetObjectRotation;
	}, 
	nil, 
	91,  
	false,  
	false,  
	"true", 
	"!(_originalTarget getVariable ['BLWK_objectPickedUp',false])", 
	_actionDistance
];


true
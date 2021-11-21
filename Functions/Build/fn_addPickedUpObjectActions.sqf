#include "..\..\Headers\Build Objects Properties Defines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addPickedUpObjectActions

Description:
	Adds a number of actions to the player to manipulate a picked up object.
	Why the player? To avoid an inability to perform an action if you are not looking
	at the object.

	Executed from "BLWK_fnc_pickUpObject"

Parameters:
	0: _object : <OBJECT> - The picked up object
	1: _player : <OBJECT> - The person who picked up the object

Returns:
	Nothing

Examples:
    (begin example)
		[myObject,player] call BLWK_fnc_addPickedUpObjectActions;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_object",objNull,[objNull]],
	["_player",player,[objNull]]
];

private _objectType = toLowerANSI (typeOf _object);
private _objectName = "";
switch (true) do {
	case (_object isEqualTo BLWK_randomWeaponBox):{
		_objectName = "Random Weapon Box";
	};
	case (_object isEqualTo BLWK_mainCrate):{
		_objectName = "The Main Crate";
	};
	default {
		_objectName = (BLWK_buildableObjectsHash get _objectType) select DISPLAY_NAME;
	};
};


// place object snap to
private _snaptoActionID = _player addAction [
	"<t color='#4287f5'>-- Snap " + _objectName + " To Surface --</t>",
	{
		private _object = _this select 3;
		[_object,true] call BLWK_fnc_placeObject;
	},
	_object,
	97,
	true,
	true
];

// place object floating
private _placeActionID = _player addAction [
	"<t color='#ed601f'>-- Place " + _objectName + " (Floating) --</t>",
	{
		private _object = _this select 3;
		[_object,false] call BLWK_fnc_placeObject;
	},
	_object,
	96,
	true,
	true
];

private _sellActionID = -1;
if ((_object isNotEqualTo BLWK_mainCrate) AND {_object isNotEqualTo BLWK_randomWeaponBox}) then {
	// sell object
	_sellActionID = _player addAction [ 
		"<t color='#ff0000'>-- Sell (In Hand) " + _objectName + " Back --</t>",  
		{
			private _object = _this select 3;
			[_object] call BLWK_fnc_sellObject;
		}, 
		_object, 
		90,  
		true,  
		false
	];
};

// move up
private _moveUpActionID = _player addAction [ 
	"<t color='#00ffff'>-- Move Up (In Hand) " + _objectName + " --</t>",  
	{
		private _player = _this select 1;
		private _object = _this select 3;

		[_object,true,true,_player] call BLWK_fnc_moveUpOrDown;
	}, 
	_object, 
	95,  
	true,  
	false 
];

// move down
private _moveDownActionID = _player addAction [ 
	"<t color='#00ff00'>-- Move Down (In Hand) " + _objectName + " --</t>",  
	{
		private _player = _this select 1;
		private _object = _this select 3;
		
		[_object,false,true,_player] call BLWK_fnc_moveUpOrDown;
	}, 
	_object, 
	94,  
	true,  
	false
];

// rotate left
private _rotateLeftActionID = _player addAction [
	"<t color='#ffff00'>-- Rotate Left (In Hand) " + _objectName + " --</t>",
	{
		private _player = _this select 1;
		private _object = _this select 3;

		[_object,false,true,_player] call BLWK_fnc_rotateObject;
	},
	_object,
	92,
	true,
	false
];

// rotate right
private _rotateRightActionID = _player addAction [
	"<t color='#cc33ff'>-- Rotate Right (In Hand) " + _objectName + " --</t>",
	{
		private _player = _this select 1;
		private _object = _this select 3;

		[_object,true,true,_player] call BLWK_fnc_rotateObject;
	},
	_object,
	93,
	true,
	false
];

// Reset Rotation
private _resetRotationActionID = _player addAction [ 
	"<t color='#ff00bf'>-- Reset Rotation (In Hand) " + _objectName + " --</t>",  
	{
		private _object = _this select 3;
		[_object] call BLWK_fnc_resetObjectRotation;
	}, 
	_object, 
	91,  
	true,  
	false
];


// this is used to remove them all at once when the object is placed down
BLWK_heldObjectActionIDs = [
	_snaptoActionID,
	_placeActionID,
	_sellActionID,
	_moveUpActionID,
	_moveDownActionID,
	_rotateLeftActionID,
	_rotateRightActionID,
	_resetRotationActionID
];
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

// place object snap to
private _snaptoActionID = _player addAction [
	"<t color='#00ffff'>-- Drop Object (Snap To Ground) --</t>",
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
	"<t color='#ed601f'>-- Place Object (Floating) --</t>",
	{
		private _object = _this select 3;
		[_object,false] call BLWK_fnc_placeObject;
	},
	_object,
	96,
	true,
	true
];

// sell object
private _sellActionID = _player addAction [ 
	"<t color='#ff0000'>-- Sell Object Back --</t>",  
	{
		private _player = _this select 0;
		private _object = _this select 3;

		
	}, 
	_object, 
	90,  
	true,  
	false
];

// move up
private _moveUpActionID = _player addAction [ 
	"<t color='#00ffff'>-- Move Up --</t>",  
	{
		private _player = _this select 0;
		private _object = _this select 3;

		[_objectWithActions,_caller,true] call BLWK_fnc_moveUpOrDown;
	}, 
	_object, 
	95,  
	true,  
	false 
];

// move down
private _moveDownActionID = _player addAction [ 
	"<t color='#00ff00'>-- Move Down --</t>",  
	{
		private _player = _this select 0;
		private _object = _this select 3;
		
		[_objectWithActions,_caller,false] call BLWK_fnc_moveUpOrDown;
	}, 
	_object, 
	94,  
	true,  
	false
];

// rotate left
private _rotateLeftActionID = _player addAction [
	"<t color='#ff00bf'>-- Rotate Left --</t>",
	{
		private _player = _this select 1;
		private _object = _this select 3;

	},
	_object,
	92,
	true,
	false
];

// rotate right
private _rotateRightActionID = _player addAction [
	"<t color='#7e33ff'>-- Rotate Right --</t>",
	{
		private _player = _this select 1;
		private _object = _this select 3;

	},
	_object,
	93,
	true,
	false
];

// Reset Rotation
private _resetRotationActionID = _player addAction [ 
	"<t color='#ffff00'>-- Reset Rotation --</t>",  
	{
		private _player = _this select 0;
		private _object = _this select 3;

		[]
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
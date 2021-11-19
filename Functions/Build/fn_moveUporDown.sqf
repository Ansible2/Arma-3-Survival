#include "..\..\Headers\Wait For Transfer Inline.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_moveUpOrDown

Description:
	Moves and object up or down based on an increment.

Parameters:
	0: _object : <OBJECT> - The object to move
	1: _downOrUp : <BOOL> - True to move up, false to move down
	2: _beingCarried : <BOOL> - Is this object in the player's hand
	3: _player : <OBJECT> - if _beingCarried is true, this is the person who it will be attached to

Returns:
	NOTHING

Examples:
    (begin example)

		// move down while on the ground
		[myObject,false] call BLWK_fnc_moveUpOrDown;
		
		// move up while in the player's hands
		[myObject,true,true,player] call BLWK_fnc_moveUpOrDown;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define MOVEMENT_INCREMENT 0.25

if (!hasInterface) exitWith {};

params [
	"_object",
	["_downOrUp",false,[true]],
	["_beingCarried",false,[true]],
	["_personCarrying",player,[objNull]]
];

// wait until the object is local to execute movement commands
WAIT_FOR_OWNERSHIP(_object)

private _objectPosition = getPosWorld _object;
private _increment = [-MOVEMENT_INCREMENT,MOVEMENT_INCREMENT] select _downOrUp;
private _newPosition = _objectPosition vectorAdd [0,0,_increment];

if (_beingCarried) then {
	_object setPosWorld _newPosition;
	_object attachTo [_personCarrying];
} else {
	private _currentVectorUp = vectorUpVisual _object;
	private _currentVectorDir = vectorDirVisual _object;
	[_object,[_currentVectorDir,_currentVectorUp]] remoteExecCall ["setVectorDirAndUp",_object];
	_object setPosWorld _newPosition;
};
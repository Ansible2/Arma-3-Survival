#include "..\..\Headers\Wait For Transfer Inline.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_rotateObject

Description:
	Rotates an object either left or right while keeping it's vectorUp intact

	Executed from "BLWK_fnc_addBuildableObjectActions" & "BLWK_fnc_addPickedUpObjectActions"

Parameters:
	0: _object : <OBJECT> - The object to rotate
	1: _direction : <BOOL> - The direction to rotate: false = couter-clockwise, true = clockwise
	2: _beingCarried : <BOOL> - Is this object in the player's hand
	3: _player : <OBJECT> - if _beingCarried is true, this is the person who it will be attached to

Returns:
	NOTHING

Examples:
    (begin example)

		// rotate couter-clockwise
		[myObject,false] call BLWK_fnc_rotateObject;
		
		// rotate clockwise while the player is carrying the object
		[myObject,true,true,player] call BLWK_fnc_rotateObject;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define ROTATION_INCREMENT 15

if (!hasInterface) exitWith {};

params [
	"_object",
	"_direction",
	["_beingCarried",false,[true]],
	["_player",player,[objNull]]
];

WAIT_FOR_OWNERSHIP(_object)

private _currVectDir = vectorDir _object;
private _currVectUp = vectorUp _object;
// rotate clockwise if true
// this means we are either adding or subtracting 10 degrees from the current angle
private _addToAngle = [ROTATION_INCREMENT,-ROTATION_INCREMENT] select _direction;

private _newVector = [_currVectDir,_currVectUp,_addToAngle] call CBAP_fnc_vectRotate3D;


if (_beingCarried) then {
	[_object,[_player vectorWorldToModelVisual _newVector,_currVectUp]] remoteExecCall ["setVectorDirAndUp",_object];
} else {
	[_object,[_newVector,_currVectUp]] remoteExecCall ["setVectorDirAndUp",_object];
};
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_moveUpOrDown

Description:
	Moves and object up or down based on an incriment

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

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params [
	"_object",
	["_downOrUp",false,[true]],
	["_beingCarried",false,[true]],
	["_player",player,[objNull]]
];

#define MOVEMENT_INCRIMENT 0.25

if (_beingCarried) then {
	detach _object;
};

private _objectPosition = getPosWorldVisual _object;
private _currentVectorUp = vectorUpVisual _object;
private _currentVectorDir = vectorDirVisual _object;

private _incriment = [-MOVEMENT_INCRIMENT,MOVEMENT_INCRIMENT] select _downOrUp;
private _newPosition = _objectPosition vectorAdd [0,0,_incriment];
_object setPosWorld _newPosition;

[_object,[_currentVectorDir,_currentVectorUp]] remoteExecCall ["setVectorDirAndUp",_object];
if (_beingCarried) then {
	[_object,_player,true] call BIS_fnc_attachToRelative;
};
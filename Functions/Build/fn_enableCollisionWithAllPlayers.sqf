/* ----------------------------------------------------------------------------
Function: BLWK_fnc_enableCollisionWithAllPlayers

Description:
	Disables collision with all players on an object that 

	Executed from "BLWK_fnc_pickUpObject"

Parameters:
	0: _object : <OBJECT> - The object to disable collision with

Returns:
	NOTHING

Examples:
    (begin example)

		null = [myObject] remoteExec ["BLWK_fnc_enableCollisionWithAllPlayers",myObject];

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_object"];

if (!local _object) exitWith {
	null = [_object] remoteExec ["BLWK_fnc_enableCollisionWithAllPlayers",_object];
};

if (!canSuspend) exitWith {
	"Must be run in scheduled environment" call BIS_fnc_error;
};

private _players = call CBAP_fnc_players;

private _objectDimensions = _object call BIS_fnc_boundingBoxDimensions;
private _objectDimensions_X = _objectDimensions select 0;
private _objectDimensions_Y = _objectDimensions select 1;
private _objectDimensions_Z = _objectDimensions select 2;

// make sure a player is not colliding with the object before enabling their collsiion
_players apply {
	// check if the
	waitUntil {
		if !(_x inArea [_object, _objectDimensions_X, _objectDimensions_Y, 0, true, _objectDimensions_Z]) exitWith {true};
		sleep 0.5;
		false
	};

	null = [_object,_x] remoteExecCall ["enableCollisionWith",_x];
	_object enableCollisionWith _x;
};
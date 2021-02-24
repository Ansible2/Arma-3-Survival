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

		[myObject] remoteExec ["BLWK_fnc_enableCollisionWithAllPlayers",myObject];

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "BLWK_fnc_enableCollisionWithAllPlayers"
scriptName SCRIPT_NAME;

if (!canSuspend) exitWith {
	["Executed in unscheduled environment, execing in scheduled",true] call KISKA_fnc_log;
	_this spawn BLWK_fnc_enableCollisionWithAllPlayers;
};


params ["_object"];

if (!local _object) exitWith {
	[["Found that object ",_object," was not local. RemoteExecing to owner"],false] call KISKA_fnc_log;
	[_object] remoteExec ["BLWK_fnc_enableCollisionWithAllPlayers",_object];
};


private _players = call CBAP_fnc_players;

private _objectDimensions = _object call BIS_fnc_boundingBoxDimensions;
private _objectDimensions_X = _objectDimensions select 0;
private _objectDimensions_Y = _objectDimensions select 1;
private _objectDimensions_Z = _objectDimensions select 2;

// make sure a player is not colliding with the object before enabling their collsiion
_players apply {
	waitUntil {
		if !(_x inArea [_object, _objectDimensions_X, _objectDimensions_Y, 0, true, _objectDimensions_Z]) exitWith {true};
		sleep 0.5;
		false
	};

	[_object,_x] remoteExecCall ["enableCollisionWith",_x];
	_object enableCollisionWith _x;
};
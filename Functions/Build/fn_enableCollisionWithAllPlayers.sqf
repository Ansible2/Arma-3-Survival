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

		null = [myObject] remoteExecCall ["BLWK_fnc_enableCollisionWithAllPlayers",myObject];

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_object"];

if (!local _object) exitWith {
	null = [_object] remoteExecCall ["BLWK_fnc_enableCollisionWithAllPlayers",_object];
};

private _players = call CBAP_fnc_players;

_players apply {
	null = [_object,_x] remoteExecCall ["enableCollisionWith",_x];
	_object enableCollisionWith _x;
};
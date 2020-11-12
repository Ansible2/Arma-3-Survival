/* ----------------------------------------------------------------------------
Function: BLWK_fnc_disableCollisionWithAllPlayers

Description:
	Disables collision with all players on an object that 

	Executed from "BLWK_fnc_pickUpObject"

Parameters:
	0: _object : <OBJECT> - The object to disable collision with

Returns:
	NOTHING

Examples:
    (begin example)

		null = [myObject] remoteExec ["BLWK_fnc_disableCollisionWithAllPlayers",myObject];

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_object"];

if (!local _object) exitWith {
	null = [_object] remoteExec ["BLWK_fnc_disableCollisionWithAllPlayers",_object];
};

private _players = call CBAP_fnc_players;

_players apply {
	if !(_x isEqualTo (attachedTo _object)) then {
		null = [_object,_x] remoteExecCall ["disableCollisionWith",_x];
		_object disableCollisionWith _x;
	};
};
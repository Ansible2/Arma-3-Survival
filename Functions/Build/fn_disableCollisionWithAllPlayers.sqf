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
#define SCRIPT_NAME "BLWK_fnc_disableCollisionWithAllPlayers";
scriptName SCRIPT_NAME;

params ["_object"];

if !(local _object) exitWith {
	[SCRIPT_NAME,["Found that object",_object,"was not local. RemoteExecing to owner"],true,false,true] call KISKA_fnc_log;
	null = [_object] remoteExec ["BLWK_fnc_disableCollisionWithAllPlayers",_object];
};

if (!canSuspend) exitWith {
	[SCRIPT_NAME,"Executed in unscheduled environment, execing in scheduled",false,false,true] call KISKA_fnc_log;
	_this spawn BLWK_fnc_disableCollisionWithAllPlayers;
};

private _players = call CBAP_fnc_players;

_players apply {
	// don't execute onto whoever is holding the object
	if !(_x isEqualTo (attachedTo _object)) then {
		sleep 0.1;
		null = [_object,_x] remoteExecCall ["disableCollisionWith",_x];
		_object disableCollisionWith _x;
	};
};
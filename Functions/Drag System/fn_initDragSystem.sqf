/* ----------------------------------------------------------------------------
Function: BLWK_fnc_initDragSystem

Description:
	Initializes the drag system for a player. 
	Essentially gives all other players the ability to drag the local player

	Executed from "initPlayerLocal.sqf" & "onPlayerRespawn.sqf"

Parameters:
	0: _player : <OBJECT> - The player object

Returns:
	NOTHING

Examples:
    (begin example)

		[player] call BLWK_fnc_initDragSystem;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface OR {BLWK_dontUseRevive}) exitWith {};

params [
	["_player",player,[objNull]]
];
// add a drag action to every player to be able to drag you
// the action will have a condition to keep it from always being shown
[_player] remoteExec ["BLWK_fnc_addDragAction",BLWK_allClientsTargetID,true];

// add an event handler to remove the action from all machines if you die
[_player] call BLWK_fnc_addDragKilledEh;

// used for reseting animations of player if dragged in BLWK_fnc_handleReviveAfterDrag
BLWK_handleReviveLoopRunning = false;
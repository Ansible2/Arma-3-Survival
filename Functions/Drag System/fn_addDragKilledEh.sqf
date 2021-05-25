/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addDragKilledEh

Description:
	Adds and eventhandler to remove a units drag action from all machines 
	 if the unit is dead.

	Executed from "BLWK_fnc_initDragSystem"

Parameters:
	0: _unit : <OBJECT> - The unit to add the eventhandler to

Returns:
	NOTHING

Examples:
    (begin example)

		[theUnit] call BLWK_fnc_addDragKilledEh;

    (end)

Author(s):
	BangaBob (H8erMaker),
	Modified By: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "BLWK_fnc_addDragKilledEh"
scriptName SCRIPT_NAME;

if (!hasInterface) exitWith {};

if (BLWK_dontUseRevive) exitWith {
	["Vanilla revive is disabled, exiting...",false] call KISKA_fnc_log;
};

params ["_unit"];

if (!local _unit) exitWith {
	[[_unit," is not local, exiting..."]] call KISKA_fnc_log;
};

// CIPHER COMMENT: test the validity of a local event handler here, it may not work if killed by a remote unit
_unit addEventHandler ["KILLED",{
	params ["_body"];
	// tell all players to remove the actions on the dead body
	[_body,_thisEventHandler] remoteExecCall ["BLWK_fnc_removeDragAction",BLWK_allClientsTargetID,_body];
}];
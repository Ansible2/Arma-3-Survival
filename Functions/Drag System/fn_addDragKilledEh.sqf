/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addDragKilledEh

Description:
	Adds and eventhandler to remove a units drag action from all machines if the unit is dead

	Executed from "BLWK_fnc_initDragSystem"

Parameters:
	0: _unit : <OBJECT> - The unit to add the eventhandler to

Returns:
	NOTHING

Examples:
    (begin example)

		[theUnit] call BLWK_fnc_addDragKilledEh;

    (end)

Author:
	BangaBob (H8erMaker),
	Modified By: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface OR {BLWK_dontUseRevive}) exitWith {};

params ["_unit"];

if (!local _unit) exitWith {};

// CIPHER COMMENT: test the validity of a local event handler here, it may not work if killed by a remote unit
_unit addEventHandler ["KILLED",{
	[_this select 0,_thisEventHandler] remoteExecCall ["BLWK_fnc_removeDragAction",BLWK_allClientsTargetID,true];
}];
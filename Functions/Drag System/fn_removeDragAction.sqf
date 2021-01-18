/* ----------------------------------------------------------------------------
Function: BLWK_fnc_removeDragAction

Description:
	Removes the drag action from a unit.
	
	Also removes the unit's KILLED eventhandler.

	Executed from "BLWK_fnc_addDragKilledEh"

Parameters:
	0: _unit : <OBJECT> - The unit to remove the drag action from
	1: _eventHandlerId : <OBJECT> - The KILLED eventhandler id 

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_removeDragAction;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params ["_unit","_eventHandlerId"];

if (local _unit) then {
	_unit removeEventHandler ["KILLED",_eventHandlerId];
};

private _actionId = _unit getVariable "BLWK_dragActionId";
if (!isNil "_actionId") then {
	_unit removeAction _actionId;
};
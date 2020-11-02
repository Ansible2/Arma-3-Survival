/* ----------------------------------------------------------------------------
Function: BLWK_fnc_removeStdEnemyHitEvent

Description:
	Removes the hit event from a given unit after death.

	Executed from "BLWK_fnc_stdEnemyKilledEvent"

Parameters:
	0: _unit : <OBJECT> - The unit (probably dead) to remove the event from

Returns:
	BOOL

Examples:
    (begin example)

		[aUnit] call BLWK_fnc_removeStdEnemyHitEvent;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {false};

params ["_unit"];

private _handlerInfo = _unit getVariable ["BLWK_stdHitEH_info",[]];
if !(_handlerInfo isEqualTo []) then {
	_unit removeEventHandler _handlerInfo;
	true
} else {
	false
};
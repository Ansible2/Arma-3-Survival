/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addStdEnemyManEHs

Description:
	Executes the addEventhandler to all machines for a standard units events.

	Executed from "BLWK_fnc_stdEnemyManCreateCode"

Parameters:
	0: _unit : <OBJECT> - The unit to add the events to

Returns:
	NOTHING

Examples:
    (begin example)

		[aUnit] call BLWK_fnc_addStdEnemyManEHs;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "BLWK_fnc_addStdEnemyManEHs"
scriptName SCRIPT_NAME;

params ["_unit"];

if !(local _unit) exitWith {
	[["Tried to add events to ",_unit," but they are not local. Exiting..."],true] call KISKA_fnc_log;
	false
};

_unit addEventHandler ["Hit",{
	_this call BLWK_fnc_stdEnemyHitEventLocal;
}];

_unit addEventHandler ["Killed",{
	_this call BLWK_fnc_stdEnemyKilledEvent;
}];


true
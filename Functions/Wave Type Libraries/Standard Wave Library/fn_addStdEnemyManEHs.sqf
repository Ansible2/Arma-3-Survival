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

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_unit"];

if (!local _unit) exitWith {false};

// Didn't use MPHit event to avoid the networking of it to every client
[_unit] remoteExecCall ["BLWK_fnc_addStdEnemyHitEH",BLWK_allClientsTargetID,true];

_unit addMPEventHandler ["mpKilled",{
	[_this,_thisEventHandler] call BLWK_fnc_stdEnemyKilledEvent;
}];


true
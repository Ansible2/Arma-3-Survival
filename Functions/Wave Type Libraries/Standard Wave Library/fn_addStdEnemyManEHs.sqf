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
params ["_unit"];

if !(local _unit) exitWith {false};

// CIPHER COMMENT: This may be better off just being a local hit handler that remoteExec's onto the instigator
// It may spam the network in this case
diag_log _unit;
diag_log "add hit";
private _hitEvent = _unit addMPEventHandler ["mpHit",{
	_this call BLWK_fnc_stdEnemyHitEvent;
}];
diag_log "hit added";
// so we can remove it on death of the unit
//_unit setVariable ["BLWK_stdHitEH",_hitEvent];

diag_log "add kill";
_unit addMPEventHandler ["mpKilled",{
	diag_log "kill event";
	[_this,_thisEventHandler] call BLWK_fnc_stdEnemyKilledEvent;
	diag_log _this;
}];
diag_log "kill added";


true
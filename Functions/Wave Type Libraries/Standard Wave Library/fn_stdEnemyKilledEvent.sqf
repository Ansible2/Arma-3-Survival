#include "..\..\..\Headers\String Constants.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stdEnemyKilledEvent

Description:
	Executes the code in the standard enemy man killed event
	 for adding points to players and markers.

	Executed from the event added by "BLWK_fnc_addStdEnemyManEHs"

Parameters:
	0: _eventInfo: <ARRAY> -
		0: _unit : <OBJECT> - Object the event handler is assigned to
		1: _killer : <OBJECT> - Object that killed _unit – contains unit itself in case of collisions (not used)
		2: _instigator : <OBJECT> - Person who pulled the trigger
		3: _useEffects : <BOOL> - same as useEffects in setDamage alt syntax (not used)
		
	1: _handlerID : <NUMBER> - The eventhandler's id number

Returns:
	NOTHING

Examples:
    (begin example)

		[_this,_thisEventhandler] call BLWK_fnc_stdEnemyKilledEvent;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_killedUnit", "_killer", "_instigator", "_useEffects"];

if (!(isNull _instigator) AND {isPlayer _instigator}) then {
	// show a player hit points and add them to there score
	[_killedUnit] remoteExecCall ["BLWK_fnc_handleKillEventPlayer",_instigator];
};

// spawn the next in queue
if (local BLWK_theAIHandlerEntity) then {
	// if the spawn queue is not empty
	if !((missionNamespace getVariable [STANDARD_ENEMY_INFANTRY_QUEUE,[]]) isEqualTo []) then {
		[STANDARD_ENEMY_INFANTRY_QUEUE,"_this call BLWK_fnc_stdEnemyManCreateCode"] call BLWK_fnc_createFromQueue;
	};
};

[[_killedUnit]] remoteExecCall ["removeFromRemainsCollector",2];
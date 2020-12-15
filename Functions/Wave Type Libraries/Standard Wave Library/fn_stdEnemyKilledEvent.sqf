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
params ["_eventInfo","_handlerID"];


// spawn the next in queue
if (local BLWK_theAIHandlerEntity) then {	
	// if the spawn queue is not empty
	if !((missionNamespace getVariable [STANDARD_ENEMY_INFANTRY_QUEUE,[]]) isEqualTo []) then {
		// got CTD if this was run in unscheduled too many times (by wave 15 start)
		[STANDARD_ENEMY_INFANTRY_QUEUE,"_this call BLWK_fnc_stdEnemyManCreateCode"] spawn BLWK_fnc_createFromQueue;
	};
};

private _killedUnit = _eventInfo select 0;
private _instigator = _eventInfo select 2;

if !(isNull _instigator) then {
	// points for players
	if ((hasInterface) AND {local _instigator} AND {isPlayer _instigator}) then {
		private _points = [_killedUnit] call BLWK_fnc_getPointsForKill;
		
		// aircraft gunners get limited points
		if (missionNamespace getVariable ["BLWK_isAircraftGunner",false]) then {
			_points = round (_points / 4);
		};
		[_points] call BLWK_fnc_addPoints;
		[_killedUnit,_points,true] call BLWK_fnc_createHitMarker;
	};
};

if (isServer) then {
	removeFromRemainsCollector [_killedunit];
};

/*
// mp events need to be removed on the unit where they are local
if (local _killedUnit) then {
	_killedUnit removeMPEventHandler ["mpKilled",_handlerID];
	_killedUnit removeMPEventHandler ["mpHit",_killedUnit getVariable "BLWK_stdHitEH"];
};
*/
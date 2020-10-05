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

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_eventInfo","_handlerID"];

private _killedUnit = _eventInfo select 0;
private _instigator = _eventInfo select 2;

// spawn the next in que
if (local BLWK_theAIHandlerEntity) then {
	#include "..\..\..\Headers\String Constants.hpp"
	
	// if the spawn que is not empty
	if !((missionNamespace getVariable [STANDARD_ENEMY_INFANTRY_QUE,[]]) isEqualTo []) then {
		[
			STANDARD_ENEMY_INFANTRY_QUE,
			call BLWK_fnc_stdEnemyManCreateCode
		] call BLWK_fnc_createFromQue;
	};
};

// points for players
if (local _instigator AND {isPlayer _instigator} AND {hasInterface}) then {
	private _points = [_killedUnit] call BLWK_fnc_getPointsForKill;
	[_points] call BLWK_fnc_addPoints;
	[_killedUnit,_points,true] call BLWK_fnc_createHitMarker;
};

[_unit] call BLWK_fnc_removeStdEnemyHitEvent;


// mp events need to be removed on the unit where they are local
if (local _killedUnit) then {
	_killedUnit removeMPEventHandler ["mpKilled",_handlerID];
};
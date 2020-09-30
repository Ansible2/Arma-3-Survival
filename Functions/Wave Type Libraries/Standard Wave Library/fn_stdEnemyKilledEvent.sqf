#include "..\..\..\Headers\Que Strings.hpp"

params ["_eventInfo","_handlerID"];

private _killedUnit = _eventInfo select 0;
private _instigator = _eventInfo select 3;

// spawn the next in que
if (local BLWK_theAIHandler) then {
	
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
	[_killedUnit,_points] call BLWK_fnc_createHitMarker;
	[_points] call BLWK_fnc_addPoints;
};

[_unit] call BLWK_fnc_removeStdUnitsHitEvent;


// mp events need to be removed on the unit where they are local
if (local _killedUnit) then {
	removeMPEventHandler ["mpKilled",_handlerID];
};
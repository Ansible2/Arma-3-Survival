params ["_eventInfo","_handlerID"];

private _killedUnit = _eventInfo select 0;
private _instigator = _eventInfo select 3;

// CIPHER COMMENT: Need to somehow differentiate between 1. Vehicle types for different point multipliers
an

// points for players
if (local _instigator AND {isPlayer _instigator} AND {hasInterface}) then {
	private _points = [_killedUnit] call BLWK_fnc_getPointsForKill;
	[_killedUnit,_points] call BLWK_fnc_createHitMarker;
	[_points] call BLWK_fnc_addPoints;
};

// mp events need to be removed on the unit where they are local
if (local _killedUnit) then {
	removeMPEventHandler ["mpKilled",_handlerID];
};
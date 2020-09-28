params ["_eventInfo","_handlerID"];

private _killedUnit = _eventInfo select 0;
private _instigator = _eventInfo select 3;

if (local BLWK_theAIHandler) then {
	// if there is nobody to spawn, exit
	if !(BLWK_AISpawnQue isEqualTo []) then {

		BLWK_aliveEnemies deleteAt (BLWK_aliveEnemies findIf {_x isEqualTo _killedUnit});
		// needs to spawn the unit and then pushBack the new one into BLWK_aliveEnemies
		call BLWK_fnc_createAnEnemyFromQue;
	};
};

if (hasInterface) then {
	if (local _instigator AND {isPlayer _instigator}) then {
		[_killedUnit,BLWK_pointsForKill] call BLWK_fnc_createHitMarker;
		[_points] call BLWK_fnc_addPoints;
	};

	[_unit] call BLWK_fnc_removeUnitsHitEvent;
};

// mp events need to be removed on the unit where they are local
if (local _killedUnit) then {
	removeMPEventHandler ["mpKilled",_handlerID];
};
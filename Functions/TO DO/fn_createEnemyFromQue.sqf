if (BLWK_AISpawnQue isEqualTo []) exitWith {objNull};

(BLWK_AISpawnQue deleteAt 0) params ["_position","_type"];

private _group = createGroup OPFOR;
private _unit = _type createVehicle _position;
[_unit] joinSilent _group;

_group allowFleeing false;
[_group, bulwarkBox, 20, "SAD", "AWARE", "RED"] call CBAP_fnc_addWaypoint;

[BLWK_zeus, [[_unit],false]] remoteExec ["addCuratorEditableObjects",2];

BLWK_aliveEnemies pushBack _unit;


// add the hit eventhandler to every player locally
[_unit] remoteExecCall ["BLWK_fnc_addEnemyHitEH",BLWK_allClientsTargetID,true];

_unit addMPEventHandler ["mpKilled",{
	[_this,_thisEventHandler] call BLWK_fnc_enemyKilledEvent;
}];


_unit
if (BLWK_AISpawnQue isEqualTo []) exitWith {objNull};

(BLWK_AISpawnQue deleteAt 0) params ["_position","_type"];

private _group = createGroup OPFOR;
private _unit = _type createVehicle _position;
[_unit] joinSilent _group;

_group allowFleeing false;
[_group, bulwarkBox, 20, "SAD", "AWARE", "RED"] call CBAP_fnc_addWaypoint;

BLWK_zeus addCuratorEditableObjects [[_unit],false];

BLWK_aliveEnemies pushBack _unit;




// add the hit eventhandler to every player locally
// make the body into a function and pass _this to reduce network load with remoteExec
[_unit] remoteExecCall ["BLWK_fnc_addEnemyHitEH",BLWK_allClientsTargetID,true];


_unit addMPEventHandler ["mpKilled",{
	[_this,_thisEventHandler] call BLWK_fnc_enemyKilledEvent;

	if (local BLWK_theAIHandler) then {
		// if there is nobody to spawn, exit
		if !(BLWK_AISpawnQue isEqualTo []) then {

			//if (count BLWK_aliveEnemies <= BLWK_maxEnemiesAtOnce) then {
				BLWK_aliveEnemies deleteAt (BLWK_aliveEnemies findIf {_x isEqualTo _killedUnit});
				// needs to spawn the unit and then pushBack the new one into BLWK_aliveEnemies
				call BLWK_fnc_createAnEnemyFromQue;
			//};

		};
	};
	if (local _instigator AND {isPlayer _instigator}) then {
		[_killedUnit,BLWK_pointsForKill] call BLWK_fnc_createHitMarker;
		[_points] call BLWK_fnc_addPoints;
	};

	// need to remove the hit eventhandler of the unit too (on all machines)
	// possibly needs to be stored in the unit's namespace to get in the function

	// don't forget to pass _thisEventHandler to the function
	// mp events need to be removed on the unit where they are local
	if (local _killedUnit) then {
		removeMPEventHandler ["mpKilled",_thisEventHandler];
	};

	// needs to update que
	// need to give points to the local person
	// need to create hit marker
	// need to make sure the instigator is actually a player before adding points
}];
// need to add all the units eventhandlers
// hit event for points
// killed event for points and to spawn another AI if there are ones present in que


_unit
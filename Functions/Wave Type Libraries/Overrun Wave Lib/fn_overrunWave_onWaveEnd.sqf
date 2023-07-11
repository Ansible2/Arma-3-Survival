localNamespace setVariable ["BLWK_overrunWave_playerSpawn",nil];
localNamespace setVariable ["BLWK_overrunWave_enemySpawnCenter",nil];
localNamespace setVariable ["BLWK_overrunWave_enemySpawns",nil];
localNamespace setVariable ["BLWK_overrunWave_playerBasePosition",nil];

missionNamespace setVariable ["BLWK_enforceArea",true,true];
[true] remoteExecCall ["BLWK_fnc_playAreaEnforcementLoop",BLWK_allClientsTargetId];

// make sure crate is in play area
if !(BLWK_mainCrate inArea BLWK_playAreaMarker) then {
	BLWK_mainCrate setPos (
		[BLWK_playAreaCenter, 0, 100, 0, 0] call BIS_fnc_findSafePos
	);
};


nil

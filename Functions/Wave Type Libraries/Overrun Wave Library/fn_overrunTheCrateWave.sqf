/* ----------------------------------------------------------------------------
Function: BLWK_fnc_overrunTheCrateWave

Description:
	Adjusts the positions of players and enemies.

	Executed from "BLWK_fnc_handleOverrunWave"

Parameters:
	NONE

Returns:
	<BOOL> - Does play area meet the standards to have an overrun wave

Examples:
    (begin example)
		private _canDoWave = call BLWK_fnc_overrunTheCrateWave;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_overrunTheCrateWave";


#define DIST_BUFFER 50
#define NUMBER_ENEMY_POSITIONS 5
#define MAX_ENEMY_DIST 50
#define ENFORCEMENT_ID "overrunWave_JIP"

// get opposite sides for players and enemies
private _distanceToCenter = BLWK_playAreaRadius + DIST_BUFFER; 
private "_bearing";
private _enemyCenterPosition = [];
private _playerPosition = [];
private _canExit = false; 
for "_i" from 1 to 18 do {
	if (_canExit) exitWith {};

	_bearing = _i * 10;
	_playerPosition = BLWK_playAreaCenter getPos [_distanceToCenter,_bearing];
	_playerPosition set [2,0];
	if (surfaceIsWater _playerPosition) then {
		_playerPosition = [];
	} else {
		_enemyCenterPosition = BLWK_playAreaCenter getPos [_distanceToCenter,_bearing + 180];
		_enemyCenterPosition set [2,0];
		if (surfaceIsWater _enemyCenterPosition) then {
			_playerPosition = [];
			_enemyCenterPosition = [];
		} else {
			_canExit = true; 
		};
	};
};

// if the area is not suitable, exit
if (_enemyCenterPosition isEqualTo [] AND {_playerPosition isEqualTo []}) exitWith {
	["Your play area did not meet the requirements for the Overrun Wave type (too much water)"] remoteExecCall ["hint",BLWK_allClientsTargetId];
	false
};

// store crate position fro moving AI to surround its former place
BLWK_playerBasePosition = getPosATL BLWK_mainCrate;


// Give enemies new spawn positions opposite of players
BLWK_cachedEnemySpawns = +BLWK_infantrySpawnPositions;
private _enemySpawnPositions = [];
_enemySpawnPositions pushBack _enemyCenterPosition;
private "_positionToPushBack";
while {count _enemySpawnPositions < NUMBER_ENEMY_POSITIONS} do {
	_positionToPushBack = [_enemyCenterPosition, 0, MAX_ENEMY_DIST, 0, 0] call BIS_fnc_findSafePos;
	_enemySpawnPositions pushBackUnique _positionToPushBack;
};

BLWK_infantrySpawnPositions = _enemySpawnPositions;


// add scripted event handler to set things back to as they were on wave end
[missionNamespace,"BLWK_onWaveEnd",{
	[missionNamespace,"BLWK_onWaveEnd",_thisScriptedEventHandler] call BIS_fnc_removeScriptedEventHandler;

	BLWK_infantrySpawnPositions = +BLWK_cachedEnemySpawns;
	BLWK_cachedEnemySpawns = nil;
	BLWK_playerBasePosition = nil;

	missionNamespace setVariable ["BLWK_enforceArea",true,true];
	[true] remoteExecCall ["BLWK_fnc_playAreaEnforcementLoop",BLWK_allClientsTargetId];

	// make sure crate is in play area
	if !(BLWK_mainCrate inArea BLWK_playAreaMarker) then {
		BLWK_mainCrate setPos ([BLWK_playAreaCenter, 0, 100, 0, 0] call BIS_fnc_findSafePos); 
	};
}] call BIS_fnc_addScriptedEventHandler;


[_playerPosition] spawn {
	params ["_playerPosition"];

	// allow players outside the play area
	missionNamespace setVariable ["BLWK_enforceArea",false,true];

	sleep 2;

	// move players and crate to side
	BLWK_mainCrate setPosATL _playerPosition;

	(call CBAP_fnc_players) apply {
		// don't teleport players in vehicles
		if (isNull (objectParent _x)) then {
			_x setPosATL ([_playerPosition,15,random 360] call CBAP_fnc_randPos);
		};
	};

	// to keep AI from being spawned on top of players
	missionNamespace setVariable ["BLWK_baseIsClear",true];
};


true

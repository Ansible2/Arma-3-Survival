/* ----------------------------------------------------------------------------
Function: BLWK_fnc_startWave

Description:
	Heals the player when they select the action on The Crate

	Executed from "initServer.sqf" & "BLWK_fnc_endWave"

Parameters:
	0: _clearDroppedItems <BOOL> - Will dropped items on the ground be deleted this round?

Returns:
	NOTHING

Examples:
    (begin example)
		[true] call BLWK_fnc_startWave;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_startWave";

if (!isServer) exitWith {};

params [
	["_clearDroppedItems",false]
];

call BLWK_fnc_clearMustKillList;

if (_clearDroppedItems) then {

	private _weaponHolders = BLWK_playAreaCenter nearObjects ["weaponHolder",250];
	_weaponHolders = _weaponHolders select {typeOf _x == "groundWeaponHolder" AND {!(_x in BLWK_lootHolders)}};

	if !(_weaponHolders isEqualTo []) then {
		_weaponHolders apply {
			deleteVehicle _x;
		};
		sleep 1;
	};

};


/* ----------------------------------------------------------------------------
	Update wave info
---------------------------------------------------------------------------- */
private _previousWaveNum = missionNamespace getVariable ["BLWK_currentWaveNumber",0];
missionNamespace setVariable ["BLWK_currentWaveNumber", _previousWaveNum + 1,true];

missionNamespace setVariable ["BLWK_inBetweenWaves",false,true];
missionNamespace setVariable ["BLWK_initialWaveSpawnComplete",false];


/* ----------------------------------------------------------------------------
	Decide Wave Type/Handle Extraction
---------------------------------------------------------------------------- */
if (missionNamespace getVariable ["BLWK_extractionQueued",false]) then {
	call BLWK_fnc_extraction;

} else {
	call BLWK_fnc_spawnWaveEnemies;

	// loot is spawned before the wave starts at round 1
	if (BLWK_currentWaveNumber > BLWK_startingFromWaveNumber) then {
		// this will also clean up previous loot
		call BLWK_fnc_spawnLoot;
	};

};


/* ----------------------------------------------------------------------------
	Clean Dead
---------------------------------------------------------------------------- */
call BLWK_fnc_cleanUpTheDead;


/* ----------------------------------------------------------------------------
	Make sure enemies have spawned
---------------------------------------------------------------------------- */
// check to make sure there are actually units inside the wave array before looping
// or that all initial units are spawned
waitUntil {
	if (
		missionNamespace getVariable ["BLWK_initialWaveSpawnComplete",false] OR
		{(call BLWK_fnc_getMusKillList) isNotEqualTo []}
	) exitWith {true};
	sleep 1;
	false
};


// log wave
[["Start Wave: ",BLWK_currentWaveNumber],false] call KISKA_fnc_log;

// invoke wave start event
[missionNamespace,"BLWK_onWaveStart"] remoteExecCall ["BIS_fnc_callScriptedEventHandler",0];


/* ----------------------------------------------------------------------------
	Check for wave end
---------------------------------------------------------------------------- */
waitUntil {
	if (call BLWK_fnc_isWaveCleared) exitWith {
		[] spawn BLWK_fnc_endWave;
		true
	};

	sleep 3;
	false
};

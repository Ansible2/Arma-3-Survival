#include "..\..\Headers\String Constants.hpp"
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

		[true] spawn BLWK_fnc_startWave;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_startWave";

if (!isServer OR {!canSuspend}) exitWith {};

params [
	["_clearDroppedItems",false]
];


// wait for array to be cleared
/*
	it's rare, but if enemies die too quickly,
	this can cause overlap in the next wave of enemies.
	These are people that were just being added into the array when it is cleared
*/
private _arrayCleared = [] spawn BLWK_fnc_clearMustKillArray;
waitUntil {
	if (scriptDone _arrayCleared) exitWith {true};
	sleep 0.1;
	false
};

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

// update wave number
private _previousWaveNum = missionNamespace getVariable ["BLWK_currentWaveNumber",0];
missionNamespace setVariable ["BLWK_currentWaveNumber", _previousWaveNum + 1,true];

missionNamespace setVariable ["BLWK_inBetweenWaves",false,true];
missionNamespace setVariable ["BLWK_initialWaveSpawnComplete",false];

call BLWK_fnc_decideWaveType;

// loot is spawned before the wave starts at round 1
if (BLWK_currentWaveNumber > BLWK_startingFromWaveNumber) then {
	// this will also clean up previous loot
	call BLWK_fnc_spawnLoot;
};

call BLWK_fnc_cleanUpTheDead;

// check to make sure there are actually units inside the wave array before looping
// or that all initial units are spawned
waitUntil {
	if (
		missionNamespace getVariable ["BLWK_initialWaveSpawnComplete",false] OR
		{!(missionNamespace getVariable [WAVE_ENEMIES_ARRAY,[]] isEqualTo [])}
	) exitWith {true};
	sleep 1;
	false
};

// log wave
[["Start Wave: ",BLWK_currentWaveNumber],false] call KISKA_fnc_log;

// invoke wave start event
[missionNamespace,"BLWK_onWaveStart"] remoteExecCall ["BIS_fnc_callScriptedEventHandler",0];

// loop to check wave end
waitUntil {
	if (call BLWK_fnc_isWaveCleared) exitWith {
		[] spawn BLWK_fnc_endWave;
		true
	};

	sleep 3;
	false
};

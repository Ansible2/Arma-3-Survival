#include "..\..\Headers\String Constants.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_healPlayer

Description:
	Heals the player when they select the action ont he bulwark

	Executed from "initServer.sqf" & "BLWK_fnc_endWave"

Parameters:
	0: _clearDroppedItems <BOOL> - Will dropped items on the ground be deleted this round?

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_startWave;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer OR {!canSuspend}) exitWith {};

params ["_clearDroppedItems"];

call BLWK_fnc_clearMustKillArray;

// update wave number
private _previousWaveNum = missionNamespace getVariable ["BLWK_currentWaveNumber",0];
missionNamespace setVariable ["BLWK_currentWaveNumber", _previousWaveNum + 1,true];

missionNamespace setVariable ["BLWK_inBetweenWaves",false,true];

call BLWK_fnc_decideWaveType;

// loot is spawned before the wave starts at round 1
if (BLWK_currentWaveNumber > BLWK_startingFromWaveNumber) then {
	// this will also clean up previous loot
	call BLWK_fnc_spawnLoot;
};

call BLWK_fnc_cleanUpTheDead;

// check to make sure there are actually units inside the wave array before looping
waitUntil {
	if !(missionNamespace getVariable [WAVE_ENEMIES_ARRAY,[]] isEqualTo []) exitWith {true};
	sleep 1;
	false
};
// loop to check wave end
waitUntil {
	if (call BLWK_fnc_isWaveCleared) exitWith {
		null = [] spawn BLWK_fnc_endWave;
		true
	};

	sleep 3;
	false
};
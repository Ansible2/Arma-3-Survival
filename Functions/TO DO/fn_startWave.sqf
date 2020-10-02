// decide if special wave

// decide what AI should spawn

// start AI que loop

// spawn AI

// give AI the hit event handlers that add points

// inform pepople the round has started and what kind it is/number

// need to decide on special waves


// CIPHER COMMENT: Need a cleanup loot and bodies script


if (!isServer OR {!canSuspend}) exitWith {};

// update wave number
private _previousWaveNum = missionNamespace getVariable ["BLWK_currentWaveNumber",0];
missionNamespace setVariable ["BLWK_currentWaveNumber", _previousWaveNum + 1,true];

call BLWK_fnc_spawnLoot;

call BLWK_fnc_decideWaveType;


waitUntil {
	if (call BLWK_fnc_isWaveCleared) exitWith {

		true
	};

	sleep 3;
	false
};
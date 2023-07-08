["<t size = '.5'>Preparing Global Vars.<br/>Please wait...</t>", 0, 0, 10, 0] remoteExec ["BIS_fnc_dynamicText", 0];

waitUntil {
	localNamespace getVariable ["KISKA_missionParams_preloadFinished",false]
};

call BLWK_fnc_prepareGlobals;

[BLUFOR,BLWK_numRespawnTickets] call BIS_fnc_respawnTickets;

["<t size = '.5'>Preparing Play Area.<br/>Please wait...</t>", 0, 0, 10, 0] remoteExec ["BIS_fnc_dynamicText", 0];

// find a location for the mission, setup area, create The Crate
call BLWK_fnc_preparePlayArea;

setDate [2020, 7, 1, BLWK_timeOfDay, 0];

waitUntil {count (call CBAP_fnc_players) > 0};

if (BLWK_buildingsNearTheCrateAreIndestructable_radius > 0) then {
	[] spawn BLWK_fnc_theCrateBuildingsLoop;
};

[{ call BLWK_fnc_spawnLoot; }] call CBAP_fnc_directCall;

[] spawn BLWK_fnc_createBattleAmbienceSound;

[] spawn BLWK_fnc_handleUnconsciousAiEvent;

call BLWK_fnc_startWaveCountdown;

[] spawn BLWK_fnc_startWave;

[] spawn BLWK_fnc_arePlayersAliveLoop;

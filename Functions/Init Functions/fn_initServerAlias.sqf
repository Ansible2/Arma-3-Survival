if (!isServer) exitWith {};

["<t size = '.5'>Preparing Global Vars.<br/>Please wait...</t>", 0, 0, 10, 0] remoteExec ["BIS_fnc_dynamicText", 0];

call BLWK_fnc_prepareGlobals;

[BLUFOR,BLWK_numRespawnTickets] call BIS_fnc_respawnTickets;

["<t size = '.5'>Preparing Play Area.<br/>Please wait...</t>", 0, 0, 10, 0] remoteExec ["BIS_fnc_dynamicText", 0];

// find a location for the mission, setup area, create The Crate
call BLWK_fnc_preparePlayArea;

setDate [2020, 7, 1, BLWK_timeOfDay, 0];

waitUntil {count (call CBAP_fnc_players) > 0};

if (BLWK_buildingsNearTheCrateAreIndestructable_radius > 0) then {
	null = [] spawn BLWK_fnc_theCrateBuildingsLoop;
};

call BLWK_fnc_spawnLoot;

null = [] spawn BLWK_fnc_createBattleAmbienceSound;

sleep (BLWK_timeBetweenRounds - 15);
null = remoteExec ["BLWK_fnc_startWaveCountDownFinal",BLWK_allClientsTargetID];

sleep 15;

null = [] spawn BLWK_fnc_startWave;

null = [] spawn BLWK_fnc_arePlayersAliveLoop;
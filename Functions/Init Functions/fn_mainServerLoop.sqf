/* ----------------------------------------------------------------------------
Function: BLWK_fnc_mainServerLoop

Description:
	Starts the main loop of the mission 
	
	It is executed from the "initServer.sqf".
	
Parameters:
	NONE

Returns:
	Nothing

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_mainServerLoop;

    (end)
---------------------------------------------------------------------------- */
wavesSinceArmour = 0;
wavesSinceCar = 0;
wavesSinceSpecial = 0;
SatUnlocks = [];
publicVariable 'SatUnlocks';

//spawn start loot
if (isServer) then {
	execVM "loot\spawnLoot.sqf";
};

sleep 15;
runMissionLoop = true;
missionFailure = false;

// start in build phase
missionNamespace setVariable ["buildPhase", true, true];

[west, BLWK_numRespawnTickets] call BIS_fnc_respawnTickets;

while {runMissionLoop} do {

	//Reset the AI position checks
	AIstuckcheck = 0;
	AIStuckCheckArray = [];

	call bulwark_fnc_startWave;

	while {runMissionLoop} do {

		// Get all human players in this wave cycle // moved to contain players that respawned in this wave
		_allHCs = entities "HeadlessClient_F";
		_allHPs = allPlayers - _allHCs;

		//Check if all hostiles dead
		if (EAST countSide allUnits == 0) exitWith {};

		//check if all players dead or unconscious
		_deadUnconscious = [];
		{
			if ((!alive _x) || ((lifeState _x) == "INCAPACITATED")) then {
				_deadUnconscious pushBack _x;
			};
		} foreach _allHPs;
		_respawnTickets = [west] call BIS_fnc_respawnTickets;
		if (count (_allHPs - _deadUnconscious) <= 0 && _respawnTickets <= 0) then {
			sleep 1;

			//Check that Players have not been revived
			_deadUnconscious = [];
			{
				if ((!alive _x) || ((lifeState _x) == "INCAPACITATED")) then {
					_deadUnconscious pushBack _x;
				};
			} foreach _allHPs;
			if (count (_allHPs - _deadUnconscious) <= 0 && _respawnTickets <= 0) then {
				sleep 1;
				if (count (_allHPs - _deadUnconscious) <= 0 && _respawnTickets <= 0) then {
					runMissionLoop = false;
					missionFailure = true;
					"End1" call BIS_fnc_endMissionServer;
				};
			};
		};

		//Add objects to zeus
		{
			mainZeus addCuratorEditableObjects [[_x], true];
		} foreach _allHPs;
	};

	if(missionFailure) exitWith {};

	if (BLWK_currentWaveNumber == BLWK_maxNumWaves) exitWith {
		"End2" call BIS_fnc_endMissionServer;
	};

	[] call bulwark_fnc_endWave;

};
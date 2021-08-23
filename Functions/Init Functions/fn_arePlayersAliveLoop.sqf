/* ----------------------------------------------------------------------------
Function: BLWK_fnc_arePlayersAliveLoop

Description:
	Checks players to see if any are still alive and respawns are left.
	Will end the mission if not.

	Executed from "initServer.sqf"

Parameters:
	NONE

Returns:
	Nothing

Examples:
    (begin example)
		[] spawn BLWK_fnc_arePlayersAliveLoop;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_arePlayersAliveLoop";

if (!isServer) exitWith {};

if (!canSuspend) exitWith {
	["Needs to run in scheduled, running in scheduled...",true] call KISKA_fnc_log;
	[] spawn BLWK_fnc_arePlayersAliveLoop;
};

// wait till the first round has started
waitUntil {
	if !(missionNamespace getVariable ["BLWK_inBetweenWaves",false]) exitWith {true};
	sleep 1;
	false
};

private ["_players","_return"];
private _noPlayersAlive = {
	_players = call CBAP_fnc_players;

	// check if there is a player in a non-incapticated state
	_return = _players findIf {
		(alive _x) AND {(incapacitatedState _x) isEqualTo ""}
	};

	// if there is a player who is NOT incapticated
	if (_return isNotEqualTo -1) then {
		false
	} else {
		// if there are no players who are alive and able
		true
	};
};


waitUntil {
	if ((call _noPlayersAlive) AND {BLWK_numRespawnTickets <= 0}) exitWith {
		["All players are dead with no respawns. Ending mission...",false] call KISKA_fnc_log;
		"End1" call BIS_fnc_endMissionServer;
		true
	};

	sleep 5;

	false
};

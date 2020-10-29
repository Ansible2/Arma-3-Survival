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

		null = [] spawn BLWK_fnc_arePlayersAliveLoop;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer OR {!canSuspend}) exitWith {};

private ["_players","_return"];
// wait till the first round has started
waitUntil {
	if !(missionNamespace getVariable ["BLWK_inBetweenWaves",false]) exitWith {true};
	sleep 1;
	false
};
private _condition = {
	_players = call CBAP_fnc_players;
	_return = _players findIf {
		((incapacitatedState _x) isEqualTo "") OR {BLWK_numRespawnTickets > 0}
	};
	if (_return isEqualTo -1) then {
		true
	} else {
		false
	};
};


waitUntil {
	if (call _condition) exitWith {
		"End1" call BIS_fnc_endMissionServer;
		true
	};

	sleep 5;

	false
};
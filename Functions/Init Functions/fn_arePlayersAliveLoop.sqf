/* ----------------------------------------------------------------------------
Function: BLWK_fnc_arePlayersAliveLoop

Description:
	Checks players to see if any are still alive and respawns are left.
	Will end the mission if not.

	Executed from ""

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

private _players = call CBAP_fnc_players;
private _return = 0;

private _condition = {
	_players = call CBAP_fnc_players
	_return = _players findIf {
		alive _x OR 
		{(incapacitatedState _x isEqualTo "") AND {BLWK_numRespawnTickets <= 0}}
	};

	_return
};

waitUntil {
	if ((call _condition) isEqualTo -1) exitWith {
		"End1" call BIS_fnc_endMissionServer;
		true
	};

	sleep 4;

	false
};
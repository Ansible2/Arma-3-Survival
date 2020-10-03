/* ----------------------------------------------------------------------------
Function: BLWK_fnc_endWave

Description:
	Notifies players of wave end and completes mission if final wave done.
	Also revives downed players and startst the countdown to the next wave.

	Executed from "BLWK_fnc_startWave"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_endWave;

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer OR {!canSuspend}) exitWith {};

// check for mission complete
if (BLWK_currentWaveNumber isEqualTo BLWK_maxNumWaves) exitWith {
	"End2" call BIS_fnc_endMissionServer;
};

#include "..\..\Headers\String Constants.hpp"

missionNamespace setVariable ["BLWK_inBetweenWaves",true,true];
private _players = call CBAP_fnc_players;
[TASK_COMPLETE_TEMPLATE,["",COMPLETED_WAVE_NOTIFICATION(BLWK_currentWaveNumber)]] remoteExec ["BIS_fnc_showNotification",_players];


private "_playerTemp";
private _fn_healPlayers = {
	if (lifeState _playerTemp == "DEAD") exitWith {
		[_playerTemp] remoteExec ["forceRespawn",_playerTemp];
	};
	if (lifeState _playerTemp == "INCAPACITATED") then {
		["BLWK_reviveOnStateVar", 1, _playerTemp] remoteExecCall ["BIS_fnc_reviveOnState",_playerTemp];
	};
};
_players apply {
	_playerTemp = _x;
	call _fn_healPlayers
};



// count down to next wave
sleep (BLWK_timeBetweenRounds - 15);
null = remoteExec ["BLWK_fnc_startWaveCountDownFinal",BLWK_allClientsTargetID];
sleep 15;

null = [] spawn BLWK_fnc_startWave;
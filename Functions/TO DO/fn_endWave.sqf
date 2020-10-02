// clean the dead bodies or create an array of those that died THIS round to be deleted later

// start loop for countdown to the next round that will need to have a print out on screen for the final ten seconds
if (!isServer OR {!canSuspend}) exitWith {false};

// check for mission complete
if (BLWK_currentWaveNumber isEqualTo BLWK_maxNumWaves) exitWith {
	"End2" call BIS_fnc_endMissionServer;
};

#include "..\..\Headers\String Constants.hpp"

missionNamespace setVariable ["BLWK_inBetweenWaves",true,true]
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
call BLWK_fnc_startWave;
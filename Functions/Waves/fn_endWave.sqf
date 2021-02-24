#include "..\..\Headers\String Constants.hpp"
#include "..\..\Headers\Stalker Global Strings.hpp"
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

		[] spawn BLWK_fnc_endWave;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer OR {!canSuspend}) exitWith {};

// handle drone wave global
if !(isNil "BLWK_allDronesCreated") then {
	missionNamespace setVariable ["BLWK_allDronesCreated",nil,[0,2] select isMultiplayer];
};

// check for mission complete
if (BLWK_currentWaveNumber isEqualTo BLWK_maxNumWaves) exitWith {
	"End2" call BIS_fnc_endMissionServer;
};

// delete any alive civilians from special wave
if !((missionNamespace getVariable ["BLWK_civiliansFromWave",[]]) isEqualTo []) then {
	BLWK_civiliansFromWave apply {
		if (alive _x) then {
			deleteVehicle _x;
		};
	};

	missionNamespace setVariable ["BLWK_civiliansFromWave",[]];
};


missionNamespace setVariable ["BLWK_inBetweenWaves",true,true];
private _players = call CBAP_fnc_players;
[TASK_COMPLETE_TEMPLATE,["",COMPLETED_WAVE_NOTIFICATION(str BLWK_currentWaveNumber)]] remoteExec ["BIS_fnc_showNotification",_players];


// revive the dead players
private "_playerTemp";
_players apply {
	_playerTemp = _x;

	// clear all stalkers counts
	_playerTemp setVariable [STALKER_COUNT_VAR,0,BLWK_theAIHandlerOwnerID];


	if (!alive _playerTemp) then {
		// add a single respawn ticket for each dead unit
		private _respawns = [BLUFOR,1] call BIS_fnc_respawnTickets;
		missionNamespace setVariable ["BLWK_numRespawnTickets",_respawns,true];
		[0] remoteExecCall ["setPlayerRespawnTime",_playerTemp];
		[_playerTemp] remoteExecCall ["forceRespawn",_playerTemp];
	} else {
		if (lifeState _playerTemp == "INCAPACITATED") then {
			if (BLWK_dontUseRevive) then {
				if (BLWK_ACELoaded) then {
					[_playerTemp] remoteExecCall ["ace_medical_treatment_fnc_fullHealLocal",_playerTemp];
				};
			} else {
				["BLWK_reviveOnStateVar", 1, _playerTemp] remoteExecCall ["BIS_fnc_reviveOnState",_playerTemp];
			};
		};
	};
};


// clear any dropped items if required
private _clearDroppedItems = false;
if (((BLWK_currentWaveNumber + 1) mod BLWK_deleteDroppedItemsEvery) isEqualTo 0) then {
	_clearDroppedItems = true;

	// don't send the notification every wave if items are cleared every time. Would be annoying.
	if (BLWK_deleteDroppedItemsEvery > 1) then {
		remoteExecCall ["BLWK_fnc_hintDroppedDelete",BLWK_allClientsTargetID];
	};
};

// invoke wave end event
[missionNamespace,"BLWK_onWaveEnd"] remoteExecCall ["BIS_fnc_callScriptedEventHandler",0];

// count down to next wave
if (BLWK_timeBetweenRounds > 0) then {
	sleep (BLWK_timeBetweenRounds - 15);
	remoteExec ["BLWK_fnc_startWaveCountDownFinal",BLWK_allClientsTargetID];
	sleep 15;
};

[_clearDroppedItems] spawn BLWK_fnc_startWave;
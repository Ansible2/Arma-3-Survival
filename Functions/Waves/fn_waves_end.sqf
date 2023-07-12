/* ----------------------------------------------------------------------------
Function: BLWK_fnc_waves_end

Description:
    Notifies players of wave end and completes mission if final wave done.
    Also revives downed players and startst the countdown to the next wave.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_waves_end;
    (end)

Author(s):
    Hilltop(Willtop) & omNomios,
    Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_waves_end";

#define COMPLETED_WAVE_NOTIFICATION(WAVE_NUM_STRING) ("Wave " + WAVE_NUM_STRING + " Complete")
#define TASK_COMPLETE_TEMPLATE "TaskSucceeded"

if (!isServer) exitWith {};

private _waveConfig = localNamespace getVariable ["BLWK_currentWaveConfig",configNull];
private _waveEndEvent = [
    _waveConfig,
    "onWaveEnd"
] call BLWK_fnc_waves_getFunctionFromConfig;


if (_waveEndEvent isNotEqualTo {}) then {
    call _waveEndEvent;
};

/* ----------------------------------------------------------------------------
     Check mission end
---------------------------------------------------------------------------- */
private _endMission = false;
if (BLWK_currentWaveNumber isEqualTo BLWK_maxNumWaves) then {
    if (BLWK_extractionEnabled) then {
        call BLWK_fnc_callingForExtraction;
    } else {
        _endMission = true;
    };
};

if (_endMission) exitWith {
    "End2" call BIS_fnc_endMissionServer;
};


/* ----------------------------------------------------------------------------
     Notify Players
---------------------------------------------------------------------------- */
missionNamespace setVariable ["BLWK_inBetweenWaves",true,true];
private _players = call CBAP_fnc_players;
[
    TASK_COMPLETE_TEMPLATE,
    ["",COMPLETED_WAVE_NOTIFICATION(str BLWK_currentWaveNumber)]
] remoteExec ["BIS_fnc_showNotification",_players];


/* ----------------------------------------------------------------------------
     Handle faction changes
---------------------------------------------------------------------------- */
private _factionQueue = localNamespace getVariable ["BLWK_factionChangeQueue",[]];
if (_factionQueue isNotEqualTo []) then {
    [true,_factionQueue] call BLWK_fnc_setupFactionMaps;
    localNamespace setVariable ["BLWK_factionChangeQueue",[]];
    [true,_factionQueue] remoteExec ["BLWK_fnc_setupFactionMaps",-2];
};


/* ----------------------------------------------------------------------------
     Revive downed players
---------------------------------------------------------------------------- */
_players apply {
    // clear all stalkers counts
    _x setVariable [STALKER_COUNT_VAR,0,BLWK_theAIHandlerOwnerID];

    if (!alive _x) then {
        // add a single respawn ticket for each dead unit
        private _respawns = [BLUFOR,1] call BIS_fnc_respawnTickets;
        missionNamespace setVariable ["BLWK_numRespawnTickets",_respawns,true];
        [0] remoteExecCall ["setPlayerRespawnTime",_x];
        [_x] remoteExecCall ["forceRespawn",_x];

    } else {

        if (lifeState _x == "INCAPACITATED") then {
            if (BLWK_dontUseRevive) then {
                if (BLWK_ACELoaded) then {
                    [_x] remoteExecCall ["ace_medical_treatment_fnc_fullHealLocal",_x];
                };
            } else {
                ["BLWK_reviveOnStateVar", 1, _x] remoteExecCall ["BIS_fnc_reviveOnState",_x];
            };
        };

    };
};


/* ----------------------------------------------------------------------------
    Clear dropped items
---------------------------------------------------------------------------- */
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


/* ----------------------------------------------------------------------------
    Wait for next wave
---------------------------------------------------------------------------- */
[_clearDroppedItems] spawn {
    call BLWK_fnc_startWaveCountdown;

    [
        BLWK_fnc_waves_start,
        _this
    ] call CBAP_fnc_directCall;
};


nil
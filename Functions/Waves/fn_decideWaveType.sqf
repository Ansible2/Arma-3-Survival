#include "..\..\Headers\String Constants.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_decideWaveType

Description:
	Decides what type of wave will be next if there are special waves allowed.

	Executed from "BLWK_fnc_startWave"

Parameters:
	NONE

Returns:
	BOOL

Examples:
    (begin example)

		call BLWK_fnc_decideWaveType;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SPECIAL_WAVE_LIKELIHOOD 0.3
#define STANDARD_WAVE_LIKELIHOOD 1.25
#define SPECIAL_WAVES \
[ \
	[SUICIDE_WAVE, SPECIAL_WAVE_LIKELIHOOD], \
	[CIVILIAN_WAVE, SPECIAL_WAVE_LIKELIHOOD], \
	[DRONE_WAVE, SPECIAL_WAVE_LIKELIHOOD], \
	[MORTAR_WAVE, SPECIAL_WAVE_LIKELIHOOD], \
	[DEFECTOR_WAVE, SPECIAL_WAVE_LIKELIHOOD], \
	[OVERRUN_WAVE, SPECIAL_WAVE_LIKELIHOOD], \
	[PARATROOPER_WAVE, SPECIAL_WAVE_LIKELIHOOD], \
	[HELICOPTER_WAVE, SPECIAL_WAVE_LIKELIHOOD], \
]


if (!isServer) exitWith {false};

private _usedSpecialWaves = missionNamespace getVariable ["BLWK_usedSpecialWaves",[]];

private _fn_getWaveType = {
	private _decideArray = [STANDARD_WAVE, STANDARD_WAVE_LIKELIHOOD];

	// these aren't cache'd for the desire to have this be a potential toggle option mid-session in the future
	if (BLWK_currentWaveNumber >= BLWK_specialWavesStartAt) then {
		SPECIAL_WAVES apply {
			if !((_x select 0) in _usedSpecialWaves) then {
				_decideArray append _x;
			};
		};

		// if we just got the standard wave (2 entries in _decideArray), assume we've used up all the special waves and need to reset the queue
		if ((count _decideArray) isEqualTo 2) then {
			missionNamespace setVariable ["BLWK_usedSpecialWaves",[]];
		};
	};

	private _usedWave = selectRandomWeighted _decideArray;
	if (_usedWave != STANDARD_WAVE) then {
		_usedSpecialWaves pushBack _usedWave;
		missionNamespace setVariable ["BLWK_usedSpecialWaves",_usedSpecialWaves];
	};

	_usedWave
};

private _selectedWaveType = call _fn_getWaveType;
private _fn_execWave = {
	if (_selectedWaveType == STANDARD_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleStandardWave",BLWK_theAIHandlerEntity];

		[TASK_ASSIGNED_TEMPLATE, ["",INCOMING_WAVE_NOTIFICATION(str BLWK_currentWaveNumber)]]
	};
	if (_selectedWaveType == SUICIDE_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleSuicideWave",BLWK_theAIHandlerEntity];

		[SPECIAL_WARNING_TEMPLATE, [SUICIDE_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == CIVILIAN_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_createStdWaveInfantry",BLWK_theAIHandlerEntity];
		call BLWK_fnc_civiliansWave;

		[SPECIAL_WARNING_TEMPLATE, [CIVILIAN_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == DRONE_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleDroneWave",BLWK_theAIHandlerEntity];

		[SPECIAL_WARNING_TEMPLATE, [DRONE_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == MORTAR_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleMortarWave",BLWK_theAIHandlerEntity];

		[SPECIAL_WARNING_TEMPLATE, [MORTAR_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == DEFECTOR_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleDefectorWave",BLWK_theAIHandlerEntity];

		[SPECIAL_WARNING_TEMPLATE, [DEFECTORS_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == OVERRUN_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleOverrunWave",BLWK_theAIHandlerEntity];

		[SPECIAL_WARNING_TEMPLATE, [OVERRUN_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == PARATROOPER_WAVE) exitWith {
		remoteExec ["BLWK_fnc_handleParatrooperWave",BLWK_theAIHandlerEntity];

		[SPECIAL_WARNING_TEMPLATE, [PARATROOPER_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == HELICOPTER_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleHelicopterWave",BLWK_theAIHandlerEntity];

		[SPECIAL_WARNING_TEMPLATE, [HELICOPTER_WAVE_NOTIFICATION]]
	};
};

// notify players of wave start
private _notification = call _fn_execWave;
private _players = call CBAP_fnc_players;
_notification remoteExec ["BIS_fnc_showNotification", _players];

// play a sound for special waves
if (_selectedWaveType != STANDARD_WAVE) then {
	["Alarm"] remoteExec ["playSound", _players];
};


true

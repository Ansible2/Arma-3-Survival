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
scriptName "BLWK_fnc_decideWaveType";

#define SPECIAL_WAVES \
[ \
	[SUICIDE_WAVE, 1], \
	[CIVILIAN_WAVE, 1], \
	[DRONE_WAVE, 1], \
	[MORTAR_WAVE, 1], \
	[DEFECTOR_WAVE, 1], \
	[OVERRUN_WAVE, 1], \
	[PARATROOPER_WAVE, 1], \
	[HELICOPTER_WAVE, 1] \
]
#define IS_SPECIAL 0
#define IS_STANDARD 1

if (!isServer) exitWith {false};


private _fn_getWaveType = {
	private _usedWave = "";

	// these aren't cache'd for the desire to have this be a potential toggle option mid-session in the future
	if (BLWK_currentWaveNumber >= BLWK_specialWavesStartAt) then {
		["Special waves can be selected this wave",false] call KISKA_fnc_log;

		private _standardWaveLikelihood = 1 - BLWK_specialWaveLikelihood;
		private _waveType = selectRandomWeighted [IS_SPECIAL,BLWK_specialWaveLikelihood,IS_STANDARD,_standardWaveLikelihood];
		//[[IS_SPECIAL," ",BLWK_specialWaveLikelihood," ",IS_STANDARD," ",_standardWaveLikelihood],false] call KISKA_fnc_log;

		if (_waveType isEqualTo IS_SPECIAL) then {
			["Selected a special wave instead of standard",false] call KISKA_fnc_log;

			private _usedSpecialWaves = missionNamespace getVariable ["BLWK_usedSpecialWaves",[]];
			private _decideArray = [];
			private _allSpecialWaves = SPECIAL_WAVES;

			// checking if all special waves have already been used
			if ((count _usedSpecialWaves) isEqualTo (count _allSpecialWaves)) then {
				missionNamespace setVariable ["BLWK_usedSpecialWaves",[]];
				_usedSpecialWaves = [];
			};

			_allSpecialWaves apply {
				if !((_x select 0) in _usedSpecialWaves) then {
					_decideArray append _x;
				};
			};

			_usedWave = selectRandomWeighted _decideArray;
			_usedSpecialWaves pushBack _usedWave;
			missionNamespace setVariable ["BLWK_usedSpecialWaves",_usedSpecialWaves];
		} else {
			["Selected a standard wave instead of a special one",false] call KISKA_fnc_log;
			_usedWave = STANDARD_WAVE;

		};

	} else {
		["Special waves CANT be selected this wave as the wave is still has yet to reach the special wave starting wave threshold",false] call KISKA_fnc_log;
		_usedWave = STANDARD_WAVE;

	};


	_usedWave
};

private _selectedWaveType = call _fn_getWaveType;
private _fn_execWave = {
	if (_selectedWaveType == STANDARD_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleStandardWave",BLWK_theAIHandlerOwnerID];

		[TASK_ASSIGNED_TEMPLATE, ["",INCOMING_WAVE_NOTIFICATION(str BLWK_currentWaveNumber)]]
	};
	if (_selectedWaveType == SUICIDE_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleSuicideWave",BLWK_theAIHandlerOwnerID];

		[SPECIAL_WARNING_TEMPLATE, [SUICIDE_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == CIVILIAN_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_createStdWaveInfantry",BLWK_theAIHandlerOwnerID];
		call BLWK_fnc_civiliansWave;

		[SPECIAL_WARNING_TEMPLATE, [CIVILIAN_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == DRONE_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleDroneWave",BLWK_theAIHandlerOwnerID];

		[SPECIAL_WARNING_TEMPLATE, [DRONE_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == MORTAR_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleMortarWave",BLWK_theAIHandlerOwnerID];

		[SPECIAL_WARNING_TEMPLATE, [MORTAR_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == DEFECTOR_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleDefectorWave",BLWK_theAIHandlerOwnerID];

		[SPECIAL_WARNING_TEMPLATE, [DEFECTORS_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == OVERRUN_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleOverrunWave",BLWK_theAIHandlerOwnerID];

		[SPECIAL_WARNING_TEMPLATE, [OVERRUN_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == PARATROOPER_WAVE) exitWith {
		remoteExec ["BLWK_fnc_handleParatrooperWave",BLWK_theAIHandlerOwnerID];

		[SPECIAL_WARNING_TEMPLATE, [PARATROOPER_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == HELICOPTER_WAVE) exitWith {
		remoteExecCall ["BLWK_fnc_handleHelicopterWave",BLWK_theAIHandlerOwnerID];

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

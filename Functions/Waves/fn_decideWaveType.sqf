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

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false};
#include "..\..\Headers\String Constants.hpp"
#define STANDARD_WAVE_LIKELIHOOD 1
#define SUICIDE_WAVE_LIKELIHOOD 0.1
#define CIVILIAN_WAVE_LIKELIHOOD 0.25
#define DRONE_WAVE_LIKELIHOOD 0.1
#define MORTAR_WAVE_LIKELIHOOD 0.25
#define DEFECTOR_WAVE_LIKELIHOOD 0.25
#define OVERRUN_WAVE_LIKELIHOOD 0.15

private _fn_getWaveType = {
	private _decideArray = [];
	_decideArray append [STANDARD_WAVE, STANDARD_WAVE_LIKELIHOOD];
	// these aren't cache'd for the desire to have this be a toggle option mid-session in the future
	if (BLWK_allowSpecialWaves) then {
		_decideArray append [SUICIDE_WAVE, SUICIDE_WAVE_LIKELIHOOD];
		_decideArray append [CIVILIAN_WAVE, CIVILIAN_WAVE_LIKELIHOOD];
		_decideArray append [DRONE_WAVE, DRONE_WAVE_LIKELIHOOD];
		_decideArray append [MORTAR_WAVE, MORTAR_WAVE_LIKELIHOOD];
		_decideArray append [DEFECTOR_WAVE, DEFECTOR_WAVE_LIKELIHOOD];
		_decideArray append [OVERRUN_WAVE, OVERRUN_WAVE_LIKELIHOOD];
	};

	selectRandomWeighted _decideArray;
};

private _selectedWaveType = call _fn_getWaveType;



private _fn_execWave = {
	if (_selectedWaveType == STANDARD_WAVE) exitWith {
		null = remoteExec ["BLWK_fnc_handleStandardWave",BLWK_theAIHandler];
		
		[TASK_ASSIGNED_TEMPLATE, [INCOMING_WAVE_NOTIFICATION(BLWK_currentWaveNumber)]]
	};
	if (_selectedWaveType == SUICIDE_WAVE) exitWith {
		null = remoteExec ["BLWK_fnc_handleSuicideWave",BLWK_theAIHandler];

		[SPECIAL_WARNING_TEMPLATE, [SUICIDE_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == CIVILIAN_WAVE) exitWith {
		null = remoteExec ["BLWK_fnc_createStdWaveInfantry",BLWK_theAIHandler];
		call BLWK_fnc_civiliansWave;

		[SPECIAL_WARNING_TEMPLATE, [CIVILIAN_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == DRONE_WAVE exitWith {
		null = remoteExec ["BLWK_fnc_handleDroneWave",BLWK_theAIHandler];

		[SPECIAL_WARNING_TEMPLATE, [DRONE_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == MORTAR_WAVE) exitWith {
		null = remoteExec ["BLWK_fnc_handleMortarWave",BLWK_theAIHandler];

		[SPECIAL_WARNING_TEMPLATE, [MORTAR_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == DEFECTOR_WAVE) exitWith {
		null = remoteExec ["BLWK_fnc_handleDefectorWave",BLWK_theAIHandler];

		[SPECIAL_WARNING_TEMPLATE, [DEFECTORS_WAVE_NOTIFICATION]]
	};
	if (_selectedWaveType == OVERRUN_WAVE) exitWith {
		null = remoteExec ["BLWK_fnc_handleOverrunWave",BLWK_theAIHandler];

		[SPECIAL_WARNING_TEMPLATE, [OVERRUN_WAVE_NOTIFICATION]]
	};
};

private _notification = call _fn_execWave;
private _players = call CBAP_fnc_players;
_notification remoteExec ["BIS_fnc_showNotification", _players];
["Alarm"] remoteExec ["playSound", _players];


true
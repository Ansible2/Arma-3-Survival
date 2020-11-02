/* ----------------------------------------------------------------------------
Function: BLWK_fnc_infoPanelLoop

Description:
	Runs a loop that constanly checks for changes in the the info
	 displayed on the users upper left info panel.

	Executed from "initPlayerLocal.sqf"

Parameters:
	0: _player : <OBJECT> - For whom to update the panel (used to display the user's name)

Returns:
	NOTHING

Examples:
    (begin example)

		null = [player] spawn BLWK_fnc_infoPanelLoop;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
// This may be replaced in the future with an update function that simply acts as an event that must be called
// I am curious to see if the performance of this loop is negligible enough though, 
/// that it would be more effective to just have these update automatically
if (!hasInterface OR {!canSuspend}) exitWith {};

disableSerialization;

#include "..\..\Headers\descriptionEXT\GUI\infoPanelCommonDefines.hpp"

waitUntil {
	if ((!isNil "BLWK_playerKillPoints") AND {!isNil "BLWK_numRespawnTickets"} AND {!isNil "BLWK_currentWaveNumber"}) exitWith {true};
	sleep 1;
	false
};


"infoPanelLayer" cutRsc [INFO_PANEL_DISPLAYNAME,"PLAIN"];
private _infoPanelDisplay = uiNamespace getVariable INFO_PANEL_DISPLAYNAME;

// player points
private _playerPoints = BLWK_playerKillPoints;
private _pointsCtrl = _infoPanelDisplay displayCtrl INFO_PANEL_PLAYER_POINTS_IDC;
private _fn_updatePlayerPoints = {	
	_pointsCtrl ctrlSetText (str BLWK_playerKillPoints);
	_pointsCtrl ctrlCommit 0;
	_playerPoints = BLWK_playerKillPoints;
};

// respawn tickets
private _numRespawnTickets = BLWK_numRespawnTickets;
private _ticketsCtrl = _infoPanelDisplay displayCtrl INFO_PANEL_RESPAWNS_NUM_IDC;
private _fn_updateRespawnTickets = {
	_ticketsCtrl ctrlSetText (str BLWK_numRespawnTickets);
	_ticketsCtrl ctrlCommit 0;
	_numRespawnTickets = BLWK_numRespawnTickets;
};

// current wave number
private _currentWave = BLWK_currentWaveNumber;
private _currentWaveCtrl = _infoPanelDisplay displayCtrl INFO_PANEL_WAVE_NUM_IDC;
private _fn_updateCurrentWave = {
	_currentWaveCtrl ctrlSetText (str BLWK_currentWaveNumber);
	_currentWaveCtrl ctrlCommit 0;
	_currentWave = BLWK_currentWaveNumber;
};

// in between waves notice
private _inBetweenWaves = BLWK_inBetweenWaves;
private _inbetweenWavesCtrl = _infoPanelDisplay displayCtrl INFO_PANEL_WAVE_STATUS_IDC;
private _fn_updateInbetweenWaves = {
	if (BLWK_inBetweenWaves) then {
		_inbetweenWavesCtrl ctrlSetText "IN BETWEEN";
		_inbetweenWavesCtrl ctrlSetTextColor [0,0.75,0.22,0.7];
	} else {
		_inbetweenWavesCtrl ctrlSetText "IN PROGRESS";
		_inbetweenWavesCtrl ctrlSetTextColor [1,0.1,0,0.57];
	};
	_inbetweenWavesCtrl ctrlCommit 0;
	_inBetweenWaves = BLWK_inBetweenWaves;
};

call _fn_updatePlayerPoints;
call _fn_updateRespawnTickets;
call _fn_updateCurrentWave;
call _fn_updateInbetweenWaves;

while {sleep 2; true} do {
	if (_playerPoints != BLWK_playerKillPoints) then {
		call _fn_updatePlayerPoints
	};
	if (_numRespawnTickets != BLWK_numRespawnTickets) then {
		call _fn_updateRespawnTickets
	};
	if (_currentWave != BLWK_currentWaveNumber) then {
		call _fn_updateCurrentWave
	};
	if !(_inBetweenWaves isEqualTo BLWK_inBetweenWaves) then {
		call _fn_updateInbetweenWaves
	};
};
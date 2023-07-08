/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnWaveEnemies

Description:
	Determines what type of wave should happen next and then initiates the
	 spawning of enemies for that wave.

	Executed from "BLWK_fnc_startWave"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_spawnWaveEnemies;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnWaveEnemies";

if (!isServer) exitWith {};

/* ----------------------------------------------------------------------------
	Check if special waves are allowed
---------------------------------------------------------------------------- */
private _selectSpecialWave = false;
if (BLWK_currentWaveNumber >= BLWK_specialWavesStartAt) then {
	["Special waves can be selected this wave",false] call KISKA_fnc_log;
	private _standardWaveLikelihood = 1 - BLWK_specialWaveLikelihood;
	_selectSpecialWave = selectRandomWeighted [true,BLWK_specialWaveLikelihood,false,_standardWaveLikelihood];
};

private _usedSpecialWaves = localNamespace getVariable ["BLWK_usedSpecialWaveConfigs",[]];


/* ----------------------------------------------------------------------------
	function definitions
---------------------------------------------------------------------------- */
private _getAllowedSpecialWaves = {
	BLWK_specialWaveConfigs select {
		private _waveIsAllowedInParams = missionNamespace getVariable [getText(_x >> "toggleVariable"),true];
		!(_x in _usedSpecialWaves) AND _waveIsAllowedInParams
	};
};

private _fn_getNormalWave = {
	if (BLWK_currentWaveNumber >= BLWK_normalWavesStartAt) exitWith {
		private _weights = BLWK_normalWaveConfigs apply {
			missionNamespace getVariable [getText(_x >> "weightVariable"),0];
		};

		BLWK_normalWaveConfigs selectRandomWeighted _weights
	};

	missionConfigFile >> "BLWK_waveTypes" >> "normalWaves" >> "standardWave"
};


/* ----------------------------------------------------------------------------
	Select wave type
---------------------------------------------------------------------------- */
private _playAlarm = false;
private _waveConfigPath = configNull;
if (_selectSpecialWave) then {
	["Selected a special wave instead of standard",false] call KISKA_fnc_log;

	private _allowedSpecialWaves = call _getAllowedSpecialWaves;
	private _allSpecialWavesHaveBeenUsed = _allowedSpecialWaves isEqualTo [];
	if (_allSpecialWavesHaveBeenUsed) then {
		_usedSpecialWaves = [];
		localNamespace setVariable ["BLWK_usedSpecialWaveConfigs",_usedSpecialWaves];
		_allowedSpecialWaves = call _getAllowedSpecialWaves;
	};

	_waveConfigPath = selectRandom _allowedSpecialWaves;
	if (isNil "_waveConfigPath") then {
		_waveConfigPath = call _fn_getNormalWave;

	} else {
		_playAlarm = true;
		_usedSpecialWaves pushBack _waveConfigPath;
		localNamespace setVariable ["BLWK_usedSpecialWaveConfigs",_usedSpecialWaves];

	};

} else {
	["Selected a standard wave type",false] call KISKA_fnc_log;
	_waveConfigPath = call _fn_getNormalWave;

};
localNamespace setVariable ["BLWK_currentWaveConfig",_waveConfigPath];
call compileFinal (getText(_waveConfigPath >> "onSelected"));


/* ----------------------------------------------------------------------------
	Send wave start notification
---------------------------------------------------------------------------- */
private _notification = [];
_notification pushBack (getText(_waveConfigPath >> "creationNotificationTemplate"));

private _notificationText = getText(_waveConfigPath >> "notificationText");
if ([_waveConfigPath >> "compileNotificationText"] call BIS_fnc_getCfgDataBool) then {
	_notificationText = call compileFinal _notificationText;

} else {
	_notificationText = [_notificationText];

};
_notification pushBack _notificationText;


private _players = call CBAP_fnc_players;
_notification remoteExec ["BIS_fnc_showNotification", _players];
// play a sound for special waves
if (_playAlarm) then {
	["Alarm"] remoteExec ["playSound", _players];
};


nil

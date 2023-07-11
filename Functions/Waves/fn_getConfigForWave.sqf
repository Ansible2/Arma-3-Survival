/* ----------------------------------------------------------------------------
Function: BLWK_fnc_getConfigForWave

Description:
	Determines what type of wave should happen next and returns the selected
	 wave's config.

	Executed from "BLWK_fnc_startWave"

Parameters:
	NONE

Returns:
	<CONFIG> - The config of the selected wave

Examples:
    (begin example)
		private _waveConfig = call BLWK_fnc_getConfigForWave;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_getConfigForWave";

#define DEFAULT_WAVE_CONFIG missionConfigFile >> "BLWK_waveTypes" >> "normalWaves" >> "standardWave"

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

	DEFAULT_WAVE_CONFIG
};


/* ----------------------------------------------------------------------------
	Select wave type
---------------------------------------------------------------------------- */
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
		_usedSpecialWaves pushBack _waveConfigPath;
		localNamespace setVariable ["BLWK_usedSpecialWaveConfigs",_usedSpecialWaves];

	};

} else {
	["Selected a standard wave type",false] call KISKA_fnc_log;
	_waveConfigPath = call _fn_getNormalWave;

};


private _waveConditionFunctionName = getText(_waveConfigPath >> "condition");
if (_waveConditionFunctionName isNotEqualTo "") then {
	private _waveConditionFunction = missionNamespace getVariable [_waveConditionFunctionName,{true}];
	if !(call _waveConditionFunction) then {
		[
			[
				"Wave condition check failed for: ",
				_waveConfigPath,
				" with the function: ",
				_waveConditionFunctionName,
				". Rerolling for a wave..."
			]
		] call KISKA_fnc_log;
		_waveConfigPath = call BLWK_fnc_getConfigForWave;
	};
};


_waveConfigPath

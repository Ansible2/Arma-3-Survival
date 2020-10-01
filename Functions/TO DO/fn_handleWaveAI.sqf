#include "..\..\Headers\Wave Type Stings.hpp"

params ["_waveType"];


private _fn_getWave = {
	private "_startingWaveUnits";
	if (_waveType == STANDARD_WAVE) exitWith {
		_startingWaveUnits = call BLWK_fnc_createStdWaveInfantry;
		[_startingWaveUnits] call BLWK_fnc_stdEnemyVehicles;
	};
	// CIPHER COMMENT: move this check into the fn_startWave
	if (BLWK_useSpecialWaves) then {
		if (_waveType == SUICIDE_WAVE) exitWith {
			_startingWaveUnits = call BLWK_fnc_createStdWaveInfantry;
			[_startingWaveUnits] call BLWK_fnc_createSuicideWave;
		};
		if (_waveType == AIR_ASSAULT_WAVE) exitWith {

		};
		if (_waveType == CIVILIAN_WAVE) exitWith {
			call BLWK_fnc_createStdWaveInfantry;
			remoteExecCall ["BLWK_fnc_civilianWave",2];
		};
		if (_waveType == DRONE_WAVE) exitWith {
			call BLWK_fnc_createStdWaveInfantry;
			call BLWK_fnc_createDroneWave;
		};
		if (_waveType == MORTAR_WAVE) exitWith {
			_startingWaveUnits = call BLWK_fnc_createStdWaveInfantry;
			[_startingWaveUnits select 0] call BLWK_fnc_createMortarWave;
		};
	};
/*	if (_waveType == STANDARD_WAVE) exitWith {

	};
*/
};

call _fn_getWave;
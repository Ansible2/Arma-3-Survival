#include "..\..\Headers\Wave Type Stings.hpp"

params ["_waveType"];

_fn_decideWave = {
	if (_waveType == STANDARD_WAVE) exitWith {
		private _startingWaveUnits = call BLWK_fnc_createStdWaveInfantry;
		[_startingWaveUnits] call BLWK_fnc_stdEnemyVehicles;
	};
	if (_waveType == SUICIDE_WAVE) exitWith {

	};
	if (_waveType == AIR_ASSAULT_WAVE) exitWith {

	};
	if (_waveType == CIVILIAN_WAVE) exitWith {
		private _startingWaveUnits = call BLWK_fnc_createStdWaveInfantry;
	};
/*	if (_waveType == STANDARD_WAVE) exitWith {

	};
*/
};

call _fn_decideWave;
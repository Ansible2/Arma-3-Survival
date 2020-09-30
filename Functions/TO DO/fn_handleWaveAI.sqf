#include "..\..\Headers\Wave Type Stings.hpp"

params ["_waveType"];

_fn_decideWave = {
	if (_waveType == STANDARD_WAVE) exitWith {
		private _startingWaveUnits = call BLWK_fnc_createStdWaveInfantry;
		call BLWK_fnc_stdEnemyVehicles;
	};
	if (_waveType == SUICIDE_WAVE) exitWith {

	};
	if (_waveType == AIR_ASSAULT_WAVE) exitWith {

	};
	if (_waveType == CIVILIAN_WAVE) exitWith {

	};
/*	if (_waveType == STANDARD_WAVE) exitWith {

	};
*/
};
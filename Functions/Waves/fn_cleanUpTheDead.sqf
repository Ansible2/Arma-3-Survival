/* ----------------------------------------------------------------------------
Function: BLWK_fnc_cleanUpTheDead

Description:
	Cleans up dead bodies according to the mission param BLWK_roundsBeforeBodyDeletion.

	Executed from "BLWK_fnc_startWave"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_cleanUpTheDead;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2
---------------------------------------------------------------------------- */
if (!isServer) exitWIth {};

if (BLWK_roundsBeforeBodyDeletion isEqualTo 0) exitWith {
	allDeadMen apply { deleteVehicle _x };
};

allDeadMen apply { 
	private _numberOfWavesUnitHasBeenDead = _x getVariable ["BLWK_numberOfWavesDead",0];
	if (_numberOfWavesUnitHasBeenDead >= BLWK_roundsBeforeBodyDeletion) then {
		deleteVehicle _x 
	} else {
		_x setVariable ["BLWK_numberOfWavesDead",_numberOfWavesUnitHasBeenDead + 1];
	};
};


nil

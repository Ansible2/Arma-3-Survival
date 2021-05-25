/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleEnemyWeapons

Description:
	Makes sure enemies only have pistols during pistol only waves.
	Also calls BLWK_fnc_randomizeWeapons if random enemy kits
	 param is active.

	Executed from "BLWK_fnc_stdEnemyManCreateCode"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		[_unit] call BLWK_fnc_handleEnemyWeapons;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define PISTOL_MAG_CLASS "16Rnd_9x21_Mag"

scriptName "BLWK_fnc_handleEnemyWeapons";

params ["_unit"];

if (!local _unit) exitWith {
	[[_unit," is not local to you, exiting..."],true] call KISKA_fnc_log;
	nil
};

// handle pistol only wave and random weapons
if (BLWK_currentWaveNumber <= BLWK_maxPistolOnlyWaves) then {
	removeAllWeapons _unit;
	_unit addMagazine PISTOL_MAG_CLASS;
	_unit addMagazine PISTOL_MAG_CLASS;
	_unit addWeapon "hgun_P07_F";
	_unit addHandgunItem PISTOL_MAG_CLASS;

	private _addFirstAidKit = selectRandomWeighted [true,0.5,false,0.5];
	if (_addFirstAidKit) then {
		for "_i" from 1 to (round random [0.51,2,3.49]) do {
			_unit addItem "FirstAidKit";
		};
	};
} else {
	if (BLWK_randomizeEnemyWeapons) then {
		[_unit] call BLWK_fnc_randomizeWeapons;
	};
	[_unit] call BLWK_fnc_optreMedicalToVanilla;
};
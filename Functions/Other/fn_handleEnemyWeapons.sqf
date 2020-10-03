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
	BOOL

Examples:
    (begin example)

		call BLWK_fnc_handleEnemyWeapons;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_unit"];

#define PISTOL_MAG_CLASS "16Rnd_9x21_Mag"

if (!local _unit) exitWith {false};

// handle pistol only wave and random weapons
if (BLWK_currentWaveNumber <= BLWK_maxPistolOnlyWaves) then {
	removeAllWeapons _unit;
	_unit addMagazine PISTOL_MAG_CLASS;
	_unit addMagazine PISTOL_MAG_CLASS;
	_unit addWeapon "hgun_P07_F";
	_unit addHandgunItem PISTOL_MAG_CLASS;

	private _addFirstAidKit = selectRandomWeighted [true,0.5,false,0.5];
	if (_addFirstAidKit) then {
		_unit addItemCargoGlobal ["FirstAidKit",round random [0.51,2,3.49]];
	};
} else {
	if (BLWK_randomizeEnemyWeapons) then {
		[_unit] call BLWK_fnc_randomizeWeapons;
	};
};


true
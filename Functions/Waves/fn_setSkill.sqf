/* ----------------------------------------------------------------------------
Function: BLWK_fnc_setSkill

Description:
	Sets the unit's skill based upon the current wave number

Parameters:
	0: _unit : <OBJECT> - The AI to set skill on

Returns:
	NOTHING

Examples:
    (begin example)

		[aUnit] call BLWK_fnc_setSkill;

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SKILL_LEVEL_1 0.1
#define SKILL_LEVEL_2 0.3
#define SKILL_LEVEL_3 0.45
#define SKILL_LEVEL_4 0.6
#define SKILL_LEVEL_5 0.75
#define AIM_SPEED_MULTIPLIER 0.75
params ["_unit"];

private _fn_getBaseSkill = {
	if (BLWK_currentWaveNumber < 5) exitWith {SKILL_LEVEL_1};
	if (BLWK_currentWaveNumber < 10) exitWith {SKILL_LEVEL_2};
	if (BLWK_currentWaveNumber < 15) exitWith {SKILL_LEVEL_3};
	if (BLWK_currentWaveNumber < 20) exitWith {SKILL_LEVEL_4};
	if (BLWK_currentWaveNumber < 25) exitWith {SKILL_LEVEL_5};
};

private _skillLevel = call _fn_getBaseSkill;

_unit setSkill ["aimingAccuracy", _skillLevel];
_unit setSkill ["aimingSpeed", (_skillLevel * AIM_SPEED_MULTIPLIER)];
_unit setSkill ["aimingShake", _skillLevel];
_unit setSkill ["spotTime", SKILL_LEVEL_2];
_unit setSkill ["general", _skillLevel];
_unit setSkill ["commanding",1];
_unit setSkill ["courage",1];
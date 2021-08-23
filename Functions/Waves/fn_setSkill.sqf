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

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_unit"];

private _skillLevel = BLWK_maxSkill min (BLWK_baseSkill * (BLWK_skillIncriment * BLWK_currentWaveNumber));

_unit setSkill ["aimingAccuracy", _skillLevel];
_unit setSkill ["aimingSpeed", (_skillLevel * BLWK_aimSpeedMod)];
_unit setSkill ["aimingShake", _skillLevel];
_unit setSkill ["spotTime", BLWK_spotTime];
_unit setSkill ["general", _skillLevel];
_unit setSkill ["commanding",1];
_unit setSkill ["courage",1];

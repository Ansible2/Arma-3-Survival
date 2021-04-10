/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleHelicopterWave

Description:
	This is simply an alias for the below functions. It is used to exec
	 both on whomever the AI handler is without using multiple remoteExecs

	Executed from "BLWK_fnc_decideWaveType"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_handleHelicopterWave;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_handleHelicopterWave";

#define DEFAULT_TRANSPORT_HELI "B_Heli_Transport_01_F"
#define DEFAULT_ATTACK_HELI "O_Heli_Attack_02_dynamicLoadout_F"

call BLWK_fnc_createStdWaveInfantry;


private _vehicleArray = [
    BLWK_playAreaCenter,
    BLWK_playAreaRadius,
    _vehicleClass,
    99999,
    10,
    random [40,50,60],
    -1,
    _defaultAircraft,
    "",
    OPFOR
] call BLWK_fnc_passiveHelicopterGunner;

_vehicle = _vehicleArray select 0;
// loop through crew
(_vehicleArray select 1) apply {
    [_x] remoteExecCall ["BLWK_fnc_addToMustKillArray",2];
    [_x] call BLWK_fnc_addStdEnemyManEHs;
    _x allowDamage true;
    _x setSkill 0.05;
};

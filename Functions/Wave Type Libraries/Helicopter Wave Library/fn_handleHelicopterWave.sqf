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
#define TYPE_TRANSPORT 4 // these correspond with the arrays from BLWK_fnc_getEnemyVehicleClasses
#define TYPE_ATTACK 7
#define MIN_WAVE_FOR_ATTACK_HELI 12

call BLWK_fnc_createStdWaveInfantry;

private _fn_spawnHeli = {
    params ["_typeId","_defaultAircraft"];

    // find any vehicles with turrets for gunning
    private _typeArray = [_typeId,false,true] call BLWK_fnc_getEnemyVehicleClasses;
    private _index = _typeArray findIf {
        private _turretsArray = [_x] call KISKA_fnc_classTurretsWithGuns;
        _turretsArray isNotEqualTo [];
    };

    private _vehicleClass = _defaultAircraft;
    if (_index isNotEqualTo -1) then {
        _vehicleClass = _typeArray select _index;
    };

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

    // loop through crew
    (_vehicleArray select 1) apply {
        [_x] remoteExecCall ["BLWK_fnc_addToMustKillArray",2];
        [_x] call BLWK_fnc_addStdEnemyManEHs;
        _x allowDamage true;
        _x setSkill 0.05;
    };
};


[[TYPE_TRANSPORT,DEFAULT_TRANSPORT_HELI],[TYPE_ATTACK,DEFAULT_ATTACK_HELI]] apply {
    _x call _fn_spawnHeli;
    // only spawn an attack helicopter after its been 12 waves
    if (BLWK_currentWaveNumber < MIN_WAVE_FOR_ATTACK_HELI) exitWith {};
};

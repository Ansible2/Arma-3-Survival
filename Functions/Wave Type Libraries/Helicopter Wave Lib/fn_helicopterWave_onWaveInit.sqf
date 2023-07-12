/* ----------------------------------------------------------------------------
Function: BLWK_fnc_helicopterWave_onWaveInit

Description:
    Spawns helicopters for a helicopter wave.   

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_helicopterWave_onWaveInit;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_helicopterWave_onWaveInit";

#define DEFAULT_TRANSPORT_HELI "B_Heli_Transport_01_F"
#define DEFAULT_ATTACK_HELI "O_Heli_Attack_02_dynamicLoadout_F"
#define TYPE_TRANSPORT 4 // these correspond with the arrays from BLWK_fnc_getEnemyVehicleClasses
#define TYPE_ATTACK 7
#define MIN_WAVE_FOR_ATTACK_HELI 12

private _fn_spawnHeli = {
    params ["_typeId","_defaultAircraft"];

    // find any vehicles with turrets for gunning
    private _typeArray = [_typeId,false,true] call BLWK_fnc_getEnemyVehicleClasses;
    private _index = _typeArray findIf {
        private _turretsArray = [_x] call KISKA_fnc_classTurretsWithGuns;
        _turretsArray isNotEqualTo [];
    };

    private _vehicleClass = _defaultAircraft;
    private _validAircraftFound = _index isNotEqualTo -1;
    if (_validAircraftFound) then {
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

    private _crew = _vehicleArray select 1;
    _crew apply {
        [_x] remoteExecCall ["BLWK_fnc_addToMustKillList",2];
        [_x] call BLWK_fnc_spawnQueue_addManEventhandlers;
        
        _x allowDamage true;
        _x setSkill 0.05;
    };

    private _heli = _vehicleArray select 0;
    [_heli] call BLWK_fnc_addVehicleKilledEvent;
};


[[TYPE_TRANSPORT,DEFAULT_TRANSPORT_HELI],[TYPE_ATTACK,DEFAULT_ATTACK_HELI]] apply {
    _x call _fn_spawnHeli;
    // only spawn an attack helicopter after its been 12 waves
    if (BLWK_currentWaveNumber < MIN_WAVE_FOR_ATTACK_HELI) then { break };
};

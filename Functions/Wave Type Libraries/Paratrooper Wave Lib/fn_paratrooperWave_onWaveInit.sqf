/* ----------------------------------------------------------------------------
Function: BLWK_fnc_paratrooperWave_onWaveInit

Description:
    The on wave init for paratrooper waves.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_paratrooperWave_onWaveInit;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_paratrooperWave_onWaveInit";

#define FLY_IN_HEIGHT 200
#define APPROACH_DIRECTION -1
#define NUMBER_OF_UNITS_TO_DROP -1
#define MAX_NUM_PARAS 14
#define DROP_AREA_RADIUS 50

private _startingWaveUnits = call BLWK_fnc_getMustKillList;
private _unitCount = count _startingWaveUnits;
private _dropVehicleClass = selectRandom ([4] call BLWK_fnc_getEnemyVehicleClasses);
private _vehicleCargoCapacity = ([_dropVehicleClass,true] call BIS_fnc_crewCount) - ([_dropVehicleClass,false] call BIS_fnc_crewCount);

private "_numberOfUnitsToDrop";
private _startingUnitsCount = count _startingWaveUnits;
if (_startingUnitsCount < MAX_NUM_PARAS) then {
    _numberOfUnitsToDrop = _startingUnitsCount;
} else {
    _numberOfUnitsToDrop = MAX_NUM_PARAS;
};

// if everyone fits into one vehicle then just exit with one vehicle spawn
if (_numberOfUnitsToDrop <= _vehicleCargoCapacity) exitWith {
    private _dropZone = [BLWK_mainCrate,DROP_AREA_RADIUS] call CBAP_fnc_randPos;
    [
        _dropZone,
        _startingWaveUnits,
        _dropVehicleClass,
        NUMBER_OF_UNITS_TO_DROP,
        APPROACH_DIRECTION,
        FLY_IN_HEIGHT,
        OPFOR
    ] spawn KISKA_fnc_paratroopers;
};


[
    _startingWaveUnits,
    _vehicleCargoCapacity,
    _numberOfUnitsToDrop,
    _dropVehicleClass
] spawn {
    params [
        "_startingWaveUnits",
        "_vehicleCargoCapacity",
        "_numberOfUnitsToDrop",
        "_dropVehicleClass"
    ];

    private _parasAllocated = false;
    private _startCount = 0;
    private _numUnitsAllocated = 0;
    while {!_parasAllocated} do {
        // get units to put into vehicle
        private _unitsToDropForStick = _startingWaveUnits select [_startCount,_vehicleCargoCapacity];

        // drop around The Crate
        private _dropZoneForStick = [BLWK_mainCrate,DROP_AREA_RADIUS] call CBAP_fnc_randPos;
        [
            _dropZoneForStick,
            _unitsToDropForStick,
            _dropVehicleClass,
            NUMBER_OF_UNITS_TO_DROP,
            APPROACH_DIRECTION,
            FLY_IN_HEIGHT,
            OPFOR
        ] spawn KISKA_fnc_paratroopers;

        // check if the amount to drop has been reached
        _numUnitsAllocated = _numUnitsAllocated + _vehicleCargoCapacity;
        if (_numUnitsAllocated >= _numberOfUnitsToDrop) then {
            _parasAllocated = true;
        } else {
            // update select start count
            _startCount = _numUnitsAllocated - 1; // want actual array index
        };

        sleep 5;
    };
};


nil

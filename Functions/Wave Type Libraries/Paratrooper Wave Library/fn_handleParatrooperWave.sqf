/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleParatrooperWave

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

		[] spawn BLWK_fnc_handleParatrooperWave;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define MAX_NUM_PARAS 14
#define DROP_AREA_RADIUS 50

if (!canSuspend) exitWith {
	["Needs to be run in scheduled, exiting to scheduled...",true] call KISKA_fnc_log;
	[] spawn BLWK_fnc_handleParatrooperWave;
};

private _startingWaveUnits = call BLWK_fnc_createStdWaveInfantry;

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
	[_dropZone,_startingWaveUnits,_dropVehicleClass,-1,-1,200,OPFOR] spawn KISKA_fnc_paratroopers;
};


private _parasAllocated = false;
private _startCount = 0;
private _unitsToDrop_temp = [];
private _numUnitsAllocated = 0;
private "_dropZone_temp";
while {!_parasAllocated} do {
	// get units to put into vehicle
	_unitsToDrop_temp = _startingWaveUnits select [_startCount,_vehicleCargoCapacity];

	// drop around The Crate
	_dropZone_temp = [BLWK_mainCrate,DROP_AREA_RADIUS] call CBAP_fnc_randPos;
	[_dropZone_temp,_unitsToDrop_temp,_dropVehicleClass,-1,-1,200,OPFOR] spawn KISKA_fnc_paratroopers;

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

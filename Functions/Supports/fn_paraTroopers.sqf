/* ----------------------------------------------------------------------------
Function: BLWK_fnc_paratroopers

Description:
	

Parameters:
	0: _units : <ARRAY> - An array of units to choose from to drop
	1: _numToDrop : <NUMBER> - The amount of units to drop

Returns:
	BOOL

Examples:
    (begin example)

		call BLWK_fnc_paratroopers;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_dropZone",objNull,[objNull,[]]],
	["_dropVehicleClass","",[""]],
	["_units",[],[[]]],
	["_numToDrop",0,[123]],
	["_side",BLUFOR,[BLUFOR]],
	["_distanceFromDropZone",1000,[123]],
	["_flyDirection",-1,[123]],
	["_flyInHeight",300,[123]]
];

// check params
if ((_dropZone isEqualType objNull AND {isNull _dropZone}) OR {_dropzone isEqualTo []}) exitWith {
	["%1 is invalid _dropZone",_dropZone] call BIS_fnc_error;
	false
};
if (_dropVehicleClass isEqualTo "") exitWith {
	"_dropVehicleClass isEqualTo ''" call BIS_fnc_error;
	false
};
if (_unitsToDrop isEqualTo []) exitWith {
	"_unitsToDrop isEqualTo []" call BIS_fnc_error;
	false
};
if (_numToDrop < 1) exitWith {
	"_numToDrop < 1" call BIS_fnc_error;
	false
};
if (_distanceFromDropZone < 0) exitWith {
	"_distanceFromDropZone can't be a negative number" call BIS_fnc_error;
	false
};

if (_numToDrop isEqualTo 0) then {
	_numToDrop = count _units;
};

// create drop vehicle(s)
private [
	"_spawnPosition_temp",
	"_flyFromDirection_temp",
	"_vehicleArray_temp",
	"_aircraft_temp",
	"_aircraftGroup_temp",
	"_unitsToDrop_temp",
	"_positionsToAvailable_temp",
	"_deletionPosition_temp",
	"_pushBackUnit_temp"
];
private _positionsRequired = _numToDrop;
private _createdEnoughVehicles = false;
while {!_createdEnoughVehicles} do {
	if (_flyDirection < 0) then {
		_flyDirection = round (random 360);
	};

	// get spawn position
	_flyFromDirection_temp = [_flyDirection + 180] call CBAP_fnc_simplifyAngle;
	_spawnPosition_temp = _dropZone getPos [_distanceFromDropZone,_flyFromDirection_temp];
	_spawnPosition_temp set [2,_flyInHeight];

	// create vehicle
	_vehicleArray_temp = [_spawnPosition_temp,_flyDirection,_dropVehicleClass,_side] call BIS_fnc_spawnVehicle;
	_aircraft_temp = _vehicleArray_temp select 0;
	_aircraftGroup_temp = _vehicleArray_temp select 2;

	// check if there is enough room in this vehicle to drop everyone
	_positionsToAvailable_temp = _aircraft_temp emptyPositions "cargo";
	_positionsRequired = _positionsRequired - _positionsToAvailable_temp;
	if (_positionsRequired <= 0) then {
		_createdEnoughVehicles = true;
	};

	// get drop units and move in cargo
	_unitsToDrop_temp = [];
	for "_i" from 1 to _positionsToAvailable_temp do {
		_pushBackUnit_temp = _unitsToDrop deleteAt 0;
		_pushBackUnit_temp moveInCargo _aircraft_temp;
		_unitsToDrop_temp pushBack _pushBackUnit_temp;
	};

	
	_aircraft_temp move _dropZone;
	_aircraft_temp flyInHeight _flyInHeight;
	
	_deletionPosition_temp = _dropZone getPos [5000,_flyDirection];
	null = [_aircraft_temp,_aircraftGroup_temp,_dropZone,_unitsToDrop_temp,_deletionPosition_temp] spawn {
		params ["_aircraft","_aircraftGroup","_dropZone","_unitsToDrop","_deletePosition"];

		private _distanceToStartDrop = round (((count _unitsToDrop) / 2) * 5);
		waitUntil {
			if ((_aircraft distance2D _dropZone) <= _distanceToStartDrop) exitWith {true};
			if (isNull _aircraft) exitWith {true};
			sleep 1;
			false
		};
		if (isNull _aircraft) exitWith {};
		// drop units
		[_unitsToDrop,false] call KISKA_fnc_staticLine;
		
		// waitUntil all drop units are out of aircraft
		private _crewCount = count (units _aircraftGroup);
		waitUntil {
			if (_crewCount isEqualTo (count crew _aircraft)) exitWith {true};
			if (isNull _aircraft) exitWith {true};
			sleep 0.25;
			false
		};
		if (isNull _aircraft) exitWith {};

		// go to deletion point
		[
			_aircraftGroup,
			_deletePosition,
			-1,
			"MOVE",
			"SAFE",
			"BLUE",
			"NORMAL",
			"NO CHANGE",
			"
				private _aircraft = objectParent this;
				thisList apply {
					_aircraft deleteVehicleCrew _x;
				};
				deleteVehicle _aircraft;
			",
			[0,0,0],
			100
		] call CBAP_fnc_addWaypoint;
	};
};



/*
BLWK_fnc_paraTroopers = {
	params [
		["_dropZone",objNull,[objNull,[]]],
		["_dropVehicleClass","",[""]],
		["_unitsToDrop",[],[[]]],
		["_numToDrop",0,[123]],
		["_side",BLUFOR,[BLUFOR]],
		["_distanceFromDropZone",1000,[123]],
		["_flyDirection",-1,[123]],
		["_flyInHeight",300,[123]]
	];

	// check params
	if ((_dropZone isEqualType objNull AND {isNull _dropZone}) OR {_dropzone isEqualTo []}) exitWith {
		["%1 is invalid _dropZone",_dropZone] call BIS_fnc_error;
		false
	};
	if (_dropVehicleClass isEqualTo "") exitWith {
		"_dropVehicleClass isEqualTo ''" call BIS_fnc_error;
		false
	};
	if (_unitsToDrop isEqualTo []) exitWith {
		"_unitsToDrop isEqualTo []" call BIS_fnc_error;
		false
	};
	if (_numToDrop < 0) exitWith {
		"_numToDrop < 0" call BIS_fnc_error;
		false
	};
	if (_distanceFromDropZone < 0) exitWith {
		"_distanceFromDropZone can't be a negative number" call BIS_fnc_error;
		false
	};

	if (_numToDrop isEqualTo 0) then {
		_numToDrop = count _unitsToDrop;
	};
	if (_dropZone isEqualType objNull) then {
		_dropZone = getPosATL _dropZone;
	};
	// create drop vehicle(s)
	private [
		"_spawnPosition_temp",
		"_flyFromDirection_temp",
		"_vehicleArray_temp",
		"_aircraft_temp",
		"_aircraftGroup_temp",
		"_unitsToDrop_temp",
		"_availableCargoPositionsCount_temp",
		"_deletionPosition_temp",
		"_pushBackUnit_temp"
	];
	private _positionsRequired = _numToDrop;
	private _createdEnoughVehicles = false;
	while {!_createdEnoughVehicles} do {
		if (_flyDirection < 0) then {
			_flyDirection = round (random 360);
		};

		// get spawn position
		_flyFromDirection_temp = [_flyDirection + 180] call CBA_fnc_simplifyAngle;
		_dropZone set [2,_flyInHeight];
		_spawnPosition_temp = _dropZone getPos [_distanceFromDropZone,_flyFromDirection_temp];
		_spawnPosition_temp set [2,_flyInHeight];

		// create vehicle
		_vehicleArray_temp = [_spawnPosition_temp,_flyDirection,_dropVehicleClass,_side] call BIS_fnc_spawnVehicle;
		_aircraft_temp = _vehicleArray_temp select 0;
		allCurators apply {_x addCuratorEditableObjects [[_aircraft_temp],true]};
		_aircraft_temp flyInHeight _flyInHeight;
		_aircraftGroup_temp = _vehicleArray_temp select 2;
		_aircraftGroup_temp setBehaviour "SAFE";

		// check if there is enough room in this vehicle to drop everyone
		_availableCargoPositionsCount_temp = _aircraft_temp emptyPositions "cargo";
		_positionsRequired = _positionsRequired - _availableCargoPositionsCount_temp;
		if (_positionsRequired <= 0) then {
			_createdEnoughVehicles = true;
		};

		// get drop units and move in cargo
		_unitsToDrop_temp = [];
		private _cargoPositionsFilled = false;
		while {!_cargoPositionsFilled} do {
			if (_unitsToDrop isEqualTo []) exitWith {
				_cargoPositionsFilled = true
			};
			_pushBackUnit_temp = _unitsToDrop deleteAt 0;
			_pushBackUnit_temp moveInCargo _aircraft_temp;
			_unitsToDrop_temp pushBack _pushBackUnit_temp;
		};

		(leader _aircraftGroup_temp) doMove _dropZone;
		
		_deletionPosition_temp = _dropZone getPos [5000,_flyDirection];
		null = [_aircraft_temp,_aircraftGroup_temp,_dropZone,_unitsToDrop_temp,_deletionPosition_temp] spawn {
			params ["_aircraft","_aircraftGroup","_dropZone","_unitsToDrop","_deletePosition"];

			private _distanceToStartDrop = round (((count _unitsToDrop) / 2) * 5);
			waitUntil {
				if ((_aircraft distance2D _dropZone) <= 100) exitWith {true};
				if (isNull _aircraft) exitWith {true};
				sleep 0.1;
				false
			};
			if (isNull _aircraft) exitWith {};

			hint "reached drop";
		
			[_unitsToDrop,false] call KISKA_fnc_staticLine;
			//_aircraft move _deletePosition;
			(leader _aircraftGroup) doMove _deletePosition;
		};
	};
};

*/
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paratroopers

Description:
	Takes a set of units and moves them into aircraft to be dropped over a position
	 via parachute from a spawned vehicle

Parameters:
	0: _dropZone : <OBJECT or ARRAY> - Target of where to drop the units
	1: _unitsThatCanDrop : <ARRAY> - An array of units that can be dropped
	2: _dropVehicleClass : <STRING> - What vehicle class will drop the units
	3: _numToDrop : <NUMBER> - The number of units out of the array to drop
		(if -1, will resize to the amount of units in _unitsToDrop)
	4: _flyDirection : <NUMBER> - The direction that the aircraft will fly towards _dropZone
		(if -1, will be random direction)
	5: _flyInHeight : <NUMBER> - The flyInHeight of the aircraft
	6: _side : <SIDE> - What side is the drop aircraft
	7: _spawnDistance : <NUMBER> - How far away should the aircraft spawn
	8: _invincibleOnDrop : <BOOL> - Should the units be invincible while parachuting down

Returns:
	NOTHING

Examples:
    (begin example)
		[] spawn KISKA_fnc_paratroopers;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paratroopers";

if (!canSuspend) exitWith {
	["Needs to be run in scheduled; Exiting to scheduled...",true] call KISKA_fnc_log;
	_this spawn KISKA_fnc_paratroopers;
};

params [
	["_dropZone",objNull,[objNull,[]]],
	["_unitsThatCanDrop",[],[[]]],
	["_dropVehicleClass","",[""]],
	["_numToDrop",-1,[123]],
	["_flyDirection",-1,[123]],
	["_flyInHeight",200,[123]],
	["_side",BLUFOR,[BLUFOR]],
	["_spawnDistance",2000,[123]],
	["_invincibleOnDrop",false,[true]]
];

// check params
if ((_dropZone isEqualType objNull AND {isNull _dropZone}) OR {_dropzone isEqualTo []}) exitWith {
	[[str _dropZone," is an invalid _dropZone"],true] call KISKA_fnc_log;
	nil
};
if (_dropVehicleClass isEqualTo "") exitWith {
	["_dropVehicleClass isEqualTo ''",true] call KISKA_fnc_log;
	nil
};
if (_unitsThatCanDrop isEqualTo []) exitWith {
	["_unitsThatCanDrop isEqualTo []",true] call KISKA_fnc_log;
	nil
};
if (_numToDrop < -1 OR {_numToDrop isEqualTo 0}) exitWith {
	[["_numToDrop is improper number: ",_numToDrop],true] call KISKA_fnc_log;
	nil
};
if (_spawnDistance < 0) exitWith {
	[["_spawnDistance can't be a negative number: ",_spawnDistance],true] call KISKA_fnc_log;
	nil
};

// make sure vehicle can hold the number of units to drop and adjust accordingly
private _unitCount = count _unitsThatCanDrop;
if (_numToDrop isEqualTo -1 OR {_unitCount < _numToDrop}) then {
	_numToDrop = _unitCount;
};
private _vehicleCargoCapacity = ([_dropVehicleClass,true] call BIS_fnc_crewCount) - ([_dropVehicleClass,false] call BIS_fnc_crewCount);
if (_numToDrop > _vehicleCargoCapacity) then {
	[["vehicle class: ",_dropVehicleClass," has ",_vehicleCargoCapacity," cargo positions, requested",_numToDrop,"to be dropped!"],true] call KISKA_fnc_log;
	_numToDrop = _vehicleCargoCapacity;
};

if (_dropZone isEqualType objNull) then {
	_dropZone = getPosATL _dropZone;
};

if (_flyDirection < 0) then {
	_flyDirection = round (random 360);
};

// get spawn position
private _flyFromDirection = [_flyDirection + 180] call CBAP_fnc_simplifyAngle;
_dropZone set [2,_flyInHeight];
private _spawnPosition = _dropZone getPos [_spawnDistance,_flyFromDirection];
_spawnPosition set [2,_flyInHeight];

// create vehicle
private _vehicleArray = [_spawnPosition,_flyDirection,_dropVehicleClass,_side] call KISKA_fnc_spawnVehicle;
private _aircraft = _vehicleArray select 0;
allCurators apply {
	[_x,[[_aircraft],true]] remoteExecCall ["addCuratorEditableObjects",2];
};
_aircraft flyInHeight _flyInHeight;
private _aircraftGroup = _vehicleArray select 2;
_aircraftGroup setBehaviour "SAFE";

// move units into vehicle cargo
private _unitsToDrop = [];
_unitsThatCanDrop apply {
	if (_numToDrop isEqualTo 0) exitWith {};
	_x moveInCargo _aircraft;
	_unitsToDrop pushBack _x;
};

// move to drop zone
(leader _aircraftGroup) doMove _dropZone;
private _deletePosition = _dropZone getPos [5000,_flyDirection];

waitUntil {
	if ((_aircraft distance2D _dropZone) <= 100) exitWith {true};
	if (isNull _aircraft) exitWith {true};
	sleep 0.25;
	false
};
if (isNull _aircraft) exitWith {};

// get units out of aircraft
[_unitsToDrop,_invincibleOnDrop] call KISKA_fnc_staticLine;
// move to deletion point
[
	_aircraftGroup,
	_deletePosition,
	-1,
	"MOVE",
	"SAFE",
	"BLUE",
	"FULL",
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


nil

/* ----------------------------------------------------------------------------
Function: BLWK_fnc_daisyCutter

Description:
	Spawns in an aircraft that flies over a DZ to drop off a daisy cutter.

	Once the "bomb" hits the ground, trees dissappear.

Parameters:
	0: _dropPosition <OBJECT, GROUP, ARRAY, LOCATION, TASK> - Position you want the drop to be near
  	1: _radius <NUMBER> - The radius from the position to cut down foliage
	2: _vehicleClass : <STRING> - The class of the vehicle to drop the

Returns:
	NOTHING

Examples:
    (begin example)
		[] spawn BLWK_fnc_daisyCutter;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define DROP_ALT 200
#define FLY_RADIUS 2000

scriptName "BLWK_fnc_daisyCutter";

if (!canSuspend) exitWith {
	["Must be run in scheduled. Exiting to scheduled...",true] call KISKA_fnc_log;
	_this spawn BLWK_fnc_daisyCutter;
};

params [
	"_dropPosition",
	"_radius",
	"_vehicleClass"
];

if (_dropPosition isEqualType objNull) then {
	_dropPosition = getPosATL _dropPosition;
};

// get directions for vehicle to fly
private _flyDirection = round (random 360);
private _flyFromDirection = [_flyDirection + 180] call CBAP_fnc_simplifyAngle;
private _spawnPosition = _dropPosition getPos [FLY_RADIUS,_flyFromDirection];
_spawnPosition set [2,DROP_ALT];

private _relativeDirection = _spawnPosition getDir _dropPosition;

// spawn vehicle
private _vehicleArray = [_spawnPosition,_relativeDirection,_vehicleClass,BLUFOR] call KISKA_fnc_spawnVehicle;

private _aircraftCrew = _vehicleArray select 1;
_aircraftCrew apply {
	_x setCaptive true;
};

private _aircraft = _vehicleArray select 0;
_aircraft flyInHeight DROP_ALT;
_airCraft move _dropPosition;

// give it a waypoint and delete it after it gets there
private _flyToPosition = _dropPosition getPos [FLY_RADIUS,_relativeDirection];

waitUntil {
	if (_aircraft distance2D _dropPosition < 40) exitWith {true};
	sleep 0.25;
	false
};

private _aircraftGroup = _vehicleArray select 2;
// go to deletion point
[
	_aircraftGroup,
	_flyToPosition,
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
	50
] call CBAP_fnc_addWaypoint;


sleep 0.1;

private _aircraftAlt = (getPosATL _aircraft) select 2;
private _bombSpawnPosition = _aircraft getRelPos [15,180];
private _bomb = createSimpleObject ["a3\weapons_f\ammo\bomb_01_fly_f.p3d",[0,0,0]];


// create it's parachute
_chute = createVehicle ["b_parachute_02_F",[0,0,0]];
_chute setPosATL (_bombSpawnPosition vectorAdd [random [-5,0,5],random [-5,0,5],_aircraftAlt]);
_bomb attachTo [_chute,[0,0,0]];
_bomb setVectorDirAndUp [[0,0.01,1],[0,0,1]];


// speed up the drop

// give chute time to deploy
sleep 3;

private "_chuteVelocity";
private _chuteHeight = (getPosATLVisual _chute) select 2;
while {sleep 0.03; _chuteHeight > 5} do {

	//_chuteVelocity = velocityModelSpace _chute;
	_chute setVelocityModelSpace [0,0,-10];
	_chuteHeight = (getPosATLVisual _chute) select 2;
};

private _landPosition = position _bomb;
[_landPosition,_radius] remoteExecCall ["BLWK_fnc_hideFoliage",2];

detach _bomb;
deleteVehicle _bomb;

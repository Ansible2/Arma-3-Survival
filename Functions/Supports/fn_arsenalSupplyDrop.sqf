/* ----------------------------------------------------------------------------
Function: BLWK_fnc_arsenalSupplyDrop

Description:
	Sets the unit's skill based upon the current wave number

Parameters:
	0: _dropPosition : <ARRAY> - The position (area) to drop the arsenal
  	1: _vehicleClass : <STRING> - The class of the vehicle to drop the

Returns:
	NOTHING

Examples:
    (begin example)

		[myPosition,"B_T_VTOL_01_vehicle_F"] call BLWK_fnc_arsenalSupplyDrop;

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define DROP_ALT 700
#define FLY_RADIUS 1000
#define ARSENAL_LIFETIME 300
params [
	"_dropPosition",
	["_vehicleClass","B_T_VTOL_01_vehicle_F",[""]]
];

// get directions for vehicle to fly 
private _flyDirection = round (random 360);
private _flyFromDirection = [_flyDirection] call CBAP_fnc_simplifyAngle;
private _spawnPosition = _dropPosition getPos [FLY_RADIUS,_flyFromDirection];
_spawnPosition set [2,DROP_ALT];

// spawn vehicle
private _vehicleArray = [_spawnPosition,_flyDirection,_vehicleClass,BLUFOR] call BIS_fnc_spawnVehicle
private _aircraft = _vehicleArray select 0;
private _aircraftCrew = _vehicleArray select 1;
_aircraftCrew apply {
	_x setCaptive true;
};
private _aircraftGroup = _vehicleArray select 2;
_aircraft flyInHeight DROP_ALT;

// give it a waypoint and delete it after it gets there
private _flyToPosition = _dropPosition getPos [FLY_RADIUS,_flyDirection];
[
	_aircraftGroup,
	_flyToPosition,
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
	50
] call CBAP_fnc_addWaypoint;

null = [_aircraft,_dropPosition] spawn {
	params ["_aircraft","_dropPosition"];
	waitUntil {
		if (_aircraft distance2D _dropPosition < 20) exitWith {true};
		sleep 1;
		false
	};

	sleep 1;
	
	private _aircraftAlt = (getPosATL _aircraft) select 2;
	private _boxSpawnPosition = _aircraft getRelPos [15,180];
	private _arsenalBox = ([["B_supplyCrate_F"],_aircraftAlt,_boxSpawnPosition] call KISKA_fnc_supplyDrop) select 0;
	clearMagazineCargoGlobal _arsenalBox;
	clearWeaponCargoGlobal _arsenalBox;
	clearBackpackCargoGlobal _arsenalBox;
	clearItemCargoGlobal _arsenalBox;
	
	// make sure it's on the ground before we start the countdown to deletetion
	waitUntil {
		if (((getPosATL _arsenalBox) select 2) < 2) exitWith {true};
		sleep 5;
		false
	};

	sleep ARSENAL_LIFETIME;
	
	[[_arsenalBox]] call KISKA_fnc_removeArsenal;
	sleep 2;
	deleteVehicle _arsenalBox;
};
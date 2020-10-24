/* ----------------------------------------------------------------------------
Function: BLWK_fnc_arsenalSupplyDrop

Description:
	Spawns in an aircraft that flies over a DZ to drop off an arsenal.

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
#define DROP_ALT 200
#define FLY_RADIUS 2000
#define ARSENAL_LIFETIME 300
params [
	"_dropPosition",
	["_vehicleClass","B_T_VTOL_01_vehicle_F",[""]]
];

// get directions for vehicle to fly 
private _flyDirection = round (random 360);
private _flyFromDirection = [_flyDirection + 180] call CBAP_fnc_simplifyAngle;
private _spawnPosition = _dropPosition getPos [FLY_RADIUS,_flyFromDirection];
_spawnPosition set [2,DROP_ALT];

private _relativeDirection = _spawnPosition getDir _dropPosition;

// spawn vehicle
private _vehicleArray = [_spawnPosition,_relativeDirection,_vehicleClass,BLUFOR] call BIS_fnc_spawnVehicle;
private _aircraft = _vehicleArray select 0;
private _aircraftCrew = _vehicleArray select 1;

_aircraftCrew apply {
	_x setCaptive true;
};
private _aircraftGroup = _vehicleArray select 2;
_aircraft flyInHeight DROP_ALT;

_airCraft move _dropPosition;

// give it a waypoint and delete it after it gets there
private _flyToPosition = _dropPosition getPos [FLY_RADIUS,_relativeDirection];

null = [_aircraft,_dropPosition,_aircraftGroup,_flyToPosition] spawn {
	params ["_aircraft","_dropPosition","_aircraftGroup","_flyToPosition"];
	waitUntil {
		if (_aircraft distance2D _dropPosition < 40) exitWith {true};
		sleep 0.25;
		false
	};

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


	// notify players of arsenal status
	_arsenalBox addEventHandler ["Deleted", {
		hint "Arsenal is deleted";
		missionNamespace setVariable ["BLWK_arsenalOut",true,true];
	}];
	
	private _timeBetweenMessages = ARSENAL_LIFETIME / 5;
	private ["_increment","_timeLeft","_message"];
	for "_i" from 1 to 5 do {
		
		_increment = switch _i do {
			case 1: {5};
			case 2: {4};
			case 3: {3};
			case 4: {2};
			case 5: {1};
		};
		_timeLeft = floor (_timeBetweenMessages * _increment);
		_message = "Arsenal Has " + _timeLeft + " Seconds Left"
		
		null = [_message] remoteExec ["hint",BLWK_allClientsTargetID];
		
		sleep _timeBetweenMessages;
	};
	
	[[_arsenalBox]] call KISKA_fnc_removeArsenal;
	sleep 2;
	deleteVehicle _arsenalBox;
};
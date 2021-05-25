/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createDroneWave

Description:
	Creates the the wave of drones that drop bombs from overhead

	Executed from "BLWK_fnc_handleDroneWave"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		[] spawn BLWK_fnc_createDroneWave;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define DRONE_CLASS "C_IDAP_UAV_06_antimine_F"
#define DRONE_NUMBER 12
#define FLY_HEIGHT 10

if (!canSuspend) exitWith {
	["Must be run in scheduled environment, exiting to scheduled",true] call KISKA_fnc_log;
	[] spawn BLWK_fnc_createDroneWave;
};

missionNamespace setVariable ["BLWK_allDronesCreated",false,[0,2] select isMultiplayer];

private [
	"_drone_temp",
	"_droneArray_temp",
	"_spawnPosition_temp",
	"_flyDirection",
	"_flyFromDirection",
	"_droneGroup_temp"
];
for "_i" from 1 to DRONE_NUMBER do {
	_droneGroup_temp = createGroup OPFOR;
	// get directions for vehicle to fly 
	_flyDirection = round (random 360);
	_flyFromDirection = [_flyDirection + 180] call CBAP_fnc_simplifyAngle;
	_spawnPosition_temp = BLWK_mainCrate getPos [BLWK_playAreaRadius + (random [100,125,150]),_flyFromDirection];
	_spawnPosition_temp set [2,FLY_HEIGHT];

	// create drone
	_droneArray_temp = [_spawnPosition_temp, _flyDirection, DRONE_CLASS, _droneGroup_temp] call BIS_fnc_spawnVehicle;
	_drone_temp = _droneArray_temp select 0;
	_drone_temp flyInHeight FLY_HEIGHT;
	_drone_temp setSkill 1;

	// attack The Crate
	[_drone_temp,_droneGroup_temp,_spawnPosition_temp] spawn {
		params [
			"_drone",
			"_droneGroup",
			"_spawnPosition"
		];

		private _distanceToFire = FLY_HEIGHT + 37;
		while {alive _drone} do {
			_drone move (position BLWK_mainCrate);

			// wait to be in position to fire
			waitUntil {
				if !(alive _drone) exitWith {true};
				if (
					(_drone distance BLWK_mainCrate) <= _distanceToFire OR 
					// sometimes units can just slightly out of the ideal 3d range
					{(_drone distance2D BLWK_mainCrate) <= 10} 
				) exitWith {true};

				sleep 2;
				false
			};
			
			// do fire
			waitUntil {
				if !(alive _drone) exitWith {true};
				if (_drone fireAtTarget [BLWK_mainCrate]) exitWith {true};
				
				sleep 2;
				false
			};

			// move back to spawn
			_drone move _spawnPosition;
			waitUntil {
				if !(alive _drone) exitWith {true};
				if ((_drone distance2d _spawnPosition) <= 10) exitWith {true};
				
				sleep 2;
				false
			};

		};
	};

	// add hit event
	_drone_temp addEventHandler ["HIT",{
		params ["_unitKilled", "", "", "_instigator"];

		if (isPlayer _instigator) then {
			private _points = [_unitKilled] call BLWK_fnc_getPointsForKill;
			[_points] remoteExecCall ["BLWK_fnc_addPoints",_instigator];
			[_unitKilled,_points,true] remoteExecCall ["BLWK_fnc_createHitMarker",_instigator];
		};

		private _explosion = "DemoCharge_Remote_Ammo_Scripted" createVehicle (getPosATLVisual _unitKilled);
		_explosion setdamage 1;
		deleteVehicle _unit;
	}];

	[_drone_temp] remoteExec ["BLWK_fnc_addToMustKillArray",2];
	[BLWK_zeus,[[_drone_temp], true]] remoteExecCall ["addCuratorEditableObjects",2]; 	
	
	// space out spawns so that you don't get spammed
	sleep 10;
};

missionNamespace setVariable ["BLWK_allDronesCreated",true,[0,2] select isMultiplayer];
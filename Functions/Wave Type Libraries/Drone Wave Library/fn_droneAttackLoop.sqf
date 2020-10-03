/* ----------------------------------------------------------------------------
Function: BLWK_fnc_droneAttackLoop

Description:
	Loops to simulate the drones attacking the Bulwark by dropping bombs ever so often

	Executed from "BLWK_fnc_createDroneWave"

Parameters:
	0: _droneGroup : <GROUP> - The group of drones to do the attacking

Returns:
	NOTHING

Examples:
    (begin example)

		null = [_droneGroup] spawn BLWK_fnc_droneAttackLoop;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!canSuspend) exitWith {};

params ["_droneGroup"];

waitUntil {
	if ((leader _droneGroup) distance2D bulwarkBox <= 25) exitWith {true};
	sleep 3;
	false
};

private ["_didFire","_droneTofire"];
private _droneGroupUnits = units _droneGroup;
while {!(_droneGroupUnits isEqualTo [])} do {
	_droneTofire = selectRandom _droneGroupUnits;
	
	_didFire = _drone fireAtTarget [bulwarkBox];
	if (_didFire) then {
		sleep 20;
	} else {
		sleep 5;
	};

	_droneGroupUnits = units _droneGroup;
};	

deleteGroup _droneGroup;
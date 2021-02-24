/* ----------------------------------------------------------------------------
Function: BLWK_fnc_droneAttackLoop

Description:
	Loops to simulate the drones attacking The Crate by dropping bombs ever so often

	Executed from "BLWK_fnc_createDroneWave"

Parameters:
	0: _droneGroup : <GROUP> - The group of drones to do the attacking

Returns:
	NOTHING

Examples:
    (begin example)

		[_droneGroup] spawn BLWK_fnc_droneAttackLoop;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!canSuspend) exitWith {};

params ["_droneGroup"];

waitUntil {
	if ((leader _droneGroup) distance2D BLWK_mainCrate <= 25) exitWith {true};
	sleep 3;
	false
};

private ["_didFire","_droneTofire"];
private _droneGroupUnits = units _droneGroup;
while {!(_droneGroupUnits isEqualTo [])} do {
	_droneTofire = selectRandom _droneGroupUnits;
	
	_didFire = _droneTofire fireAtTarget [BLWK_mainCrate];
	if (_didFire) then {
		sleep 10;
	} else {
		sleep 5;
	};

	_droneGroupUnits = units _droneGroup;
};	

deleteGroup _droneGroup;
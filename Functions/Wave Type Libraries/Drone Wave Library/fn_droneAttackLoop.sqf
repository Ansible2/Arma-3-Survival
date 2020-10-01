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
#define DRONE_CLASS "C_IDAP_UAV_06_antimine_F"
#define DRONE_NUMBER 12

private _droneGroup = createGroup OPFOR;
private _spawnPosition = [BLWK_playAreaMarker,true] call CBAP_fnc_randPosArea;
for "_i" from 1 to DRONE_NUMBER do {
	
	_drone = [_location, 50, "C_IDAP_UAV_06_antimine_F", _droneGroup] call BIS_fnc_spawnVehicle;
};
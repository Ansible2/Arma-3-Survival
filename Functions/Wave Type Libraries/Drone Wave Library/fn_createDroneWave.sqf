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

		call BLWK_fnc_createDroneWave;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define DRONE_CLASS "C_IDAP_UAV_06_antimine_F"
#define DRONE_NUMBER 12

private _droneGroup = createGroup OPFOR;
private _playAreaRadiusExtended = BLWK_playAreaRadius + 100;

private ["_drone_temp","_droneArray_temp","_spawnPosition_temp","_rotation_temp"];
for "_i" from 1 to DRONE_NUMBER do {
	_spawnPosition_temp = [[BLWK_playAreaCenter,_playAreaRadiusExtended,_playAreaRadiusExtended,0,false],true] call CBAP_fnc_randPosArea;
	_rotation_temp = _spawnPosition_temp getDir BLWK_playAreaCenter; // face the BLWK_playAreaCenter

	// these will wpawn in the air
	_droneArray_temp = [_spawnPosition_temp, _rotation_temp, DRONE_CLASS, _droneGroup] call BIS_fnc_spawnVehicle;
	_drone_temp = _droneArray_temp select 0;
	_drone_temp flyInHeight 30;
	// CIPHER COMMENT: Skill might not be needed
	_drone_temp setSkill 1;

	_drone_temp addEventHandler ["HIT",{
		params ["_unitKilled", "_source", "_damage", "_instigator"];

		if (isPlayer _instigator) then {
			private _points = [_unitKilled] call BLWK_fnc_getPointsForKill;
			[_points] remoteExecCall ["BLWK_fnc_addPoints",_instigator];
			[_unitKilled,_points,true] remoteExecCall ["BLWK_fnc_createHitMarker",_instigator];
		};

		private _explosion = "HandGrenade" createVehicle (getPosATLVisual _unitKilled);
		_explosion setdamage 1;
		deleteVehicle _unit;
	}];

	null = [_drone_temp] remoteExec ["BLWK_fnc_addToMustKillArray",2];
};

[_droneGroup, bulwarkBox, 20, "SAD", "AWARE"] call CBAP_fnc_addWaypoint; 

// make the drones drop bombs every so often
null = [_droneGroup] spawn BLWK_fnc_droneAttackLoop;

[BLWK_zeus,[units _droneGroup, true]] remoteExec ["addCuratorEditableObjects",2]; 
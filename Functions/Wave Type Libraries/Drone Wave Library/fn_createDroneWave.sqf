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

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define DRONE_CLASS "C_IDAP_UAV_06_antimine_F"
#define DRONE_NUMBER 12

private _droneGroup = createGroup OPFOR;
private _playAreaRadiusExtended = BLWK_playAreaRadius + 100;
private "_droneTemp";
private _spawnPosition = [[BLWK_playAreaCenter,_playAreaRadiusExtended,_playAreaRadiusExtended,0,false],true] call CBAP_fnc_randPosArea;
private _rotation = _spawnPosition getDir BLWK_playAreaCenter;

for "_i" from 1 to DRONE_NUMBER do {
	// these will wpawn in the air
	_droneTemp = [_spawnPosition, _rotation, DRONE_CLASS, _droneGroup] call BIS_fnc_spawnVehicle;
	_droneTemp flyInHeight 30;
	// CIPHER COMMENT: Skill might not be needed
	_droneTemp setSkill 1;

	_droneTemp addEventHandler ["HIT",{
		private _unitKilled = _this select 0;
		private _instigator = _this select 3;

		if (isPlayer _instigator) then {
			private _points = [_unitKilled] call BLWK_fnc_getPointsForKill;
			[_points] remoteExecCall ["BLWK_fnc_createHitMarker",_instigator];
			[_points] remoteExecCall ["BLWK_fnc_addPoints",_instigator];
		};

		private _explosion = "HandGrenade" createVehicle (getPos _unitKilled);
		_explosion setdamage 1;
		deleteVehicle _unit;
	}];

	null = [_droneTemp] remoteExec ["BLWK_fnc_addToMustKillArray",2];
};

[_droneGroup, bulwarkBox, 20, "SAD", "AWARE"] call CBAP_fnc_addWaypoint; 

// make the drones drop bombs every so often
null = [_droneGroup] spawn BLWK_fnc_droneAttackLoop;

[BLWK_zeus,[units _droneGroup, true]] remoteExec ["addCuratorEditableObjects",2]; 
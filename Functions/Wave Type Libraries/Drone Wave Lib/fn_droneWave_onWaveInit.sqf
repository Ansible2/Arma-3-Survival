/* ----------------------------------------------------------------------------
Function: BLWK_fnc_droneWave_onWaveInit

Description:
    The on wave init for drone waves. Spawns the drones and adds them to the
     must kill list

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_droneWave_onWaveInit;
    (end)

Author(s):
    Hilltop(Willtop) & omNomios,
    Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_droneWave_onWaveInit";

#define DRONE_CLASS "C_IDAP_UAV_06_antimine_F"
#define DRONE_NUMBER 12
#define FLY_HEIGHT 10
#define DRONE_SPAWN_OFFSET 10

localNamespace setVariable ["BLWK_droneWave_allDronesCreated",false];

[] spawn {
    for "_i" from 1 to DRONE_NUMBER do {
        // Spawn position
        private _droneGroup = createGroup OPFOR;
        private _flyDirection = round (random 360);
        private _flyFromDirection = [_flyDirection + 180] call CBAP_fnc_simplifyAngle;
        private _spawnPosition = [
            BLWK_mainCrate,
            BLWK_playAreaRadius + (random [100,125,150]),
            _flyFromDirection
        ] call KISKA_fnc_getPosRelativeSurface;
        _spawnPosition vectorAdd [0,0,FLY_HEIGHT];

        // Create
        private _droneSpawnInfo = [
            _spawnPosition, 
            _flyDirection, 
            DRONE_CLASS, 
            _droneGroup
        ] call BIS_fnc_spawnVehicle;

        private _drone = _droneSpawnInfo select 0;
        _drone flyInHeight FLY_HEIGHT;
        _drone setSkill 1;


        [_drone,_droneGroup,_spawnPosition] spawn BLWK_fnc_droneWave_attackLoop;


        private _hitEventId = _drone addEventHandler ["HIT", {
            params ["_drone", "", "", "_instigator"];

            if (isPlayer _instigator) then {
                private _points = [_drone] call BLWK_fnc_getPointsForKill;
                [_drone,_points] remoteExec ["BLWK_fnc_droneWave_onDroneKilled",_instigator];
            };

            private _explosion = "DemoCharge_Remote_Ammo_Scripted" createVehicle (getPosATLVisual _drone);
            _explosion setdamage 1;
            _drone setDamage 1;
        }];
        _drone setVariable ["BLWK_droneWave_droneHitEventId",_hitEventId];

        private _deletedEventId = _drone addEventHandler ["DELETED", {
            // deleted ai is not actually dead when deleted event runs
            // need to wait before checking for wave clear
            [
                {
                    if (call BLWK_fnc_waves_isCleared) then {
                        call BLWK_fnc_waves_end
                    };
                },
                [],
                0.5
            ] call CBAP_fnc_waitAndExecute;
        }]; 
        _drone setVariable ["BLWK_droneWave_droneDeletedEventId",_deletedEventId];

        private _killedEventId = _drone addEventHandler ["KILLED", {
            params ["_drone"];
            [
                ["BLWK_droneWave_droneHitEventId","HIT"],
                ["BLWK_droneWave_droneKilledEventId","KILLED"],
                ["BLWK_droneWave_droneDeletedEventId","DELETED"]
            ] apply {
                _x params ["_eventIdVarName","_eventType"];
                private _eventId = _drone getVariable [_eventIdVarName,-1];
                _drone removeEventHandler [_eventType,_eventId];
            };

            if (call BLWK_fnc_waves_isCleared) then {
                call BLWK_fnc_waves_end
            };
        }]; 
        _drone setVariable ["BLWK_droneWave_droneKilledEventId",_killedEventId];


        private _droneArray = [_drone];
        _droneArray call BLWK_fnc_addToMustKillList;
        BLWK_zeus addCuratorEditableObjects [_droneArray, true];
        
        // space out spawns so that you don't get spammed
        sleep DRONE_SPAWN_OFFSET;
    };

    localNamespace setVariable ["BLWK_droneWave_allDronesCreated",true];
};
nil

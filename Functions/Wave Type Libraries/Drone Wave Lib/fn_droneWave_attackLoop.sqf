/* ----------------------------------------------------------------------------
Function: BLWK_fnc_droneWave_attackLoop

Description:
    Handles the flying of drones and their attacking of targets.

Parameters:
    0: _drone : <OBJECT> - The drone that attacks
    1: _droneGroup : <GROUP> - The drone's group
    2: _spawnPosition : <PositionATL> - The position the drone spawned at

Returns:
    NOTHING

Examples:
    (begin example)
        [
            myDrone,
            group myDrone,
            [0,0,0]
        ] spawn BLWK_fnc_droneWave_attackLoop;
    (end)

Author(s):
    Hilltop(Willtop) & omNomios,
    Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_droneWave_attackLoop";

#define FIRE_DISTANCE_BUFFER 37
#define FLY_HEIGHT 10

if (!canSuspend) exitWith {
    ["Must be run in scheduled environment, exiting to scheduled",true] call KISKA_fnc_log;
    _this spawn BLWK_fnc_droneWave_attackLoop;
};

params [
    "_drone",
    "_droneGroup",
    "_spawnPosition"
];

private _distanceToFire = FLY_HEIGHT + FIRE_DISTANCE_BUFFER;
while {alive _drone} do {
    _drone move (position BLWK_mainCrate);

    // wait to be in position to fire
    waitUntil {
        if (
            !(alive _drone) OR
            {(_drone distance BLWK_mainCrate) <= _distanceToFire} OR 
            // sometimes units can just slightly out of the ideal 3d range
            {(_drone distance2D BLWK_mainCrate) <= 10} 
        ) exitWith {true};

        sleep 2;
        false
    };
    
    // do fire
    waitUntil {
        if (
            !(alive _drone) OR
            {_drone fireAtTarget [BLWK_mainCrate]}
        ) exitWith {true};
        
        sleep 2;
        false
    };

    // move back to spawn
    _drone move _spawnPosition;
    waitUntil {
        if  exitWith {true};
        if (
            !(alive _drone) OR
            {(_drone distance2d _spawnPosition) <= 10}
        ) exitWith {true};
        
        sleep 2;
        false
    };

};


nil

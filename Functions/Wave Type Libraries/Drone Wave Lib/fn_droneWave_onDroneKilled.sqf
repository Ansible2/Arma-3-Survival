/* ----------------------------------------------------------------------------
Function: BLWK_fnc_droneWave_onDroneKilled

Description:
    The on wave init for drone waves. Spawns the drones and adds them to the
     must kill list

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        [someDrone,200] remoteExec ["BLWK_fnc_droneWave_onDroneKilled",_instigator];
    (end)

Author(s):
    Hilltop(Willtop) & omNomios,
    Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_droneWave_onDroneKilled";

params ["_drone","_points"];

[_points] call BLWK_fnc_addPoints;
[_drone,_points,true] call BLWK_fnc_createHitMarker;


nil

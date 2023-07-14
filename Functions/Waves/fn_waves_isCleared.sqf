/* ----------------------------------------------------------------------------
Function: BLWK_fnc_waves_isCleared

Description:
    Checks if the wave can be considered over.

Parameters:
    NONE

Returns:
    <BOOL> - whether or not all the rquired enemies to kill are dead

Examples:
    (begin example)
        private _areEnemiesDead = call BLWK_fnc_waves_isCleared;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
if (!isServer) exitWith { false };

if ((call BLWK_fnc_spawnQueue_get) isNotEqualTo []) exitWith { false };

private _index = (call BLWK_fnc_getMustKillList) findIf { alive _x };
private _aUnitIsStillAlive = _index isNotEqualTo -1;
if (_aUnitIsStillAlive) exitWith { false };

// not all special wave drones spawn right away, so checking that they have 
// (and that they are therefore in the kill list)
// before checking if all enemies are dead
private _allDronesCreated = localNamespace getVariable ["BLWK_droneWave_allDronesCreated",true];
if (!_allDronesCreated) exitWith { false };

true


// TODO: 
// The delay between the headless client sending to the must kill array 
// and the server checking that BLWK_fnc_getMustKillList has alive units
// is too large of a delay because that kill list might not be updated

// Might be able to replace this with a total count that can be expected to have needed to
// die on the server and once it receives notice that the number it's expecting have
// perished, it will end the wave, though this might run into the same issue

// You can duplicate this error if you kill all spawned units at once.
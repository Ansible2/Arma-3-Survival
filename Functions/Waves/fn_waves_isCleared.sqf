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
private _allDronesCreated = missionNamespace getVariable ["BLWK_allDronesCreated",true];
if (!_allDronesCreated) exitWith { false };

true

/* ----------------------------------------------------------------------------
Function: BLWK_fnc_isWaveCleared

Description:
	Checks all the units in the global must kill list to see if any are still alive.

	Executed from "BLWK_fnc_startWave"

Parameters:
	NONE

Returns:
	<BOOL> - whether or not all the rquired enemies to kill are dead

Examples:
    (begin example)
		private _areEnemiesDead = call BLWK_fnc_isWaveCleared;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
if (!isServer) exitWith { false };

private _index = (call BLWK_fnc_getMustKillList) findIf { alive _x };
private _aUnitIsStillAlive = _index isNotEqualTo -1;
// not all special wave drones spawn right away, so checking that they have 
// (and that they are therefore in the kill list)
// before checking if all enemies are dead
private _allDronesCreated = missionNamespace getVariable ["BLWK_allDronesCreated",true];
if (_aUnitIsStillAlive OR (!_allDronesCreated)) then {
	false
} else {
	true
};
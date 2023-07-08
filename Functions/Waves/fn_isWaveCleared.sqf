/* ----------------------------------------------------------------------------
Function: BLWK_fnc_isWaveCleared

Description:
	Checks all the units in the global must kill array to see if any are still alive.

	Executed from "BLWK_fnc_startWave"

Parameters:
	NONE

Returns:
	BOOL

Examples:
    (begin example)

		_areEnemiesDead = call BLWK_fnc_isWaveCleared;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false};

private _index = (missionNamespace getVariable ["BLWK_mustKillList",[]]) findIf {alive _x};
private _allDronesCreated = missionNamespace getVariable ["BLWK_allDronesCreated",true];
if (_index != -1 OR {!_allDronesCreated}) then {
	false
} else {
	true
};
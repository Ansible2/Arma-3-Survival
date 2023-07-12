/* ----------------------------------------------------------------------------
Function: BLWK_fnc_waves_start

Description:
	Heals the player when they select the action on The Crate

Parameters:
	0: _clearDroppedItems <BOOL> - Will dropped items on the ground be deleted this round?

Returns:
	NOTHING

Examples:
    (begin example)
		[true] call BLWK_fnc_waves_start;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_waves_start";

if (!isServer) exitWith {};

params [
	["_clearDroppedItems",false]
];

call BLWK_fnc_clearMustKillList;

if (_clearDroppedItems) then {

	private _weaponHolders = BLWK_playAreaCenter nearObjects ["weaponHolder",250];
	_weaponHolders = _weaponHolders select {typeOf _x == "groundWeaponHolder" AND {!(_x in BLWK_lootHolders)}};

	if !(_weaponHolders isEqualTo []) then {
		_weaponHolders apply {
			deleteVehicle _x;
		};
		sleep 1;
	};

};


/* ----------------------------------------------------------------------------
	Update wave info
---------------------------------------------------------------------------- */
private _previousWaveNum = missionNamespace getVariable ["BLWK_currentWaveNumber",0];
missionNamespace setVariable ["BLWK_currentWaveNumber", _previousWaveNum + 1,true];
missionNamespace setVariable ["BLWK_inBetweenWaves",false,true];


/* ----------------------------------------------------------------------------
	Decide Wave Type/Handle Extraction
---------------------------------------------------------------------------- */
if (missionNamespace getVariable ["BLWK_extractionQueued",false]) then {
	call BLWK_fnc_extraction;

} else {
	private _waveConfig = call BLWK_fnc_getConfigForWave;
	[_waveConfig] call BLWK_fnc_waves_create;

	// loot is spawned before the wave starts at round 1
	if (BLWK_currentWaveNumber > BLWK_startingFromWaveNumber) then {
		// this will also clean up previous loot
		call BLWK_fnc_spawnLoot;
	};

};


call BLWK_fnc_cleanUpTheDead;


nil

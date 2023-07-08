/* ----------------------------------------------------------------------------
Function: BLWK_fnc_civiliansWave

Description:
	Creates the civilians during a special wave.
	
	It is executed from the "BLWK_fnc_spawnWaveEnemies".
	
Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_civiliansWave;

    (end)
Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

#define NUM_CIVILIANS 12
#define CIVILIAN_CLASS "C_man_1"
// CIPHER COMMENT: Consider adjusting the amount of ai for dedicated and hosted server
// CIPHER COMMENT: might be worth trying this with agents too
// CIPHER COMMENT: could just do an allunits select {side _x isEqualTo civilian} instead of deletion pile...
private _civilians = [];
for "_i" from 1 to NUM_CIVILIANS do {
	private _randomBuilding = selectRandom BLWK_playAreaBuildings;
	private _spawnPosition = selectRandom (_randomBuilding buildingPos -1);

	private _group = createGroup [civilian,true];
	private _unit = _group createUnit [CIVILIAN_CLASS, _spawnPosition, [], 0.5, "NONE"];

	// give them a random look
	[_unit] call BLWK_fnc_civRandomGear; 

	// if a player kills the civilian, remove points
	// CIPHER COMMENT: make sure you need MP event instead of local one
	_unit addEventHandler ["KILLED",{
		_this call BLWK_fnc_killedCivilianEvent;
	}];

	// create cycle waypoints for them
	[_group,BLWK_playAreaCenter,BLWK_playAreaRadius,3] call CBAP_fnc_taskPatrol;

	_unit allowFleeing 0;
    _unit setBehaviour "CARELESS";

	_civilians pushBack _unit;
};

// for deleteing cvilians at wave end
missionNamespace setVariable ["BLWK_civiliansFromWave",_civilians];

[BLWK_zeus,[_civilians, true]] remoteExecCall ["addCuratorEditableObjects",2];
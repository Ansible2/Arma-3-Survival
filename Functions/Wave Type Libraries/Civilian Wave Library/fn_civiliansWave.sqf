/* ----------------------------------------------------------------------------
Function: BLWK_fnc_civiliansWave

Description:
	Creates the civilians during a special wave.
	
	It is executed from the "".
	
Parameters:
	NONE

Returns:
	Nothing

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_civiliansWave;

    (end)
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

#define NUM_CIVILIANS 10
#define CIVILIAN_CLASS "C_man_1"
// CIPHER COMMENT: Consider adjusting this for dedicated and hosted server
// CIPHER COMMENT: could just do an allunits select {side _x isEqualTo civilian} instead of deletion pile...
private _civilians = [];
for "_i" from 1 to NUM_CIVILIANS do {
	private _randomBuilding = selectRandom BLWK_playAreaBuildings;
	private _spawnPosition = selectRandom (_randomBuilding buildingPos -1);

	private _group = createGroup [civilian,true]
	private _unit = _group createUnit [CIVILIAN_CLASS, _spawnPosition, [], 0.5, "NONE"];

	// give them a random look
	[_unit] call BLWK_fnc_civRandomGear; 

	// if a player kills the civilian, remove points
	_unit addMpEventHandler ["MPKILLED",{
		[_this,_thisEventhandler] call BLWK_fnc_killedCivllianEvent;
	}];

	// create cycle waypoints for them
	[_group,BLWK_playAreaCenter,BLWK_playAreaRadius,3] call CBAP_fnc_taskPatrol;

	_unit allowFleeing 0;
    _unit setBehaviour "CARELESS";

	_civilians pushBack _unit;
	
	sleep 0.5;
};

BLWK_zeus addCuratorEditableObjects [_civilians, true];
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
#define NUM_CIVILIANS 20

// CIPHER COMMENT: could just do an allunits select {side _x isEqualTo civilian} instead of deletion pile...
private _civilians = [];
for "_i" from 1 to NUM_CIVILIANS do {
	private _randomBuilding = selectRandom BLWK_playAreaBuildings;
	private _spawnPosition = selectRandom (_randomBuilding buildingPos -1);

	private _group = createGroup [civilian,true]
	private _unit = _group createUnit [BLWK_civilianClass, _spawnPosition, [], 0.5, "NONE"];

	// give them a random look
	[_unit] call BLWK_fnc_civRandomGear; 

	// CIPHER COMMENT: Should Multiplayer Event handlers be used?
	/// if using locals, this may not be fast enough to gen a message to the user with the hit
	/// plus, if it is always a server and you have a hosted one, it may be uneccessary strain
	/// I think there is a case to at least TRY local handlers and see their network performance
	
	// if a player kills the civilian, remove points
	_unit addEventHandler ["KILLED",{
		private _instigator = _this select 2;
		
		if (isPlayer _instigator) then {
			remoteExecCall ["BLWK_fnc_killedCivilian",_instigator];
		};
	}];

	// create cycle waypoints for them
	[_group,BLWK_playAreaCenter,BLWK_playAreaRadius,3] call CBAP_fnc_taskPatrol;

	_unit allowFleeing 0;
    _unit setBehaviour "CARELESS";

	_civilians pushBack _unit;
	
	sleep 0.5;
};

mainzeus addCuratorEditableObjects [[_civilians], true];
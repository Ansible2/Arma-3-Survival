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
// spawn civilians all in one loop so because everyone is going to get the same stuff
/// e.g. loadouts changed, waypoints added, eventhandlers added
// this 

BLWK_civilianClass

// CIPHER COMMENT: consider adding in a que or a limit to civilians/ai in general

for "_i" from 1 to NUM_CIVILIANS do {
	private "_spawnPosition";
	waitUntil {
		if ()
	}
	private _spawnPosition = selectRandom BLWK_playAreaBuildings;

	
};
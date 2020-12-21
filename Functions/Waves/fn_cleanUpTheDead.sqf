/* ----------------------------------------------------------------------------
Function: BLWK_fnc_cleanUpTheDead

Description:
	Cleans up dead bodies after the next wave begins.
	Also handles heaping the bodies into piles based upon the mission params
	 for how long the dead should last.

	Executed from "BLWK_fnc_startWave"

Parameters:
	NONE

Returns:
	BOOL

Examples:
    (begin example)

		call BLWK_fnc_cleanUpTheDead;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWIth {false};

private _allDeadMen = allDeadMen;

if (BLWK_roundsBeforeBodyDeletion isEqualTo 0) exitWith {
	_allDeadMen apply {
		if !(isNull _x) then {
			deleteVehicle _x;
		};
	};
};


if (BLWK_deadBodies_1 isEqualTo []) then {
	BLWK_deadBodies_1 = _allDeadMen;
} else {
	if (BLWK_roundsBeforeBodyDeletion isEqualTo 1) then {
		private _killed1WaveAgo = _allDeadMen select {!(isNull _x) AND {!(_x in BLWK_deadBodies_1)}};
		BLWK_deadBodies_1 apply {
			if !(isNull _x) then {
				deleteVehicle _x;
			};
		};

		BLWK_deadBodies_1 = _killed1WaveAgo;
	};
};


if (BLWK_roundsBeforeBodyDeletion isEqualTo 2) then {

	if (BLWK_deadBodies_2 isEqualTo []) then {
		// get all the guys who weren't already added to BLWK_deadBodies_1 the last wave
		private _killed1WaveAgo = _allDeadMen select {!(isNull _x) AND {!(_x in BLWK_deadBodies_1)}};
		BLWK_deadBodies_2 = BLWK_deadBodies_1;
		BLWK_deadBodies_1 = _killed1WaveAgo;
	} else {
		BLWK_deadBodies_2 apply {
			if !(isNull _x) then {
				deleteVehicle _x;
			};
		};
		BLWK_deadBodies_2 = [];
	};
};

true
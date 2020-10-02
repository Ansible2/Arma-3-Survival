if (!isServer) exitWIth {false};

private _allDeadMen = allDeadMen;

if (BLWK_roundsBeforeBodyDeletion isEqualTo 0) exitWith {
	_allDeadMen apply {
		deleteVehicle _x;
	};
};


private _killed1WaveAgo = BLWK_deadBodies select 0;
if (_killed1WaveAgo isEqualTo []) then {
	BLWK_deadBodies = [_allDeadMen,[]];
} else {
	if (BLWK_roundsBeforeBodyDeletion isEqualTo 1) then {
		_killed1WaveAgo apply {
			deleteVehicle _x;
		};
	};
};


if (BLWK_roundsBeforeBodyDeletion isEqualTo 2) then {
	private _killed2WavesAgo = BLWK_deadBodies select 1;
	if (_killed2WavesAgo isEqualTo []) then {
		BLWK_deadBodies = [_allDeadMen - _killed1WaveAgo,_killed1WaveAgo];
	} else {
		_killed2WavesAgo apply {
			deleteVehicle _x;
		};
		BLWK_deadBodies = [[],_killed1WaveAgo];
	};
};

true
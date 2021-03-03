/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addPoints

Description:
	Adds a specified number of points to the player

Parameters:
	0: _pointsToAdd : <NUMBER> - The amount to add

Returns:
	BOOL

Examples:
    (begin example)

		// add 10 points to player
		[10] call BLWK_fnc_addPoints;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {false};

params [
	["_pointsToAdd",0,[123]]
];

if (_pointsToAdd isEqualTo 0) exitWith {false};

private _killPoints = missionNamespace getVariable ["BLWK_playerKillPoints",0];
_killPoints = _killPoints + _pointsToAdd;
missionNamespace setVariable ["BLWK_playerKillPoints",_killPoints];


true
















/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addPoints

Description:
	Adds a specified number of points to the player.
	Points are first added to a que and then totaled into the player's points.
	
	This was due to things such as a Killed and Hit event firing simaltaneously
	 which causes both add events to not have the other in the new total it gives
	 to the player.

Parameters:
	0: _pointsToAdd : <NUMBER> - The amount to add

Returns:
	BOOL

Examples:
    (begin example)

		// add 10 points to player
		[10] call BLWK_fnc_addPoints;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher

if (!hasInterface) exitWith {false};

params [
	["_pointsToAdd",0,[123]]
];

if (_pointsToAdd isEqualTo 0) exitWith {false};

//
BLWK_killPointsQue pushBack _pointsToAdd;
[] spawn {

	private "_firstInQue";
	while {!(BLWK_killPointsQue isEqualTo [])} do {
		_firstInQue = BLWK_killPointsQue deleteAt 0;
		if (!isNil "_firstInQue") then {
			private _killPoints = missionNamespace getVariable ["BLWK_playerKillPoints",0];
			_killPoints = _killPoints + _firstInQue;
			missionNamespace setVariable ["BLWK_playerKillPoints",_killPoints];
		};
		sleep 0.1;
	};
};


true
---------------------------------------------------------------------------- */

/* ----------------------------------------------------------------------------
Function: BLWK_fnc_overrunBulwarkWave

Description:
	Heals the player when they select the action on The Crate.

	Executed from "BLWK_fnc_handleOverrunWave"

Parameters:
	0: _startingEnemyUnits : <ARRAY> - The array of units to teleport to The Crate

Returns:
	NOTHING

Examples:
    (begin example)

		[unitArray] call BLWK_fnc_overrunBulwarkWave;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_startingEnemyUnits"];

// make sure nobody is carrying anything when they teleport
null = remoteExecCall ["BLWK_fnc_placeObject",BLWK_allClientsTargetID];

private "_playerPosition";
private _players = call CBAP_fnc_players;
_players apply {
	// don't teleport players in vehicles
	if (isNull (objectParent _x)) then {
		_playerPosition = [BLWK_playAreaCenter, BLWK_playAreaRadius / 2, BLWK_playAreaRadius, 5] call BIS_fnc_findSafePos;
		_x setPos _playerPosition;
	};
};

private "_positionTemp";
_startingEnemyUnits apply {
	_positionTemp = [BLWK_mainCrate,50,random 360] call CBAP_fnc_randPos;
	[group _x,BLWK_mainCrate] call BLWK_fnc_stopStalking;
	_x setVehiclePosition [_positionTemp, [], 1, "NONE"];
};
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_overrunBulwarkWave

Description:
	Heals the player when they select the action on the bulwark.

	Executed from "BLWK_fnc_handleOverrunWave"

Parameters:
	0: _startingEnemyUnits : <ARRAY> - The array of units to teleport to the bulwark

Returns:
	NOTHING

Examples:
    (begin example)

		[unitArray] call BLWK_fnc_overrunBulwarkWave;

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_startingEnemyUnits"];

private "_playerPosition";
private _players = call CBAP_fnc_players;
_players apply {
	// don't teleport players in vehicles
	if (isNull (objectParent _x)) then {
		_playerPosition = [BLWK_playAreaCenter, 20, BLWK_playAreaRadius, 5] call BIS_fnc_findSafePos;
		//_playerPosition = [BLWK_playAreaCenter,BLWK_playAreaRadius,round (random 360)] call CBAP_fnc_randPos;
		_x setPos _playerPosition;
	};
};

private "_positionTemp";
_startingEnemyUnits apply {
	_positionTemp = [bulwarkBox,50,random 360] call CBAP_fnc_randPos;
	_x setVehiclePosition [_positionTemp, [], 1, "NONE"];
};
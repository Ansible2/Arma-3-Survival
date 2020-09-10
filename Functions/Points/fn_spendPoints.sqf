/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spendPoints

Description:
	Subtracts a specified number of the player's points

Parameters:
	0: _player : <OBJECT> - The unit to be subtracted from
	1: _pointsSpent : <NUMBER> - The amount to subtract

Returns:
	BOOL

Examples:
    (begin example)

		// remove 10 points from player
		[player,10] call BLWK_fnc_spendPoints;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */

if !(hasInterface) exitWith {false};

params [
	["_player",player,[objNull]],
	["_pointsSpent",0,[123]]
];

private _killPoints = missionNamespace getVariable ["BLWK_playerKillPoints",0];
_killPoints = _killPoints - _pointsSpent;
missionNamespace setVariable ["BLWK_playerKillPoints",_killPoints];

// CIPHER COMMENT: Why do you need to know the player here? Why scheduled?
null = [_player] spawn killPoints_fnc_updateHud;

true
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addPoints

Description:
	adds a specified number of points to the player

Parameters:
	0: _pointsToAdd : <NUMBER> - The amount to add

Returns:
	BOOL

Examples:
    (begin example)

		// add 10 points to player
		[10] call BLWK_fnc_addPoints;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {false};

params [
	["_pointsToAdd",0,[123]]
];

private _killPoints = missionNamespace getVariable ["BLWK_playerKillPoints",0];
_killPoints = _killPoints + _pointsSpent;
missionNamespace setVariable ["BLWK_playerKillPoints",_killPoints];

// CIPHER COMMENT: Why do you need to know the player here? Why scheduled?
null = [_player] spawn killPoints_fnc_updateHud;

true
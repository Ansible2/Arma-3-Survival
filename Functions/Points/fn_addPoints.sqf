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

Author:
	Hilltop & omNomios,
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
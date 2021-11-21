/* ----------------------------------------------------------------------------
Function: BLWK_fnc_healPlayer

Description:
	Heals the player when they select the action on The Crate

	Executed from the action added in "BLWK_fnc_prepareTheCratePlayer"

Parameters:
	0: _player : <OBJECT> - The person to heal

Returns:
	NOTHING

Examples:
    (begin example)

		[player] call BLWK_fnc_healPlayer;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_player",player,[objNull]]
];


if (damage _player isEqualTo 0 AND {!BLWK_ACELoaded}) exitWith {
	["You have no damage to heal"] call BLWK_fnc_notification;
};

private _killPoints = missionNamespace getVariable ["BLWK_playerKillPoints",0];

if (_killPoints < BLWK_pointsForHeal) exitWith {
	["You do not have enough points to heal"] call BLWK_fnc_notification;
};

_killPoints = _killPoints - BLWK_pointsForHeal;

missionNamespace setVariable ["BLWK_playerKillPoints",_killPoints];

_player setDamage 0;

if (BLWK_dontUseRevive AND {BLWK_ACELoaded}) then {
	[_player] call ace_medical_treatment_fnc_fullHealLocal;
};

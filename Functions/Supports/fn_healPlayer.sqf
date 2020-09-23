/* ----------------------------------------------------------------------------
Function: BLWK_fnc_healPlayer

Description:
	Heals the player when they select the action ont he bulwark

	Executed from ""

Parameters:
	0: _player : <OBJECT> - The person to heal

Returns:
	NOTHING

Examples:
    (begin example)

		[player] call BLWK_fnc_healPlayer;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_player",player,[objNull]]
];

private _killPoints = missionNamespace getVariable ["BLWK_playerKillPoints",0];

if (_killPoints < 500) exitWith {
	hint "You do not have enough points to heal";
};

_killPoints = _killPoints - 500;

missionNamespace setVariable ["BLWK_playerKillPoints",_killPoints];

_player setDamage 0;

if (BLWK_dontUseRevive AND {BLWK_isACELoaded}) then {
	[_player] call ace_medical_treatment_fnc_fullHealLocal;
};
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

if (BLWK_useACEMedical) then {
	[_player] call ace_medical_treatment_fnc_fullHealLocal;
};
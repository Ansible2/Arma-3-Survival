if (!hasInterface OR {BLWK_dontUseRevive}) exitWith {};

params [
	["_player",player]
];

// handle damage events fire even on dead bodies, we will remove it in the onPlayerKilled.sqf
BLWK_dammagedEventHandler = _player addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

	/*
		If the event returns 0, it means 0 damage will be dealt to the _unit
		The checks below are for:
			- is it friendly fire
			- is the player in an incapcitated state already
	*/
	if ((side _unit) isEqualTo (side _instigator) OR {!(incapacitatedState _player isEqualTo "")}) exitWith {0};


	// add medkit revive
	["BLWK_reviveOnStateVar",1,_player] call BIS_fnc_reviveOnState;
}];
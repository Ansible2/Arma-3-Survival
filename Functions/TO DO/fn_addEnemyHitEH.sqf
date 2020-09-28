if (!hasInterface) exitWith {false};

params ["_unit"];

private _eventID = _unit addEventHandler ["Hit", {
	_this call BLWK_fnc_enemyHitEvent;
}];

_unit setVariable ["BLWK_hitEH",["Hit",_eventID]];
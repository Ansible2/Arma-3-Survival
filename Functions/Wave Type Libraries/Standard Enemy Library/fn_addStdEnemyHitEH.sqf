if (!hasInterface) exitWith {false};

params ["_unit"];

private _eventID = _unit addEventHandler ["Hit", {
	_this call BLWK_fnc_stdEnemyHitEvent;
}];

_unit setVariable ["BLWK_stdHitEH_info",["Hit",_eventID]];


true
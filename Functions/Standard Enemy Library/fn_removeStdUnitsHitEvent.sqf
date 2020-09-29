if (!hasInterface) exitWith {false};

params ["_unit"];

private _handlerInfo = _unit getVariable ["BLWK_stdHitEH_info",[]];
if !(_handlerInfo isEqualTo []) then {
	_unit removeEventHandler _handlerInfo;
	true
} else {
	false
};
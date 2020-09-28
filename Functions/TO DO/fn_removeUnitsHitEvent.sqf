if (!hasInterface) exitWith {false};

params ["_unit"];

private _handler = _unit getVariable ["BLWK_hitEH_ID",[]];
if !(_handler isEqualTo []) then {
	_unit removeEventHandler _handler;
	true
} else {
	false
};
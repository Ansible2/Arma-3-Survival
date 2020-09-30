if (!hasInterface) exitWith {};

params ["_unit"];

if (_unit isEqualTo player) exitWith {};

_unit addAction [{}]
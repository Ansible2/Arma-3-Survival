if !(hasInterface) exitWith {};

params ["_object"];

if (isNull _object) exitWith {};

waitUntil {player isEqualTo player};

_object enableCollisionWith player;
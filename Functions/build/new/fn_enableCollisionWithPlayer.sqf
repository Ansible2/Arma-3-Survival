if !(hasInterface) exitWith {};

params ["_object"];

waitUntil {player isEqualTo player};

_object enableCollisionWith player;
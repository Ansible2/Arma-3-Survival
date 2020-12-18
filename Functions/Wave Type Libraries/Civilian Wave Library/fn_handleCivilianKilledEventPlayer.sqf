if !(hasInterface) exitWith {};

params ["_killedUnit"];

if (isNull _killedUnit) exitWith {};

[_killedUnit, round (BLWK_pointsForKill * -10), true] call BLWK_fnc_createHitMarker;
[BLWK_pointsForKill * 10] call BLWK_fnc_subtractPoints;

playSound "alarm";
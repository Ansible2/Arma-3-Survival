if !(hasInterface) exitWith {};

params ["_killedUnit"];

private _points = [_killedUnit] call BLWK_fnc_getPointsForKill;
		
// aircraft gunners get limited points
if (missionNamespace getVariable ["BLWK_isAircraftGunner",false]) then {
	_points = round (_points / 4);
};

[_points] call BLWK_fnc_addPoints;
[_killedUnit,_points,true] call BLWK_fnc_createHitMarker;
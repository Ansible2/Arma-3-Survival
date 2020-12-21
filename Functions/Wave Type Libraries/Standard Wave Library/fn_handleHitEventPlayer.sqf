if !(hasInterface) exitWith {};

params ["_hitUnit","_damage"];

if (isNull _hitUnit) exitWith {};

// aircraft gunners get limited points
if (missionNamespace getVariable ["BLWK_isAircraftGunner",false]) then {
	[1] call BLWK_fnc_addPoints;
	[_hitUnit,1] call BLWK_fnc_createHitMarker;
} else {
	// multiply by damage
	private _damagePoints = BLWK_pointsMultiForDamage * _damage;
	if (_damagePoints > BLWK_maxPointsForDamage) then {
		_damagePoints = BLWK_maxPointsForDamage;
	};
	
	private _points = round (BLWK_pointsForHit + _damagePoints);
	[_points] call BLWK_fnc_addPoints;
	[_hitUnit,_points] call BLWK_fnc_createHitMarker;
};
if (!hasInterface) exitWith {};

private _insitgator = _this select 3;

if (_instigator isEqualTo player) then {
	private _unit = _this select 0;
	
	private _points = BLWK_pointsForHit + (BLWK_pointsMultiForDamage * _damage);
	[_unit,_points] call BLWK_fnc_createHitMarker;
	[_points] call BLWK_fnc_addPoints;
};
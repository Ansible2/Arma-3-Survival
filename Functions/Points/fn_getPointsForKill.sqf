params ["_unit"];

// CIPHER COMMENT: it might be better to just cache the unit's multiplier in their namespace

if (isNull _unit) exitWith {BLWK_pointsForKill};

private _unitInfo = [_unit] call BIS_fnc_objectType;
private _category = _unitInfo select 0;
private _type = _unitInfo select 1;

private _unitClass =  typeOf _unit;
private _multiplier = 1;

if (_category == "soldier") then {
	if !((BLWK_level5_menClasses findIf {_x == _unitClass}) isEqualTo -1) exitWith {
		_multiplier = BLWK_pointMulti_men_level5
	};
	if !((BLWK_level4_menClasses findIf {_x == _unitClass}) isEqualTo -1) exitWith {
		_multiplier = BLWK_pointMulti_men_level4
	};
	if !((BLWK_level3_menClasses findIf {_x == _unitClass}) isEqualTo -1) exitWith {
		_multiplier = BLWK_pointMulti_men_level3
	};
	if !((BLWK_level2_menClasses findIf {_x == _unitClass}) isEqualTo -1) exitWith {
		_multiplier = BLWK_pointMulti_men_level2
	};
	if !((BLWK_level1_menClasses findIf {_x == _unitClass}) isEqualTo -1) exitWith {
		_multiplier = BLWK_pointMulti_men_level1
	};
};

if (_category == "car") then {
	_multiplier = BLWK_pointsMulti_car;
};

if (_category == "TrackedAPC" OR {_category == "Tank"} OR {_category == "WheeledAPC"}) then {
	_multiplier = BLWK_pointsMulti_armour;
};

_multiplier * BLWK_pointsForKill
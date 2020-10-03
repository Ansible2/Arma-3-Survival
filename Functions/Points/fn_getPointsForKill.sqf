/* ----------------------------------------------------------------------------
Function: BLWK_fnc_getPointsForKill

Description:
	Designed to return the appropriate amount of points for a kill based upon
	 the multipliers for a unit's level or type.

Parameters:
	0: _unit : <OBJECT> - The vehicle or unit killed

Returns:
	NUMBER - The amount the unit kill is worth

Examples:
    (begin example)

		_pointsToAdd = [killedUnits] call BLWK_fnc_getPointsForKill;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_unit"];

// CIPHER COMMENT: it might be better to just cache the unit's multiplier in their namespace

if (isNull _unit) exitWith {BLWK_pointsForKill};

private _unitInfo = [_unit] call BIS_fnc_objectType;
private _category = _unitInfo select 0;
private _type = _unitInfo select 1;

private _unitClass =  typeOf _unit;

if (_category == "soldier") exitWith {
	if !((BLWK_level5_menClasses findIf {_x == _unitClass}) isEqualTo -1) exitWith {
		BLWK_pointMulti_men_level5
	};
	if !((BLWK_level4_menClasses findIf {_x == _unitClass}) isEqualTo -1) exitWith {
		BLWK_pointMulti_men_level4
	};
	if !((BLWK_level3_menClasses findIf {_x == _unitClass}) isEqualTo -1) exitWith {
		BLWK_pointMulti_men_level3
	};
	if !((BLWK_level2_menClasses findIf {_x == _unitClass}) isEqualTo -1) exitWith {
		BLWK_pointMulti_men_level2
	};
	if !((BLWK_level1_menClasses findIf {_x == _unitClass}) isEqualTo -1) exitWith {
		BLWK_pointMulti_men_level1
	};
};

if (_type == "car") exitWith {
	BLWK_pointsMulti_car
};

if (_type == "TrackedAPC" OR {_category == "Tank"} OR {_category == "WheeledAPC"}) exitWith {
	BLWK_pointsMulti_armour
};

if (_type == "Helicopter") exitWith {
	BLWK_pointsMulti_car
};
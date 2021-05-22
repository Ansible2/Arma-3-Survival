/* ----------------------------------------------------------------------------
Function: BLWK_fnc_getPointsForKill

Description:
	Designed to return the appropriate amount of points for a kill based upon
	 the multipliers for a unit's level or type.

Parameters:
	0: _unit : <OBJECT> - The vehicle or unit killed

Returns:
	<NUMBER> - The amount the unit kill is worth

Examples:
    (begin example)

		_pointsToAdd = [killedUnits] call BLWK_fnc_getPointsForKill;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_getPointsForKill";

#define IF_IN_LIST_EXIT(gvar_list,multiplier) \
	if (_unitClass in gvar_list) exitWith { \
		round (BLWK_pointsForKill * multiplier); \
	};

params ["_unit"];

private _unitInfo = [_unit] call BIS_fnc_objectType;
private _category = _unitInfo select 0;

if (_category == "soldier") exitWith {
	private _unitClass = toLowerANSI (typeOf _unit);

	IF_IN_LIST_EXIT(BLWK_level5_menClasses,BLWK_pointsMulti_man_level5)
	IF_IN_LIST_EXIT(BLWK_level4_menClasses,BLWK_pointsMulti_man_level4)
	IF_IN_LIST_EXIT(BLWK_level3_menClasses,BLWK_pointsMulti_man_level3)
	IF_IN_LIST_EXIT(BLWK_level2_menClasses,BLWK_pointsMulti_man_level2)
	IF_IN_LIST_EXIT(BLWK_level1_menClasses,BLWK_pointsMulti_man_level1)
	IF_IN_LIST_EXIT(BLWK_friendly_menClasses,BLWK_pointsMulti_man_level5)
};


private _type = _unitInfo select 1;

if (_type == "car") exitWith {
	round (BLWK_pointsForKill * BLWK_pointsMulti_car)
};

if (_type == "TrackedAPC" OR {_category == "Tank"} OR {_category == "WheeledAPC"}) exitWith {
	round (BLWK_pointsForKill * BLWK_pointsMulti_armour)
};

if (_type == "Helicopter") exitWith {
	round (BLWK_pointsForKill * BLWK_pointsMulti_car)
};

// if nothing else, return default kill points
BLWK_pointsForKill

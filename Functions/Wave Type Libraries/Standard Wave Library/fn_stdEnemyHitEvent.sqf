/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stdEnemyHitEvent

Description:
	Executes the code in the standard enemy's hit event for adding points to player.

	Parameters are that of the normal HIT eventhandler.

	Executed from the event added by "BLWK_fnc_addStdEnemyManEHs"

Parameters:
	0: _unit : <OBJECT> - Object the event handler is assigned to
	1: _source : <OBJECT> - Object that caused the damage – contains unit in case of collisions (not used)
	2: _damage : <NUMBER> - Level of damage caused by the hit
	3: _instigator : <OBJECT> - Person who pulled the trigger

Returns:
	NOTHING

Examples:
    (begin example)

		_this call BLWK_fnc_stdEnemyHitEvent;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

private _instigator = _this select 3;

if (_instigator isEqualTo player) then {
	private _unit = _this select 0;
	
	// multiply by damage
	private _points = round (BLWK_pointsForHit + (BLWK_pointsMultiForDamage * (_this select 2)));
	[_points] call BLWK_fnc_addPoints;
	[_unit,_points] call BLWK_fnc_createHitMarker;
};
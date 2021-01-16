/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stdEnemyHitEventLocal

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

		_this call BLWK_fnc_stdEnemyHitEventLocal;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_hitUnit", "_source", "_damage", "_instigator"];

if (!(isNull _instigator) AND {isPlayer _instigator}) then {
	// show a player hit points and add them to there score
	[_hitUnit,_damage] remoteExecCall ["BLWK_fnc_handleHitEventPlayer",_instigator];
};
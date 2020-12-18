/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stdVehicleKilledEvent

Description:
	Executes the code in the standard enemy vehicles killed event
	 for adding points to players and markers.

	Executed from the event added by "BLWK_fnc_stdEnemyVehicles"

Parameters:
	0: _killedUnit : <OBJECT> - Object the event handler is assigned to
	1: _killer : <OBJECT> - Object that killed _killedUnit – contains unit itself in case of collisions (not used)
	2: _instigator : <OBJECT> - Person who pulled the trigger
	3: _useEffects : <BOOL> - same as useEffects in setDamage alt syntax (not used)
		

Returns:
	NOTHING

Examples:
    (begin example)

		_this call BLWK_fnc_stdVehicleKilledEvent;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_killedUnit", "_killer", "_instigator", "_useEffects"];

if (!(isNull _instigator) AND {isPlayer _instigator}) then {
	// show a player hit points and add them to there score
	[_killedUnit,true] remoteExecCall ["BLWK_fnc_handleKillEventPlayer",_instigator];
};
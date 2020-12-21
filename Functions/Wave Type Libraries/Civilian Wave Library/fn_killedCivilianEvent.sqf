/* ----------------------------------------------------------------------------
Function: BLWK_fnc_killedCivilianEvent

Description:
	Initiates a check to see if a civilian was killed by a player and sends
	 a dock of points to the player if found.

	Executed from the eventhandeler added in "BLWK_fnc_civiliansWave"

Parameters:
	0: _killedUnit : <OBJECT> - Object the event handler is assigned to
	1: _killer : <OBJECT> - Object that killed _killedUnit – contains unit itself in case of collisions (not used)
	2: _instigator : <OBJECT> - Person who pulled the trigger
	3: _useEffects : <BOOL> - same as useEffects in setDamage alt syntax (not used)

Returns:
	NOTHING

Examples:
    (begin example)

		[_this,_thisEventhandler] call BLWK_fnc_killedCivilianEvent;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_killedUnit", "_killer", "_instigator", "_useEffects"];

if (!(isNull _instigator) AND {isPlayer _instigator}) then {
	// show a player hit points and add them to there score
	[_killedUnit] remoteExecCall ["BLWK_fnc_handleCivilianKilledEventPlayer",_instigator];
};
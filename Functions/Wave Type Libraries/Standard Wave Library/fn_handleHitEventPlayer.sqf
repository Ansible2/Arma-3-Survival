/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stdEnemyHitEventPlayer

Description:
	Executes from an enemy's hit eventhandler. The message is sent from whomever
	 controls the AI to the instigator. 
	 
	This is what will add the points to a player and create a hit marker.

	Executed from the event added by "BLWK_fnc_stdEnemyHitEventLocal"

Parameters:
	0: _hitUnit : <OBJECT> - The unit hit
	1: _damage : <NUMBER> - The numerical damage done to a unit (for points/hit markers)

Returns:
	NOTHING

Examples:
    (begin example)
		// from hit event
		[_hitUnit,_damage] remoteExecCall ["BLWK_fnc_handleHitEventPlayer",_instigator];

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "BLWK_fnc_handleHitEventPlayer"
scriptName SCRIPT_NAME;

if !(hasInterface) exitWith {};

params ["_hitUnit","_damage"];

if (isNull _hitUnit) exitWith {
	["_hitUnit is null, exiting...",true] call KISKA_fnc_log;
};

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
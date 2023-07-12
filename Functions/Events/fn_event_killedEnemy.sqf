/* ----------------------------------------------------------------------------
Function: BLWK_fnc_event_killedEnemy

Description:
	Executes from an enemy's killed eventhandler. The message is sent from whomever
	 controls the AI to the instigator.

	This is what will add the points to a player and create a hit marker.

Parameters:
	0: _killedUnit : <OBJECT> - The unit killed
	1: _isVehicle : <BOOL> - True if anything other then a man unit (tank,car,etc.)

Returns:
	NOTHING

Examples:
    (begin example)
		// from hit event
		[_killedUnit] remoteExecCall ["BLWK_fnc_event_killedEnemy",_instigator];
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_event_killedEnemy";

if !(hasInterface) exitWith {};

params [
	["_killedUnit",objNull],
	["_isVehicle",false]
];

if (isNull _killedUnit) exitWith {
	["_killedUnit is null, exiting...",false] call KISKA_fnc_log;
	nil
};

private _points = [_killedUnit] call BLWK_fnc_getPointsForKill;

// aircraft gunners get limited points
if (
	(missionNamespace getVariable ["BLWK_isAircraftGunner",false]) AND 
	(!_isVehicle)
) then {
	_points = round (_points / 4);
};

[_points] call BLWK_fnc_addPoints;
[_killedUnit,_points,true] call BLWK_fnc_createHitMarker;


nil

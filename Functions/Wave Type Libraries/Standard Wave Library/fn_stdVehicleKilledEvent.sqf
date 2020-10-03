/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stdVehicleKilledEvent

Description:
	Executes the code in the standard enemy vehicles killed event
	 for adding points to players and markers.

	Executed from the event added by "BLWK_fnc_stdEnemyVehicles"

Parameters:
	0: _eventInfo: <ARRAY> -
		0: _unit : <OBJECT> - Object the event handler is assigned to
		1: _source : <OBJECT> - Object that caused the damage – contains unit in case of collisions (not used)
		2: _damage : <NUMBER> - Level of damage caused by the hit (not used)
		3: _insitgator : <OBJECT> - Person who pulled the trigger
	1: _handlerID : <NUMBER> - The eventhandler's id number

Returns:
	NOTHING

Examples:
    (begin example)

		[_this,_thisEventhandler] call BLWK_fnc_stdVehicleKilledEvent;

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_eventInfo","_handlerID"];

private _killedUnit = _eventInfo select 0;
private _instigator = _eventInfo select 3;


// points for players
if (local _instigator AND {isPlayer _instigator} AND {hasInterface}) then {
	private _points = [_killedUnit] call BLWK_fnc_getPointsForKill;
	[_killedUnit,_points] call BLWK_fnc_createHitMarker;
	[_points] call BLWK_fnc_addPoints;
};

// mp events need to be removed on the unit where they are local
if (local _killedUnit) then {
	removeMPEventHandler ["mpKilled",_handlerID];
};
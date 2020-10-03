/* ----------------------------------------------------------------------------
Function: BLWK_fnc_killedCivilianEvent

Description:
	Docks points from player when they kill a civilian

	Executed from the eventhandeler added in "BLWK_fnc_civiliansWave"

Parameters:
	0: _eventInfo : <ARRAY> - The default params passed through a MPKILLED event handler
	1: _handlerID : <NUMBER> - The event handler's ID to be used for removal

Returns:
	NOTHING

Examples:
    (begin example)

		[_this,_thisEventhandler] call BLWK_fnc_killedCivilianEvent;

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_eventInfo","_handlerID"];
private _killedUnit = _eventInfo select 0;
private _instigator = _eventInfo select 3;


if (local _instigator AND {isPlayer _instigator} AND {hasInterface}) then {
	
	[_killedUnit, round (BLWK_pointsForKill * -10), true] call BLWK_fnc_createHitMarker;
	[BLWK_pointsForKill * 10] call BLWK_fnc_subtractPoints;
	
	playSound "alarm";
};

// mp events need to be removed on the unit where they are local
if (local _killedUnit) then {
	_killedUnit removeMPEventHandler ["mpKilled",_handlerID];
};
#include "..\..\Headers\Stalker Global Strings.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stopStalking

Description:
	Stops a unit from stalking and readjusts the stalker counts for the unit
	 they were stalking.

Parameters:
	0: _stalkerGroup : <OBJECT> - The group that you want to stop being a stalker
	1: _defaultPosition : <OBJECT, GROUP, or ARRAY> - The position for the 
	 _stalkerGroup to travel to and patrol if (OPTIONAL)

Returns:
	BOOL

Examples:
    (begin example)
		[aStalkerGroup,positionToGoTo] call BLWK_fnc_stopStalking;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_stopStalking";

params [
	["_stalkerGroup",grpNull,[grpNull]],
	["_defaultPosition",[],[objNull,grpNull,[]]]
];


if (isNull _stalkerGroup) exitWith {
	["_stalkerGroup is null",true] call KISKA_fnc_log;

	false
};
if (isNil {_stalkerGroup getVariable DO_STALK_VAR}) exitWIth {
	["_stalkerGroup was not registered as a stalker",true] call KISKA_fnc_log;

	false
};
_stalkerGroup setVariable [DO_STALK_VAR,nil];


private _stalkerGroupUnits = units _stalkerGroup;
if (_stalkerGroupUnits isEqualTo []) exitWith {
	_stalkerGroup setVariable [STALKED_UNIT_VAR,nil];
	true
};

// update stalker count
private _stalkedUnit = _stalkerGroup getVariable STALKED_UNIT_VAR;
if (!isNull _stalkedUnit) then {
	private _numberOfStalkers = _stalkedUnit getVariable [STALKER_COUNT_VAR,0];
	_stalkerGroup setVariable [STALKED_UNIT_VAR,nil];
	
	private _stalkerNumber = _numberOfStalkers - (count _stalkerGroupUnits);
	if (_stalkerNumber < 0) then {_stalkerNumber = 0};
	
	_stalkedUnit setVariable [STALKER_COUNT_VAR,_stalkerNumber];
};

// remove events
private "_id_temp";
_stalkerGroupUnits apply {
	if !(isNull _x) then {
		_id_temp = _x getVariable UNIT_KILLED_EVENT_VAR;
		_x removeEventHandler ["KILLED",_id_temp];
	};
};

// move units to default position if defined
if (_defaultPosition isNotEqualTo []) then {
	[_stalkerGroup, _defaultPosition, 100, 3, "MOVE", "AWARE"] call CBAP_fnc_taskPatrol;
};


true
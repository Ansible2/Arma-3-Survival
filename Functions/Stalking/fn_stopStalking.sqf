#include "..\..\Headers\Stalker Global Strings.hpp"

params [
	["_stalkerGroup",grpNull,[grpNull]],
	["_defaultPosition",objNull,[objNull,grpNull,[]]]
];

if (isNull _stalkerGroup) exitWith {
	"BLWK_fnc_stopStalking _stalkerGroup isNull" call BIS_fnc_error;

	false
};
if (isNil {_stalkerGroup getVariable DO_STALK_VAR}) exitWIth {
	"BLWK_fnc_stopStalking _stalkerGroup was not stalking" call BIS_fnc_error;

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
_stalkerGroup setVariable [STALKED_UNIT_VAR,nil];
private _numberOfStalkers = _stalkedUnit getVariable STALKER_COUNT_VAR;
_stalkedUnit setVariable [STALKER_COUNT_VAR,_numberOfStalkers - (count _stalkerGroupUnits)];

// remove events
private "_id_temp";
_stalkerGroupUnits apply {
	_id_temp = _x getVariable UNIT_KILLED_EVENT_VAR;
	_x removeEventHandler ["KILLED",_id_temp];
};

// move units to default position if defined
if (!isNull _defaultPosition) then {
	[_stalkerGroup, _defaultPosition] call CBAP_fnc_taskPatrol;
	//[_stalkerGroup, _defaultPosition, 10, "MOVE", "AWARE", "RED"] call CBAP_fnc_addWaypoint;
};


true
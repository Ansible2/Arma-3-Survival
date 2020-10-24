#include "..\..\Headers\Stalker Global Strings.hpp"

if (!canSuspend) exitWith {
	"BLWK_fnc_stalkPlayer must be run in a scheduled environment" call BIS_fnc_error;
};

params [
	["_stalkerGroup",grpNull,[objNull,grpNull]],
	["_defaultPosition",bulwarkBox,[objNull,grpNull,[]]],
	["_checkRate",10,[123]],
	["_conditionToEndStalking",{false},[{}]]
];


// verify params
if (isNull _stalkerGroup) exitWith {
	"BLWK_fnc_stalkPlayer _stalkerGroup isNull" call BIS_fnc_error;
};
if (_stalkerGroup isEqualType objNull) then {
	_stalkerGroup = group _stalkerGroup;
};
if (_conditionToEndStalking isEqualTo {}) then {
	_conditionToEndStalking = {false};
};


// register stalkers
private _playerToStalk = call BLWK_fnc_getAPlayerToStalk;
if (isNull _playerToStalk) exitWith {
	[_stalkerGroup, _defaultPosition, 10, "MOVE", "AWARE", "RED"] call CBAP_fnc_addWaypoint;
};
[_playerToStalk,_stalkerGroup] call BLWK_fnc_registerStalkers;
_stalkerGroup setVariable [DO_STALK_VAR,true];
_stalkerGroup setVariable [STALKED_UNIT_VAR,_playerToStalk];


// update units stalker numbers
private _stalkerGroupUnits = units _stalkerGroup;
private "_id_temp";
_stalkerGroupUnits apply {
	_id_temp = _x addEventHandler ["KILLED",{
		if (isServer) then {
			hint "stalker count updated";
		};
	
		private _stalkedPlayer = (group _x) getVariable STALKED_UNIT_VAR;
		private _numberOfStalkers = _stalkedPlayer getVariable STALKER_COUNT_VAR;
		_numberOfStalkers = _numberOfStalkers - 1;
		_stalkedPlayer setVariable [STALKER_COUNT_VAR,_numberOfStalkers];
	}];

	// for removal with BLWK_fnc_stopStalking
	_x setVariable [UNIT_KILLED_EVENT_VAR,_id_temp];
};


// do the stalking
while { !isNull _stalkerGroup AND {_stalkerGroup getVariable DO_STALK_VAR} } do {
	
	[_stalkerGroup] call CBAP_fnc_clearWaypoints;
	[_stalkerGroup, _playerToStalk, 10, "MOVE", "AWARE", "RED"] call CBAP_fnc_addWaypoint;

	// check if there are any units left in the stalker group to do the stalking
	_stalkerGroupUnits = units _stalkerGroup;
	if (_stalkerGroupUnits isEqualTo [] OR {(_stalkerGroupUnits findIf {alive _x}) isEqualTo -1}) exitWith {
		[_stalkerGroup] call BLWK_fnc_stopStalking;
	};

	sleep _checkRate;

	// check if player is worth stalking and if not, get another player to stalk
	if !([_playerToStalk] call BWLK_fnc_canUnitBeStalked) then {
		_playerToStalk = call BLWK_fnc_getAPlayerToStalk;
	};

	// check if stalking should end or if nobody is available for stalking (BLWK_fnc_getAPlayerToStalk will return null object)
	if (([_stalkerGroup] call _conditionToEndStalking) OR {isNull _playerToStalk}) exitWith {
		[_stalkerGroup,_defaultPosition] call BLWK_fnc_stopStalking;
	};
};
#include "..\..\Headers\Stalker Global Strings.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_startStalkingPlayers

Description:
	Adds the number of a stalker group's units to the unit being stalked
	 total's so that they can be evenly spread across all units.

	Also adds a KILLED EH that automatically adjusts the player's stalker count.

Parameters:
	0: _stalkerGroup : <OBJECT> - The group that will be stalking
	1: _defaultPosition : <OBJECT, GROUP, or ARRAY> - The position to move to if no players
	2: _checkRate : <NUMBER> - How often to update the stalk position
	3: _conditionToEndStalking : <CODE> - Code that evaluates to a boolean, if met,
	 it will have the units move to the _defaultPosition

Returns:
	NOTHING

Examples:
    (begin example)
		[aStalkerGroup,BLWK_mainCrate,20,{false}] spawn BLWK_fnc_startStalkingPlayers;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_startStalkingPlayers";

if (!canSuspend) exitWith {
	["Must be run in a scheduled environment. Exiting to scheduled...",true] call KISKA_fnc_log;
	_this spawn BLWK_fnc_startStalkingPlayers;
};

params [
	["_stalkerGroup",grpNull,[objNull,grpNull]],
	["_defaultPosition",BLWK_mainCrate,[objNull,grpNull,[]]],
	["_checkRate",20,[123]],
	["_conditionToEndStalking",{false},[{}]]
];


// verify params
if (isNull _stalkerGroup) exitWith {
	["_stalkerGroup is null",true] call KISKA_fnc_log;
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
	sleep 0.5;
	[_stalkerGroup, _defaultPosition] remoteExecCall ["move", groupOwner _stalkerGroup];
};
[_playerToStalk,_stalkerGroup] call BLWK_fnc_registerStalkers;
_stalkerGroup setVariable [DO_STALK_VAR,true];
_stalkerGroup setVariable [STALKED_UNIT_VAR,_playerToStalk];


// update units stalker numbers
private _stalkerGroupUnits = units _stalkerGroup;
_stalkerGroupUnits apply {
	if !(isNull _x) then {
		private _killedEventId = _x addEventHandler ["KILLED",{
			params ["_unit"];

			private _group = group _unit;
			if !(isNull _group) then {
				private _stalkedPlayer = _group getVariable STALKED_UNIT_VAR;

				if !(isNull _stalkedPlayer) then {
					private _numberOfStalkers = _stalkedPlayer getVariable STALKER_COUNT_VAR;
					_numberOfStalkers = _numberOfStalkers - 1;
					_stalkedPlayer setVariable [STALKER_COUNT_VAR,_numberOfStalkers];
				};

			};
		}];

		// for removal with BLWK_fnc_stopStalking
		_x setVariable [UNIT_KILLED_EVENT_VAR, _killedEventId];
	};
};

// FOR PATH DEBUGGING
// addMissionEventHandler ["Draw3D", {
// 	_thisArgs params [
// 		["_stalkerGroup",grpNull,[grpNull]]
// 	];

// 	if (isNull _stalkerGroup OR !(_stalkerGroup getVariable ["BLWK_doStalkPlayers",false])) then {
// 		removeMissionEventHandler ["draw3d",_thisEventHandler];
// 	} else {
// 		if (missionNamespace getVariable ["BLWK_debug",false]) then {
// 			private _text = (_stalkerGroup getVariable ["BLWK_stalkerText",[""]]) joinString " | ";
// 			drawIcon3D ["", [1,0,0,1], ASLToAGL (getPosASLVisual (leader _stalkerGroup)), 0, 0, 0, _text, 1, 0.05, "PuristaMedium"];
// 		};
// 	};

// },[_stalkerGroup]];

// private _fn_add3dLog = {
// 	params ["_group","_text"];
// 	private _array = _group getVariable ["BLWK_stalkerText",[]];
// 	if (_array isEqualTo []) then {
// 		_group setVariable ["BLWK_stalkerText",_array];
// 	};

// 	if ((count _array) isEqualTo 5) then {
// 		_array deleteAt 0;
// 	};
// 	_array pushBack _text;
// };

[_stalkerGroup] call KISKA_fnc_clearWaypoints;
// [_stalkerGroup,"Cleared Initial Waypoints"] call _fn_add3dLog;

// do the stalking
[_stalkerGroup,"full"] remoteExec ["setSpeedMode",groupOwner _stalkerGroup];
while {!(isNull _stalkerGroup) AND (_stalkerGroup getVariable DO_STALK_VAR) } do {

	// check if there are any units left in the stalker group to do the stalking
	_stalkerGroupUnits = units _stalkerGroup;
	private _stalkerGroupIsEmpty = _stalkerGroupUnits isEqualTo [];
	private _allStalkerUnitsAreDead = { (_stalkerGroupUnits findIf {alive _x}) isEqualTo -1 };
	if (_stalkerGroupIsEmpty OR _allStalkerUnitsAreDead) then {
		[_stalkerGroup] call BLWK_fnc_stopStalking;
		break;
	};
	
	private _stalkerLeader = leader _stalkerGroup;
	if !(alive _stalkerLeader) then {break};


	private _stalkerGroupShouldUseMove = _stalkerLeader distance2D _playerToStalk < 50;
	private _stalkerGroupIsUnderMoveOrders = _stalkerGroup getVariable ["BLWK_isUnderMove",false];
	if (_stalkerGroupIsUnderMoveOrders AND (!_stalkerGroupShouldUseMove)) then {
		// [_stalkerGroup,"Used doStop"] call _fn_add3dLog;
		doStop _stalkerGroupUnits;
		sleep 1;
		_stalkerGroupUnits doFollow _stalkerLeader;
		// [_stalkerGroup,"Used doFollow"] call _fn_add3dLog;
	};

	private "_waypointCount";
	// [_stalkerGroup,"Waiting to clear waypoints"] call _fn_add3dLog;
	// Waypoints are not immediately deleted
	waitUntil {
		_waypointCount = count (waypoints _stalkerGroup);
		[
			_stalkerGroup,
			(_waypointCount - 1)
		] call KISKA_fnc_clearWaypoints;

		private _stalkerGroupWaypointsDeleted = _waypointCount < 2;
		if (_stalkerGroupWaypointsDeleted) exitWith {true};
		
		sleep 1;

		(units _stalkerGroup) isEqualTo []
	};
	// [_stalkerGroup,str ["Cleared waypoints: ",_waypointCount]] call _fn_add3dLog;

	// move allows units to go to a 3d position (inside a building)
	// therefore, when they are close to their target, start using "move" instead
	private _hasWaypoint = _waypointCount isEqualTo 1;
	if (_stalkerGroupShouldUseMove) then {
		// [_stalkerGroup,"Using Move"] call _fn_add3dLog;

		_stalkerGroup setVariable ["BLWK_isUnderMove",true];
		[_stalkerLeader,(getPosATL _playerToStalk)] remoteExecCall ["move", _stalkerLeader];

		if (_hasWaypoint) then {
			// [_stalkerGroup,"Deleted waypoint after move"] call _fn_add3dLog;
			deleteWaypoint [_stalkerGroup,0];
		};

	} else {
		// [_stalkerGroup,"Using waypoints"] call _fn_add3dLog;

		private _hasStalkerWaypoint = waypointName [_stalkerGroup,currentWaypoint _stalkerGroup] == "BLWK_stalkWaypoint";
		if (_hasWaypoint AND !_hasStalkerWaypoint) then {
			[_stalkerGroup] call KISKA_fnc_clearWaypoints;
			// [_stalkerGroup,"Deleted non stalker WPs"] call _fn_add3dLog;
		};

		_stalkerGroup setVariable ["BLWK_isUnderMove",false];
		
		if (_hasStalkerWaypoint) then {
			// [_stalkerGroup,"Moving stalker WP"] call _fn_add3dLog;
			
			private _waypoint = [_stalkerGroup,0];
			_waypoint setWaypointBehaviour "AWARE";
			_waypoint setWaypointPosition [getPos _playerToStalk,5];

		} else {
			// [_stalkerGroup,"Adding stalker WP"] call _fn_add3dLog;
			private _waypoint = [_stalkerGroup, _playerToStalk, 0, "MOVE", "AWARE", "FULL"] call CBAP_fnc_addWaypoint;
			_waypoint setWaypointName "BLWK_stalkWaypoint";
		};
		
	};
	
	sleep _checkRate;

	if !([_playerToStalk] call BLWK_fnc_canUnitBeStalked) then {
		_playerToStalk = call BLWK_fnc_getAPlayerToStalk;
	};

	if ((isNull _playerToStalk) OR {[_stalkerGroup] call _conditionToEndStalking}) then {
		[_stalkerGroup,_defaultPosition] call BLWK_fnc_stopStalking;
		break;
	};
};

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
private "_id_temp";
_stalkerGroupUnits apply {
	if !(isNull _x) then {
		_id_temp = _x addEventHandler ["KILLED",{
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
		_x setVariable [UNIT_KILLED_EVENT_VAR,_id_temp];
	};
};


// TODO: It seems very apparent that ACE is somewhat the culprit of AI not pathing correctly after spawning and about 1 wave in
// they jsut stop in their tracks at seemingly the first waypoint refresh




// do the stalking
[_stalkerGroup,"full"] remoteExec ["setSpeedMode",groupOwner _stalkerGroup];
while {!(isNull _stalkerGroup) AND (_stalkerGroup getVariable DO_STALK_VAR) } do {

	// check if there are any units left in the stalker group to do the stalking
	_stalkerGroupUnits = units _stalkerGroup;
	if (_stalkerGroupUnits isEqualTo [] OR {(_stalkerGroupUnits findIf {alive _x}) isEqualTo -1}) then {
		[_stalkerGroup] call BLWK_fnc_stopStalking;
		break;
	};
	
	private _stalkerLeader = leader _stalkerGroup;
	if !(alive _stalkerLeader) then {
		break;
	};

	[_stalkerGroup] call KISKA_fnc_clearWaypoints;
	// TODO: this under move handling may not be needed
	if (_stalkerGroup getVariable ["BLWK_isUnderMove",false]) then {
		doStop _stalkerGroupUnits;
		sleep 1;
		_stalkerGroupUnits doFollow _stalkerLeader;
	};

	waitUntil {
		sleep 1;
		if (count (waypoints _stalkerGroup) isEqualTo 0) exitWith {true};
		(units _stalkerGroup) isEqualTo []
	};

	// move allows units to go to a 3d position (inside a building)
	// therefore, when they are close to their target, start using "move" instead
	if (_stalkerLeader distance2D _playerToStalk < 50) then {
		_stalkerGroup setVariable ["BLWK_isUnderMove",true];
		[_stalkerLeader,(getPosATL _playerToStalk)] remoteExecCall ["move", _stalkerLeader];
	} else {
		_stalkerGroup setVariable ["BLWK_isUnderMove",false];
		[_stalkerGroup, _playerToStalk, 0, "MOVE", "AWARE", "FULL"] call CBAP_fnc_addWaypoint;

	};


	sleep _checkRate;

	// check if player is worth stalking and if not, get another player to stalk
	if !([_playerToStalk] call BLWK_fnc_canUnitBeStalked) then {
		_playerToStalk = call BLWK_fnc_getAPlayerToStalk;
	};

	// check if stalking should end or if nobody is available for stalking (BLWK_fnc_getAPlayerToStalk will return null object)
	if (isNull _playerToStalk OR {[_stalkerGroup] call _conditionToEndStalking}) then {
		[_stalkerGroup,_defaultPosition] call BLWK_fnc_stopStalking;
		break;
	};
};

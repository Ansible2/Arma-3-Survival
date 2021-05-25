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
	[_stalkerGroup, _defaultPosition, 10, "SAD", "AWARE", "RED"] call CBAP_fnc_addWaypoint;
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


// do the stalking
while {!(isNull _stalkerGroup) AND {_stalkerGroup getVariable DO_STALK_VAR} } do {
	
	[_stalkerGroup] call CBAP_fnc_clearWaypoints;
	[_stalkerGroup, _playerToStalk, 10, "MOVE", "AWARE", "RED"] call CBAP_fnc_addWaypoint;
	//_stalkerGroup move (getPosWorld _playerToStalk);

	// check if there are any units left in the stalker group to do the stalking
	_stalkerGroupUnits = units _stalkerGroup;
	if (_stalkerGroupUnits isEqualTo [] OR {(_stalkerGroupUnits findIf {alive _x}) isEqualTo -1}) exitWith {
		[_stalkerGroup] call BLWK_fnc_stopStalking;
	};

	sleep _checkRate;

	// check if player is worth stalking and if not, get another player to stalk
	if !([_playerToStalk] call BLWK_fnc_canUnitBeStalked) then {
		_playerToStalk = call BLWK_fnc_getAPlayerToStalk;
	};

	// check if stalking should end or if nobody is available for stalking (BLWK_fnc_getAPlayerToStalk will return null object)
	if (([_stalkerGroup] call _conditionToEndStalking) OR {isNull _playerToStalk}) exitWith {
		[_stalkerGroup,_defaultPosition] call BLWK_fnc_stopStalking;
	};
};
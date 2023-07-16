/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stalking_start

Description:
    Starts a group's stalking of players.

Parameters:
    0: _stalkerGroup : <GROUP> - The group that will be stalking

Returns:
    NOTHING

Examples:
    (begin example)
        [aStalkerGroup] call BLWK_fnc_stalking_start;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_stalking_start";

#define DEFAULT_POSITION (getPosATL BLWK_mainCrate)
#define UPDATE_RATE 20
#define SWITCH_TO_MOVE_DISTANCE 50


params [
    ["_stalkerGroup",grpNull,[grpNull]]
];


if (isNull _stalkerGroup) exitWith {
    ["_stalkerGroup is null",true] call KISKA_fnc_log;
    nil
};


// private _playerToStalk = call BLWK_fnc_stalking_getPlayer;
// if !(isNull _playerToStalk) then {
//     private _currentStalkingGroupCount = _playerToStalk getVariable ["BLWK_stalking_numberOfStalkerGroups",0];
//     _playerToStalk setVariable ["BLWK_stalking_numberOfStalkerGroups",_currentStalkingGroupCount + 1];
//     _stalkerGroup setVariable ["BLWK_stalking_stalkedPlayer",_playerToStalk];
// };

_stalkerGroup setVariable ["BLWK_stalking_doStalk",true];

/* ----------------------------------------------------------------------------
    Add Group Events
---------------------------------------------------------------------------- */
private _leaderChangedEventId = _stalkerGroup addEventHandler ["LeaderChanged", {
    params ["_group", "_newLeader"];

    if (_group getVariable ["BLWK_stalking_isUnderMove",false]) then {
        private _currentMovePosition = _stalkerGroup getVariable [
            "BLWK_stalking_currentMovePosition",
            DEFAULT_POSITION
        ];

        _newLeader move _currentMovePosition;
    };
}];
_stalkerGroup setVariable ["BLWK_stalking_leaderChangedEventId",_leaderChangedEventId];


private _deletedEventId = _stalkerGroup addEventHandler ["Deleted", {
    params ["_group"];
    _this call BLWK_fnc_stalking_stop;
}];
_stalkerGroup setVariable ["BLWK_stalking_deletedEventId",_deletedEventId];


private _emptyEventId = _stalkerGroup addEventHandler ["Empty", {
    params ["_group"];
    _this call BLWK_fnc_stalking_stop;
}];
_stalkerGroup setVariable ["BLWK_stalking_emptyEventId",_emptyEventId];


/* ----------------------------------------------------------------------------
    Main loop
---------------------------------------------------------------------------- */
[_stalkerGroup] call KISKA_fnc_clearWaypoints;

[_stalkerGroup] spawn {
    params ["_stalkerGroup"];
    
    while { !(isNull _stalkerGroup) AND (_stalkerGroup getVariable ["BLWK_stalking_doStalk",false]) } do {
        
        if !([_stalkerGroup] call KISKA_fnc_isGroupAlive) then {
            [_stalkerGroup] call BLWK_fnc_stalking_stop;
            break;
        };

        private _currentPlayerBeingStalked = _stalkerGroup getVariable ["BLWK_stalking_stalkedPlayer",objNull];
        /* --------------------------------------
            verify player to stalk
        -------------------------------------- */
        private _currentPlayerCanBeStalked = [_currentPlayerBeingStalked] call BLWK_fnc_stalking_canPlayerBeStalked;
        private _shouldRedistribute = _stalkerGroup getVariable ["BLWK_stalking_redistribute",false];
        if ((!_currentPlayerCanBeStalked) OR _shouldRedistribute) then {
            private _playerToStalk = call BLWK_fnc_stalking_getPlayer;
            if (isNull _playerToStalk) then {

                if !(_stalkerGroup setVariable ["BLWK_stalking_isPatrolling",false]) then {
                    _stalkerGroup setVariable ["BLWK_stalking_isPatrolling",true];
                    [_stalkerGroup] call KISKA_fnc_clearWaypoints;
                    [_stalkerGroup, DEFAULT_POSITION, 100, 3, "MOVE", "AWARE"] call CBAP_fnc_taskPatrol;
                };
                
                sleep UPDATE_RATE;

                continue;

            } else {
                [_stalkerGroup,_playerToStalk] call BLWK_fnc_stalking_setStalkedPlayer;
                _currentPlayerBeingStalked = _playerToStalk;

            };
        };
        

        /* --------------------------------------
            Reset group if needed from `move` command
        -------------------------------------- */
        private _stalkerGroupShouldUseMove = (
            (leader _stalkerGroup) distance2D _currentPlayerBeingStalked
        ) < SWITCH_TO_MOVE_DISTANCE;
        private _stalkerGroupIsUnderMoveOrders = _stalkerGroup getVariable ["BLWK_stalking_isUnderMove",false];
        if (_stalkerGroupIsUnderMoveOrders AND (!_stalkerGroupShouldUseMove)) then {
            private _stalkerGroupUnits = units _stalkerGroup;
            doStop _stalkerGroupUnits;
            sleep 1;
            // regroup units
            _stalkerGroupUnits doFollow _stalkerLeader;
        };


        /* --------------------------------------
            clear previous waypoints,
            Waypoints are not immediately deleted so need to wait
        -------------------------------------- */
        private "_waypointCount";
        waitUntil {
            _waypointCount = count (waypoints _stalkerGroup);
            [
                _stalkerGroup,
                (_waypointCount - 1)
            ] call KISKA_fnc_clearWaypoints;

            private _stalkerGroupWaypointsDeleted = _waypointCount < 2;
            if (_stalkerGroupWaypointsDeleted) exitWith {true};
            
            sleep 1;

            // prevent infinte loop
            (units _stalkerGroup) isEqualTo []
        };


        /* --------------------------------------
            Choose between waypoint or `move` command
        -------------------------------------- */
        private _hasWaypoint = _waypointCount isEqualTo 1;
        if (_stalkerGroupShouldUseMove) then {
            _stalkerGroup setVariable ["BLWK_stalking_isUnderMove",true];
            
            private _playerPosition = getPosATL _currentPlayerBeingStalked;
            _stalkerGroup setVariable ["BLWK_stalking_currentMovePosition",_playerPosition];

            (leader _stalkerGroup) move _playerPosition;
            if (_hasWaypoint) then {
                deleteWaypoint [_stalkerGroup,0];
            };

        } else {
            _stalkerGroup setVariable ["BLWK_stalking_isUnderMove",false];
            _stalkerGroup setVariable ["BLWK_stalking_currentMovePosition",nil];

            private _hasStalkerWaypoint = waypointName [
                _stalkerGroup,
                (currentWaypoint _stalkerGroup)
            ] == "BLWK_stalking_waypoint";

            private _hasWaypointThatIsNotStalkerWaypoint = _hasWaypoint AND (!_hasStalkerWaypoint);
            if (_hasWaypointThatIsNotStalkerWaypoint) then {
                [_stalkerGroup] call KISKA_fnc_clearWaypoints;
            };

            if (_hasStalkerWaypoint) then {
                private _waypoint = [_stalkerGroup,0];
                _waypoint setWaypointBehaviour "AWARE";
                _waypoint setWaypointPosition [getPos _currentPlayerBeingStalked,5];

            } else {
                private _waypoint = [
                    _stalkerGroup, 
                    _currentPlayerBeingStalked, 
                    0, 
                    "MOVE", 
                    "AWARE", 
                    "FULL"
                ] call CBAP_fnc_addWaypoint;
                _waypoint setWaypointName "BLWK_stalking_waypoint";
            };
        };

        _stalkerGroup setVariable ["BLWK_stalking_isPatrolling",false];

        sleep UPDATE_RATE;
    };
};


// TODO: be able to rebalance if a player respawns

nil

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

        (units _stalkerGroup) apply {
            _x move _currentMovePosition;
        };
    };
}];
_stalkerGroup setVariable ["BLWK_stalking_leaderChangedEventId",_leaderChangedEventId];


private _deletedEventId = _stalkerGroup addEventHandler ["Deleted", {
    _this call BLWK_fnc_stalking_stop;
}];
_stalkerGroup setVariable ["BLWK_stalking_deletedEventId",_deletedEventId];


private _emptyEventId = _stalkerGroup addEventHandler ["Empty", {
    _this call BLWK_fnc_stalking_stop;
}];
_stalkerGroup setVariable ["BLWK_stalking_emptyEventId",_emptyEventId];


// FOR PATH DEBUGGING
// addMissionEventHandler ["Draw3D", {
//     _thisArgs params [
//         ["_stalkerGroup",grpNull,[grpNull]]
//     ];

//     if (isNull _stalkerGroup OR !(_stalkerGroup getVariable ["BLWK_stalking_doStalk",false])) then {
//         removeMissionEventHandler ["draw3d",_thisEventHandler];
//     } else {
//         if (missionNamespace getVariable ["BLWK_debug",false]) then {
//             private _text = (_stalkerGroup getVariable ["BLWK_stalkerText",[""]]) joinString " | ";
//             drawIcon3D ["", [1,0,0,1], ASLToAGL (getPosASLVisual (leader _stalkerGroup)), 0, 0, 0, _text, 1, 0.05, "PuristaMedium"];
//         };
//     };

// },[_stalkerGroup]];


/* ----------------------------------------------------------------------------
    Main loop
---------------------------------------------------------------------------- */
[_stalkerGroup] call KISKA_fnc_clearWaypoints;

[_stalkerGroup] spawn {
    params ["_stalkerGroup"];

    // FOR PATH DEBUGGING
    // private _fn_add3dLog = {
    //     params ["_group","_text"];
    //     private _array = _group getVariable ["BLWK_stalkerText",[]];
    //     private _id = _group getVariable ["BLWK_stalkerIteration",0];
    //     if (_array isEqualTo []) then {
    //         _group setVariable ["BLWK_stalkerText",_array];
    //     };

    //     if ((count _array) isEqualTo 5) then {
    //         _array deleteAt 0;
    //     };
    //     _array pushBack ([_text,_id] joinString " - ");
    //     _group setVariable ["BLWK_stalkerIteration",_id + 1];
    // };

    
    while { !(isNull _stalkerGroup) AND (_stalkerGroup getVariable ["BLWK_stalking_doStalk",false]) } do {

        if !([_stalkerGroup] call KISKA_fnc_isGroupAlive) then {
            [_stalkerGroup] call BLWK_fnc_stalking_stop;
            break;
        };

        if (
            (leader _stalkerGroup) getVariable [
                "BLWK_isACEUnconscious",
                false
            ]
        ) then { 
            sleep 3;
            continue 
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
                
                private _groupIsPatrolling = _stalkerGroup getVariable ["BLWK_stalking_isPatrolling",false];
                // [_stalkerGroup,["NULL player to stalk: ",_groupIsPatrolling] joinString ""] call _fn_add3dLog;
                if !(_groupIsPatrolling) then {
                    _stalkerGroup setVariable ["BLWK_stalking_isPatrolling",true];
                    [_stalkerGroup] call KISKA_fnc_clearWaypoints;
                    [_stalkerGroup, DEFAULT_POSITION, 100, 3, "MOVE", "AWARE"] call CBAP_fnc_taskPatrol;
                    // [_stalkerGroup,"told to patrol"] call _fn_add3dLog;
                };
                
                sleep UPDATE_RATE;

                continue;

            } else {
                [_stalkerGroup,_playerToStalk] call BLWK_fnc_stalking_setStalkedPlayer;
                _currentPlayerBeingStalked = _playerToStalk;
                // [_stalkerGroup,"set new stalked player"] call _fn_add3dLog;

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
            _stalkerGroupUnits doFollow (leader _stalkerGroup);
            // [_stalkerGroup,"told to stop and then follow"] call _fn_add3dLog;
        };


        /* --------------------------------------
            clear previous waypoints,
            Waypoints are not immediately deleted so need to wait
        -------------------------------------- */
        private "_waypointCount";
        // tODO: maybe a problem???
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
        // [_stalkerGroup,"cleared waypoints"] call _fn_add3dLog;


        /* --------------------------------------
            Choose between waypoint or `move` command
        -------------------------------------- */
        private _hasWaypoint = _waypointCount isEqualTo 1;
        if (_stalkerGroupShouldUseMove) then {
            _stalkerGroup setVariable ["BLWK_stalking_isUnderMove",true];
            
            private _playerPosition = getPosATL _currentPlayerBeingStalked;
            _stalkerGroup setVariable ["BLWK_stalking_currentMovePosition",_playerPosition];
            
            // `move` does not work well against group, using it at a unit level
            (units _stalkerGroup) apply {
                _x move _playerPosition;
            };
            _stalkerGroup setFormation "COLUMN";

            // [_stalkerGroup,["told to move ",_playerPosition] joinString ""] call _fn_add3dLog;
            if (_hasWaypoint) then {
                deleteWaypoint [_stalkerGroup,0];
                // [_stalkerGroup,"deleted waypoint"] call _fn_add3dLog;
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
                // [_stalkerGroup,"cleared WPs because excess"] call _fn_add3dLog;
            };

            if (_hasStalkerWaypoint) then {
                private _waypoint = [_stalkerGroup,0];
                _waypoint setWaypointBehaviour "AWARE";
                _waypoint setWaypointPosition [getPos _currentPlayerBeingStalked,5];
                // [_stalkerGroup,"updated stalker WP"] call _fn_add3dLog;

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
                // [_stalkerGroup,"Added new WP"] call _fn_add3dLog;
            };
        };

        _stalkerGroup setFormation "STAG COLUMN";
        _stalkerGroup setVariable ["BLWK_stalking_isPatrolling",false];

        sleep UPDATE_RATE;
    };
};


nil

// TODO: units do not patrol when there is nobody to stalk, 
// they just sit still after spawn or move to the main crate

// user 3d log and aircraft gunner support to see what orders they are given
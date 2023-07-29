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
// using random spread to help get a more evenly distributed work load
// for every group that is stalking, rather then them all needing to execute at about
// the same time
#define UPDATE_RATE (random [15,20,25])
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


    _stalkerGroup setBehaviourStrong "AWARE";
    _stalkerGroup setCombatMode  "RED";
   
    while { 
        !(isNull _stalkerGroup) AND 
        (_stalkerGroup getVariable ["BLWK_stalking_doStalk",false]) 
    } do {

        if !([_stalkerGroup] call KISKA_fnc_isGroupAlive) then {
            [_stalkerGroup] call BLWK_fnc_stalking_stop;
            break;
        };


        private _leaderIsIncapacitated = (leader _stalkerGroup) getVariable [
            "BLWK_isACEUnconscious",
            false
        ];
        if (_leaderIsIncapacitated) then { 
            sleep 3;
            continue 
        };


        /* --------------------------------------
            verify player to stalk
        -------------------------------------- */
        private _currentPlayerBeingStalked = _stalkerGroup getVariable ["BLWK_stalking_stalkedPlayer",objNull];
        private _currentPlayerCanBeStalked = [_currentPlayerBeingStalked] call BLWK_fnc_stalking_canPlayerBeStalked;
        private _shouldRedistribute = _stalkerGroup getVariable ["BLWK_stalking_redistribute",false];

        if ((!_currentPlayerCanBeStalked) OR _shouldRedistribute) then {
            
            private _newPlayerToStalk = call BLWK_fnc_stalking_getPlayer;
            if (isNull _newPlayerToStalk) then {

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
                [_stalkerGroup,_newPlayerToStalk] call BLWK_fnc_stalking_setStalkedPlayer;
                _currentPlayerBeingStalked = _newPlayerToStalk;
                // [_stalkerGroup,"set new stalked player"] call _fn_add3dLog;

            };

        };
        

        /* --------------------------------------
            Determine move type
        -------------------------------------- */
        private _stalkerGroupIsUnderMoveOrders = _stalkerGroup getVariable ["BLWK_stalking_isUnderMove",false];
        private _stalkerGroupShouldUseMove = (
            (leader _stalkerGroup) distance2D _currentPlayerBeingStalked
        ) < SWITCH_TO_MOVE_DISTANCE;

        if (_stalkerGroupShouldUseMove) then {

            if (!_stalkerGroupIsUnderMoveOrders) then {
                _stalkerGroup setVariable ["BLWK_stalking_isUnderMove",true];
                [_stalkerGroup,-1,false] call KISKA_fnc_clearWaypoints;
            };

            if ((formation _stalkerGroup) != "COLUMN") then {
                _stalkerGroup setFormation "COLUMN";
            };

             private _playerPosition = getPosATL _currentPlayerBeingStalked;
            _stalkerGroup setVariable ["BLWK_stalking_currentMovePosition",_playerPosition];

            // // `move` does not work well against group, using it at a unit level
            // (units _stalkerGroup) apply {
            //     _x move _playerPosition;
            // };
            _stalkerGroup move _playerPosition;
            [_stalkerGroup,["told to move ",_playerPosition] joinString ""] call _fn_add3dLog;

        } else {

            if (_stalkerGroupIsUnderMoveOrders) then {
                // regroup units
                private _stalkerGroupUnits = units _stalkerGroup;
                doStop _stalkerGroupUnits;
                // [_stalkerGroup,"doStop group units - during WP add"] call _fn_add3dLog;
                
                sleep 1;

                _stalkerGroupUnits doFollow (leader _stalkerGroup);
                // [_stalkerGroup,"doFollow group units - during WP add"] call _fn_add3dLog;

            } else {
                [_stalkerGroup,-1,true] call KISKA_fnc_clearWaypoints;
                // [_stalkerGroup,"cleared waypoints - during WP add"] call _fn_add3dLog;

            };

            private _waypoint = [
                _stalkerGroup, 
                player, 
                0, 
                "SAD", 
                "AWARE",
                "RED",
                "FULL"
            ] call CBAP_fnc_addWaypoint;
            // [_stalkerGroup,"added WP"] call _fn_add3dLog;

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
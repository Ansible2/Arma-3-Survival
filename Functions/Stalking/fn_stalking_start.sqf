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
};

private _playerToStalk = call BLWK_fnc_stalking_getPlayer;
if (isNull _playerToStalk) exitWith {
    (leader _stalkerGroup) move DEFAULT_POSITION;
};


private _currentStalkerCount = _playerToStalk getVariable ["BLWK_stalking_numberOfStalkers",0];
_playerToStalk setVariable ["BLWK_stalking_numberOfStalkers",_currentStalkerCount + (count (units _stalkerGroup))];
_stalkerGroup setVariable ["BLWK_stalking_doStalk",true];
_stalkerGroup setVariable ["BLWK_stalking_stalkedPlayer",_playerToStalk];

private _stalkerGroupUnits = units _stalkerGroup;
_stalkerGroupUnits apply {
    private _eventId = _x addEventHandler ["KILLED", {
        params ["_unit"];

        private _group = group _unit;
        private _stalkedPlayer = _group getVariable [
            "BLWK_stalking_stalkedPlayer",
            objNull
        ];

        if !(isNull _stalkedPlayer) then {
            private _numberOfStalkers = _stalkedPlayer getVariable [
                "BLWK_stalking_numberOfStalkers",
                0
            ];

            _numberOfStalkers = _numberOfStalkers - 1;
            _stalkedPlayer setVariable [
                "BLWK_stalking_numberOfStalkers",
                _numberOfStalkers max 0
            ];
        };
    }];

    _x setVariable ["BLWK_stalking_killedEventId", _eventId];
};


[_stalkerGroup] call KISKA_fnc_clearWaypoints;

[_stalkerGroup] spawn {
    params ["_stalkerGroup"];
    
    while { !(isNull _stalkerGroup) AND (_stalkerGroup getVariable ["BLWK_stalking_doStalk",false]) } do {
        if !([_stalkerGroup] call KISKA_fnc_isGroupAlive) then {
            [_stalkerGroup] call BLWK_fnc_stalking_stop;
            break;
        };

        private _playerToStalk = _stalkerGroup getVariable ["BLWK_stalking_stalkedPlayer",objNull];
        if !(isNull _playerToStalk) then {
            /* --------------------------------------
                Reset group if needed
            -------------------------------------- */
            _stalkerGroupUnits = units _stalkerGroup;
            private _stalkerGroupShouldUseMove = ((leader _stalkerGroup) distance2D _playerToStalk) < SWITCH_TO_MOVE_DISTANCE;
            private _stalkerGroupIsUnderMoveOrders = _stalkerGroup getVariable ["BLWK_stalking_isUnderMove",false];
            if (_stalkerGroupIsUnderMoveOrders AND (!_stalkerGroupShouldUseMove)) then {
                doStop _stalkerGroupUnits;
                sleep 1;
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

                (units _stalkerGroup) isEqualTo []
            };


            /* --------------------------------------
                Choose between waypoint or `move` command
            -------------------------------------- */
            private _hasWaypoint = _waypointCount isEqualTo 1;
            if (_stalkerGroupShouldUseMove) then {
                _stalkerGroup setVariable ["BLWK_stalking_isUnderMove",true];
                (leader _stalkerGroup) move (getPosATL _playerToStalk);

                if (_hasWaypoint) then {
                    deleteWaypoint [_stalkerGroup,0];
                };

            } else {
                _stalkerGroup setVariable ["BLWK_stalking_isUnderMove",false];

                private _hasStalkerWaypoint = waypointName [
                    _stalkerGroup,
                    (currentWaypoint _stalkerGroup)
                ] == "BLWK_stalking_waypoint";

                if (_hasWaypoint AND (!_hasStalkerWaypoint)) then {
                    [_stalkerGroup] call KISKA_fnc_clearWaypoints;
                };

                if (_hasStalkerWaypoint) then {
                    private _waypoint = [_stalkerGroup,0];
                    _waypoint setWaypointBehaviour "AWARE";
                    _waypoint setWaypointPosition [getPos _playerToStalk,5];

                } else {
                    private _waypoint = [
                        _stalkerGroup, 
                        _playerToStalk, 
                        0, 
                        "MOVE", 
                        "AWARE", 
                        "FULL"
                    ] call CBAP_fnc_addWaypoint;
                    _waypoint setWaypointName "BLWK_stalking_waypoint";
                };

            };
        };

        sleep UPDATE_RATE;

        /* --------------------------------------
            stop temporarily if not units to stalk
        -------------------------------------- */
        if !([_playerToStalk] call BLWK_fnc_stalking_canPlayerBeStalked) then {
            _playerToStalk = call BLWK_fnc_stalking_getPlayer;
        };

        if ((isNull _playerToStalk)) then {
            [_stalkerGroup] call KISKA_fnc_clearWaypoints;
            (leader _stalkerGroup) move DEFAULT_POSITION;
            break;
        };
    };
};


// TODO: be able to rebalance if a player respawns

nil

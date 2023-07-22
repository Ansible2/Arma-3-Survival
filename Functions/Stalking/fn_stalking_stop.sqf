/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stalking_stop

Description:
    Stops a unit from stalking and readjusts the stalker counts for the unit
     they were stalking.

Parameters:
    0: _stalkerGroup : <GROUP> - The group that should stop stalking

Returns:
    NOTHING

Examples:
    (begin example)
        [aStalkerGroup] call BLWK_fnc_stalking_stop;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_stalking_stop";

params [
    ["_stalkerGroup",grpNull,[grpNull]]
];


if (isNull _stalkerGroup) exitWith {
    ["_stalkerGroup is null",true] call KISKA_fnc_log;
    nil
};

/* ----------------------------------------------------------------------------
    Clear misc variables
---------------------------------------------------------------------------- */
_stalkerGroup setVariable ["BLWK_stalking_doStalk",nil];
_stalkerGroup setVariable ["BLWK_stalking_currentMovePosition",nil];
_stalkerGroup setVariable ["BLWK_stalking_isUnderMove",nil];
_stalkerGroup setVariable ["BLWK_stalking_redistribute",nil];
_stalkerGroup setVariable ["BLWK_stalking_isPatrolling",nil];


private _hasStalkerWaypoint = waypointName [
    _stalkerGroup,
    (currentWaypoint _stalkerGroup)
] == "BLWK_stalking_waypoint";
if (_hasStalkerWaypoint) then {
    [_stalkerGroup] call KISKA_fnc_clearWaypoints;
}; 


[_stalkerGroup] call BLWK_fnc_stalking_removeStalkedPlayer;


/* ----------------------------------------------------------------------------
    Group events
---------------------------------------------------------------------------- */
// removing eventhandlers too quickly from within another eventhandler
// can sometimes cause undefined behaviour
[
    {
        params ["_stalkerGroup"];

        [
            ["BLWK_stalking_leaderChangedEventId","LeaderChanged"],
            ["BLWK_stalking_deletedEventId","Deleted"],
            ["BLWK_stalking_emptyEventId","Empty"]
        ] apply {
            _x params ["_eventSaveId","_eventName"];

            private _eventId = _stalkerGroup getVariable [
                _eventSaveId,
                -1
            ];
            _stalkerGroup removeEventHandler [_eventName,_eventId];
        };
    },
    [_stalkerGroup],
    0.5
] call CBAP_fnc_waitAndExecute;



nil

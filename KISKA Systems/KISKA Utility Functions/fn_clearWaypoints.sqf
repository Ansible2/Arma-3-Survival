/* ----------------------------------------------------------------------------
Function: KISKA_fnc_clearWaypoints

Description:
    Clears a group's waypoints and conditionally halts their previous movement.

Parameters:
    0: _group <GROUP or OBJECT> - The group to clear the waypoints of.
    1: _numberToRemove <NUMBER> - The number of waypoints to remove (-1 will remove all)
    2: _stopUnits <BOOL> - Should the units stop in place after clear?

Returns:
    NOTHING

Example:
    (begin example)
        [group player,-1,false] call KISKA_fnc_clearWaypoints
    (end)

Author(s):
    SilentSpike,
    Modified By: Ansible2
---------------------------------------------------------------------------- */
params [
    ["_group", grpNull, [grpNull, objNull]],
    ["_numberToRemove",-1,[123]],
    ["_stopUnits", false, [true]]
];

if (_group isEqualType objNull) then {
    _group = group _group;
};

private _numberOfCurrentWaypoints = count (waypoints _group);
if (_numberOfCurrentWaypoints isEqualTo 0) exitWith {};

if (_numberToRemove isEqualTo -1) then {
    _numberToRemove = _numberOfCurrentWaypoints;
};

for "_i" from (_numberToRemove - 1) to 0 step -1 do {
    deleteWaypoint [_group, _i];
};

private _removedAllWaypoints = _numberToRemove isEqualTo _numberOfCurrentWaypoints;
if (!_stopUnits OR !_removedAllWaypoints) exitWith {};



if ((units _group) isNotEqualTo []) then {
    // Create a self-deleting waypoint at the leader position to halt all planned movement (based on old waypoints)
    private _wp = _group addWaypoint [getPosASL (leader _group), -1];
    _wp setWaypointStatements ["true", "deleteWaypoint [group this, currentWaypoint (group this)]"];
};


nil
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_clearWaypoints

Description:
    Clears a group's waypoints and conditionally halts their previous movement.

Parameters:
    0: _group <GROUP or OBJECT> - The group to clear the waypoints of.
    1: _stopUnits <BOOL> - Should the units stop in place after clear?

Returns:
    NOTHING

Example:
    (begin example)
        [group player,false] call KISKA_fnc_clearWaypoints
    (end)

Author(s):
    SilentSpike,
	Modified By: Ansible2
---------------------------------------------------------------------------- */
params [
	["_group", grpNull, [grpNull, objNull]],
	["_stopUnits", false, [true]]
];

if (_group isEqualType objNull) then {
	_group = group _group;
};

private _waypoints = waypoints _group;
_waypoints apply {
    // Waypoint index changes with each deletion, so don't delete _x
    deleteWaypoint [_group, 0];
};

if (!_stopUnits) exitWith {};


if ((units _group) isNotEqualTo []) then {
    // Create a self-deleting waypoint at the leader position to halt all planned movement (based on old waypoints)
    private _wp = _group addWaypoint [getPosASL (leader _group), -1];
    _wp setWaypointStatements ["true", "deleteWaypoint [group this, currentWaypoint (group this)]"];
};


nil
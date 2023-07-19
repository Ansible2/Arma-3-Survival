/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_addManEventhandlers

Description:
    Adds the `HIT`, `KILLED`, and `DELETED` eventhandlers that govern how units
     spawn from the queue and provide points to players.

Parameters:
    0: _unit : <OBJECT> - The unit to add the eventhandlers to

Returns:
    NOTHING

Examples:
    (begin example)
        [myUnit] call BLWK_fnc_spawnQueue_addManEventhandlers;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_addManEventhandlers";

params [
    ["_unit",objNull,[objNull]]
];

if (isNull _unit) exitWith {
    ["Null unit passed!"] call KISKA_fnc_log;
    nil
};


private _hitEventId = _unit addEventHandler ["Hit", {
    params ["_unit", "", "_damage", "_instigator"];
    if (isPlayer _instigator) then {
        [_unit,_damage] remoteExecCall ["BLWK_fnc_event_hitEnemy",_instigator];
    };
}];
_unit setVariable ["BLWK_spawnQueue_hitEventId",_hitEventId];


private _killedEventId = _unit addEventHandler ["Killed", {
    params ["_killedUnit", "", "_instigator"];
    if (!(isNull _instigator) AND (isPlayer _instigator)) then {
        // show a player hit points and add them to there score
        [_killedUnit] remoteExecCall ["BLWK_fnc_event_killedEnemy",_instigator];
    };

    [_killedUnit] call BLWK_fnc_spawnQueue_removeManEventhandlers;
    if !(isNull _killedUnit) then {
        private _cleanUpGroup = localNamespace getVariable ["BLWK_spawnQueue_cleanUpGroup",grpNull];
        if (isNull _cleanUpGroup) then {
            call BLWK_fnc_spawnQueue_initGroups;
        };

        private _previousGroup = group _killedUnit;
        [_killedUnit] join _cleanUpGroup;

        if !([_previousGroup] call KISKA_fnc_isGroupAlive) then {
            deleteGroup _previousGroup;
        };
    };

    [] remoteExecCall ["BLWK_fnc_spawnQueue_unitKilled",2];
}];
_unit setVariable ["BLWK_spawnQueue_killedEventId",_killedEventId];


private _deletedEventId = _unit addEventHandler ["Deleted", {
    params ["_deletedUnit"];

    // units do not have groups at the time of the deleted event handler
    private _spawnQueueGroup = _deletedUnit getVariable ["BLWK_spawnQueue_group",grpNull];
    // game will crash if group is deleted too quickly
    [_spawnQueueGroup] spawn {
        params ["_spawnQueueGroup"];
        sleep 1;
        if !([_spawnQueueGroup] call KISKA_fnc_isGroupAlive) then {
            deleteGroup _spawnQueueGroup;
        };
    };

    [] remoteExecCall ["BLWK_fnc_spawnQueue_unitKilled",2];
}];
_unit setVariable ["BLWK_spawnQueue_deletedEventId",_deletedEventId];


nil

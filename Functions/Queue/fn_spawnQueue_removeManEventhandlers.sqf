/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_removeManEventhandlers

Description:
    Removes the `HIT`, `KILLED`, and `DELETED` eventhandlers that govern how units
     spawn from the queue and provide points to players.

Parameters:
    0: _unit : <OBJECT> - The unit to remove the eventhandlers from

Returns:
    NOTHING

Examples:
    (begin example)
        [myUnit] call BLWK_fnc_spawnQueue_removeManEventhandlers;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_removeManEventhandlers";

params [
    ["_unit",objNull,[objNull]]
];


private _deletedEventId = _unit getVariable ["BLWK_spawnQueue_deletedEventId",-1];
_unit removeEventHandler ["DELETED",_deletedEventId];

private _killedEventId = _unit getVariable ["BLWK_spawnQueue_killedEventId",-1];
_unit removeEventHandler ["KILLED",_killedEventId];

private _hitEventId = _unit getVariable ["BLWK_spawnQueue_hitEventId",-1];
_unit removeEventHandler ["HIT",_hitEventId];


nil

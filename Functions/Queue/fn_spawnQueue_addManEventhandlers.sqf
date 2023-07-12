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


_unit addEventHandler ["Hit", {
    params ["_unit", "", "_damage", "_instigator"];
    [_unit,_damage] remoteExec ["BLWK_fnc_event_hitEnemy",_instigator];
}];

_unit addEventHandler ["Killed", {
    params ["_killedUnit", "", "_instigator"];
    if (!(isNull _instigator) AND (isPlayer _instigator)) then {
        // show a player hit points and add them to there score
        [_killedUnit] remoteExec ["BLWK_fnc_event_killedEnemy",_instigator];
    };

    [] remoteExec ["BLWK_fnc_spawnQueue_unitKilled",2];
}];

_unit addEventHandler ["Deleted", {
    [] remoteExec ["BLWK_fnc_spawnQueue_unitKilled",2];
}];


nil

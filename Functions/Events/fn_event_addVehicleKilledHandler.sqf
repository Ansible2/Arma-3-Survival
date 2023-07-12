/* ----------------------------------------------------------------------------
Function: BLWK_fnc_event_addVehicleKilledHandler

Description:
    Adds a killed event a vehicle that will provide points to a player when it
     is killed.

Parameters:
    0: _vehicle : <OBJECT> - The vehicle to add the event to

Returns:
    <NUMBER> - The killed event ID

Examples:
    (begin example)
        [myVehicle] call BLWK_fnc_event_addVehicleKilledHandler;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_event_addVehicleKilledHandler";

params [
    ["_vehicle",objNull,[objNull]]
];

if (isNull _vehicle) exitWith {
    ["Null vehicle passed",true] call KISKA_fnc_log;
    -1
};

_vehicle addEventHandler ["KILLED", {
    params ["_killedUnit", "", "_instigator"];

    if (!(isNull _instigator) AND (isPlayer _instigator)) then {
        // show a player hit points and add them to there score
        [_killedUnit,true] remoteExecCall ["BLWK_fnc_event_killedEnemy",_instigator];
    };
}];

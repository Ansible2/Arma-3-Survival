/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_add

Description:
    Adds the given args to the enemy spawn queue.

Parameters:
    0: _class : <STRING> - The classname of the unit you want to add to the queue
    1: _position : <PositionATL[] OR OBJECT> - The position to spawn the unit at
    2: _onManCreatedFunctionName : <STRING> - The global var name for the function
        to run once the unit is created on the AI handler owner machine.
    2: _onGroupCreatedFunctionName : <STRING> - The global var name for the function
        to run once all the units in a this unit's group have been created

Returns:
    NOTHING

Examples:
    (begin example)
        [
            "I_Soldier_A_F",
            [0,0,0],
            "BLWK_fnc_standardWave_onManCreated",
            "BLWK_fnc_standardWave_onGroupCreated"
        ] call BLWK_fnc_spawnQueue_add;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_add";

if (!isServer) exitWith {};

params [
    ["_class","",[""]],
    ["_position",[],[objNull,[]]],
    ["_onManCreatedFunctionName","BLWK_fnc_standardWave_onManCreated",[""]],
    ["_onGroupCreatedFunctionName","BLWK_fnc_standardWave_onGroupCreated",[""]]
];


private _queue = call BLWK_fnc_spawnQueue_get;
_queue pushBack _this;

private _currentRequiredKillCount = localNamespace getVariable ["BLWK_spawnQueue_requiredKillCount",0];
localNamespace setVariable ["BLWK_spawnQueue_requiredKillCount",_currentRequiredKillCount + 1];


nil

/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_add

Description:
    Adds the given args to the enemy spawn queue.

Parameters:
    0: _class : <STRING> - The classname of the unit you want to add to the queue
    1: _position : <PositionATL[] OR OBJECT> - The position to spawn the unit at
    2: _onManCreatedFunctionName : <STRING> - The global var name for the function
        to run once the unit is created on the AI handler owner machine.

Returns:
    NOTHING

Examples:
    (begin example)
        [
            "I_Soldier_A_F",
            [0,0,0],
            "BLWK_fnc_standardWave_onManCreated"
        ] call BLWK_fnc_spawnQueue_add;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_add";

params [
    ["_class","",[""]],
    ["_position",[],[objNull,[]]],
    ["_onManCreatedFunctionName","BLWK_fnc_standardWave_onManCreated",[""]]
];


private _queue = call BLWK_fnc_spawnQueue_get;
_queue pushBack _this;


nil

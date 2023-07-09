/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_create

Description:
    Creates a unit for the wave based upon the args provided.

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
            missionConfigFile >> "BLWK_waveTypes" >> "normalWaves" >> "standardWave"
        ] call BLWK_fnc_spawnQueue_create;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_create";

params [
    ["_class","",[""]],
    ["_position",[],[objNull,[]]]
    ["_onManCreatedFunctionName","BLWK_fnc_standardWave_onManCreated",[""]],
];


// TODO: create man and add him to the mustkill array on the server

nil

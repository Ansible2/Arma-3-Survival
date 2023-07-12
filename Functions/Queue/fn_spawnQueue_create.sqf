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
            "I_Soldier_A_F",
            [0,0,0],
            "BLWK_fnc_standardWave_onManCreated"
        ] call BLWK_fnc_spawnQueue_create;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_create";

params [
    ["_class","",[""]],
    ["_position",[],[objNull,[]]],
    ["_onManCreatedFunctionName","BLWK_fnc_standardWave_onManCreated",[""]]
];

private _group = createGroup OPFOR;
private _unit = _group createUnit [_class, _position, [], 0, "NONE"];
// even creating a unit for the group with createUnit does not always have them
// in that group 
[_unit] joinSilent _group;
_group deleteGroupWhenEmpty true;

[_unit] call BLWK_fnc_setSkill;

// keep items (maps, nvgs, binoculars, etc.) so that they can just be loot drops
removeAllAssignedItems _unit;
// for pistol only waves and randomized weapons
[_unit] call BLWK_fnc_handleEnemyWeapons;

if !(BLWK_autocombatEnabled) then {
	_unit disableAI "AUTOCOMBAT";
};
if !(BLWK_suppressionEnabled) then {
	_unit disableAI "SUPPRESSION";
};
if !(BLWK_doDetectMines) then {
	_unit disableAI "MINEDETECTION";
};


[_unit] call BLWK_fnc_spawnQueue_addManEventhandlers;

/* ----------------------------------------------------------------------------
    Update server
---------------------------------------------------------------------------- */
[_unit] remoteExecCall ["BLWK_fnc_addToMustKillList",2];
[BLWK_zeus, [[_unit],false]] remoteExecCall ["addCuratorEditableObjects",2];


[_unit] call (missionNamespace getVariable [_onManCreatedFunctionName,{}]);


nil

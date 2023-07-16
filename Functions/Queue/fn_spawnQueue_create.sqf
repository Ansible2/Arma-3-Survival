/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_create

Description:
    Creates a group of units for the wave based upon the args provided.

Parameters:
    0: _unitCreationArgList : <ARRAY<[STRING,(PositionATL[] | OBJECT), STRING, STRING]>> An array of units
        to create. The first unit's spawn position will be used and they will be the leader
        of a single group for the units in the list.
        
        Each Array Element:
        - 0: _class : <STRING> - The classname of the unit you want to add to the queue
        - 1: _position : <PositionATL[] OR OBJECT> - The position to spawn the unit at
        - 2: _onManCreatedFunctionName : <STRING> - The global var name for the function
            to run once the unit is created on the AI handler owner machine.
        - 3: _onManCreatedFunctionName : <STRING> - The global var name for the function
            to run once the unit is created on the AI handler owner machine.

Returns:
    NOTHING

Examples:
    (begin example)
        // create a group of a single unit
        [
            [
                "I_Soldier_A_F",
                [0,0,0],
                "BLWK_fnc_standardWave_onManCreated",
                "BLWK_fnc_standardWave_onGroupCreated"
            ]
        ] call BLWK_fnc_spawnQueue_create;
    (end)
    (begin example)
        // create a group of a two units
        [
            [
                "I_Soldier_A_F",
                [0,0,0],
                "BLWK_fnc_standardWave_onManCreated",
                "BLWK_fnc_standardWave_onGroupCreated"
            ],
            [
                "I_Soldier_A_F",
                [0,0,0],
                "BLWK_fnc_standardWave_onManCreated",
                "BLWK_fnc_standardWave_onGroupCreated"
            ]
        ] call BLWK_fnc_spawnQueue_create;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_create";

params [
    ["_unitCreationArgList",[],[[]]]
];


if (_unitCreationArgList isEqualTo []) exitWith {};


private _group = call BLWK_fnc_spawnQueue_getAvailableGroup;
private _firstArgSet = _unitCreationArgList select 0;
_firstArgSet params ["","_spawnPosition","","_onGroupCreatedFunctionName"];
private _createdUnits = _unitCreationArgList apply {
    _x params [
        ["_class","",[""]],
        "",
        ["_onManCreatedFunctionName","BLWK_fnc_standardWave_onManCreated",[""]]
    ];

    private _unit = _group createUnit [_class, _spawnPosition, [], 5, "NONE"];

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
    [_unit] call (missionNamespace getVariable [_onManCreatedFunctionName,{}]);

    _unit
};

// even creating a unit for the group with createUnit does not always have them
// in that group 
_createdUnits joinSilent _group;
/* ----------------------------------------------------------------------------
    Update server
---------------------------------------------------------------------------- */
[_createdUnits] remoteExecCall ["BLWK_fnc_addToMustKillList",2];
[BLWK_zeus, [_createdUnits,false]] remoteExecCall ["addCuratorEditableObjects",2];

[_group] call (missionNamespace getVariable [_onGroupCreatedFunctionName,{}]);


nil

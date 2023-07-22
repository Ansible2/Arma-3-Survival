/* ----------------------------------------------------------------------------
Function: BLWK_fnc_suicideWave_makeBombers

Description:
    Takes a list of units and turns them into suicide bombers.

Parameters:
    0: _bombers : <OBJECT[]> - The suicide bombers to outfit

Returns:
    NOTHING

Examples:
    (begin example)
        [
            [unit1,unit2]
        ] remoteExecCall ["BLWK_fnc_suicideWave_makeBombers",BLWK_theAIHandlerOwnerId];
    (end)

Author(s):
    Hilltop(Willtop) & omNomios,
    Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_suicideWave_makeBombers";

#define VEST_CHARGE "DemoCharge_Remote_Ammo"

if !(local BLWK_theAIHandlerEntity) exitWith {
    [
        [
            "BLWK_fnc_spawnQueue_initGroups was called on machine where clientOwner is: ",
            clientOwner,
            " but BLWK_theAIHandlerEntity is not local"
        ]
    ] remoteExecCall ["KISKA_fnc_log",2];

    nil
};


params [
    ["_bombers",[],[[]]]
];

_bombers apply {
    private _unit = _x;
    private _unitGroup = createGroup [OPFOR,true];
    [_unit] joinSilent _unitGroup;
    _unit setVariable ["BLWK_spawnQueue_group",_bomberGroup];

    _unitGroup setBehaviour "CARELESS";
    
    private _owner = groupOwner _unitGroup;
    _unitGroup move (getPosATL BLWK_mainCrate);
    _unitGroup setSpeedMode "full";

    removeAllWeapons _unit;
    removeHeadgear _unit;
    removeVest _unit;
    _unit addVest "V_HarnessOGL_brn";
    _unit addHeadgear "H_ShemagOpen_khk";

    private _unitPosition = position _unit;
    private _bombs = [
        [
            [-0.1, 0.1, 0.15],
            [ [0.5, 0.5, 0], [-0.5, 0.5, 0] ]
        ],
        [
            [0.1, 0.1, 0.15],
            [ [0.5, -0.5, 0], [0.5, 0.5, 0] ]
        ],
        [
            [0, 0.15, 0.15],
            [ [1, 0, 0], [0, 1, 0] ]
        ]
    ] apply {
        _x params ["_attachmentPoint","_vectorDirAndUp"];

        private _explosive = VEST_CHARGE createVehicle _unitPosition;
        _explosive attachTo [_unit, _attachmentPoint, "Pelvis"];
        _explosive setVectorDirAndUp _vectorDirAndUp;

        _explosive
    };
    _unit setVariable ["BLWK_suicideBombs",_bombs];


    _unit addEventHandler ["KILLED",{
        hint "BOMBER - KILLED";
        params ["_bomber"];
        [_bomber] call BLWK_fnc_suicideWave_explodeBomber;
    }];

    _unit addEventHandler ["Deleted", {
        hint "BOMBER - DELETED";
        params ["_unit"];

        (_unit getVariable ["BLWK_suicideBombs",[]]) apply {
            deleteVehicle _x;
        };
    }];


    [_unit] spawn BLWK_fnc_suicideWave_bomberLoop;
};


nil

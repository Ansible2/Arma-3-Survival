/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pathing_collisionLoop

Description:
    Used to keep the AI from attempting to walk through a placed object.

    Units on roads sometimes follow predetermined paths that can have them walk
     through objects a user places down.

Parameters:
    0: _unit : <OBJECT> - The unit to run the loop on

Returns:
    NOTHING

Examples:
    (begin example)
        [myUnit] spawn BLWK_fnc_pathing_collisionLoop;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_pathing_collisionLoop";

if (!BLWK_doDetectCollision) exitWith {
    ["BLWK_doDetectCollision is set to be false, exiting...",false] call KISKA_fnc_log;
};

if (!canSuspend) exitWith {
    ["Needs to be run in scheduled, exting to run in scheduled",true] call KISKA_fnc_log;
    _this spawn BLWK_fnc_pathing_collisionLoop;
};


params [
    ["_unit",objNull,[objNull]]
];


sleep 5;

if (isNull _unit) exitWith {};


while {BLWK_doDetectCollision AND (alive _unit)} do {
    sleep 0.2;

    // don't run while a unit is in a vehicle
    private _unitIsInVehicle = !(isNull (objectParent _unit));
    if (_unitIsInVehicle) then { continue };


    private _objects = lineIntersectsObjs [
        (getposASL _unit),
        AGLToASL (_unit getRelPos [1,0]), 
        objNull, 
        _unit, 
        false, 
        4
    ];
    private _notNearAnyObjects = _objects isEqualTo [];
    if (_notNearAnyObjects) then { continue };


    // check if any encountered object is a built one
    private _index = _objects findIf {_x getVariable ["BLWK_collisionObject",false]};
    private _notNearBuiltObject = _index == -1;
    if (_notNearBuiltObject) then { continue };


    private _collisionObject = _objects select _index;
    private _moveToPosition = (_unit getRelPos [20,180]);
    // push the unit back from the object
    _unit setPosATL (_unit getRelPos [2,180]);

    private _previousCombatBehaviour = combatBehaviour _unit;
    private _previousCombatMode = unitCombatMode _unit;
    _unit setUnitCombatMode "BLUE";
    _unit setCombatBehaviour "SAFE";
    _unit disableAI "TARGET";
    _unit disableAI "AUTOTARGET";

    waitUntil {
        if (
            !(alive _unit) OR
            {
                (_unit distance2D _collisionObject) >= 10
            }
        ) exitWith {true};
        
        // tell the unit to move away
        [_unit,_moveToPosition] remoteExec ["move", _unit];
        
        sleep 1;
        
        false
    };

    // return unit state
    if (alive _unit) then {
        _unit setUnitCombatMode _previousCombatMode;
        _unit setCombatBehaviour _previousCombatBehaviour;
        _unit enableAI "TARGET";
        _unit enableAI "AUTOTARGET";
    };
};

/* ----------------------------------------------------------------------------
Function: KISKA_fnc_staticLine

Description:
    Ejects units from vehicle and deploys chutes, will select CUP T10 chute if available.

    CAUTION:
        All units from a group THAT ARE IN THE SAME AIRCRAFT should be dropped
        with the same function call. Not doing so can see odd behaviour from the aircraft.

        This is tied to KISKA_fnc_staticLine_eject and the use of the leaveVehicle
        command. If there are units from the same group still in the aircraft when it is
        executed, the aircraft will ignore all commands and attempt to pickup those units
        that were dropped.

Parameters:
    0: _aircraft <OBJECT> - The aircraft to drop units from
    1: _dropArray <ARRAY, GROUP, OBJECT> - Units to drop. If array, can be groups and/or objects (example 2)
    2: _invincibleOnDrop <BOOL> - Should the units be invincible while dropping?

Returns:
    NOTHING

Examples:
    (begin example)
        [plane,group] spawn KISKA_fnc_staticLine;
    (end)

    (begin example)
        [plane,[group1,unit2]] spawn KISKA_fnc_staticLine;
    (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_staticLine";

if !(canSuspend) exitWith {
    ["Should be run in scheduled. Exiting to scheduled...",true] call KISKA_fnc_log;
    _this spawn KISKA_fnc_staticLine;
};

params [
    ["_aircraft",objNull,[objNull]],
    ["_dropArray",[],[[],grpNull,objNull]],
    ["_invincibleOnDrop",true,[true]]
];

if (isNull _aircraft OR !(alive _aircraft)) exitWith {
    ["_aircraft is null or not alive. Exiting...",true] call KISKA_fnc_log;
    nil
};

if (_dropArray isEqualTo []) exitWith {
    ["_dropArray is empty",true] call KISKA_fnc_log;
    nil
};

if (_dropArray isEqualTypeAny [objNull,grpNull] AND {isNull _dropArray}) exitWith {
    ["_dropArray isNull",true] call KISKA_fnc_log;
    nil
};

if (_dropArray isEqualType grpNull) then {
    _dropArray = units _dropArray;
};

if (_dropArray isEqualType objNull) then {
    _dropArray = [_dropArray];
};

private _dropArrayFiltered = [];
_dropArray apply {
    if (_x isEqualType grpNull) then {
        (units _x) apply {
            if (_x in _aircraft) then  {
                _dropArrayFiltered pushBack _x;
            };
        };
    };

    if (!(_x isEqualType objNull) OR !(_x in _aircraft)) then { continue };

    _dropArrayFiltered pushBack _x;
};


private _chuteType = ["B_Parachute","CUP_T10_Parachute_backpack"] select (isClass (configfile >> "CfgVehicles" >> "CUP_T10_Parachute_backpack"));
// execute eject
{
    [_aircraft,_x,_chuteType,_forEachIndex,_invincibleOnDrop] remoteExec ["KISKA_fnc_staticLine_eject",_x];
} forEach _dropArrayFiltered;

nil

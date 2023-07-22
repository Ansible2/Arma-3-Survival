#include "..\..\Headers\descriptionEXT\supportDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_passiveHelicopterGunner

Description:
    Spawns a helicopter that will partol a given area for a period of time.

Parameters:
    0: _aircraftType : <STRING> - The class of the helicopter to spawn
    1: _timeOnStation : <NUMBER> - How long will the aircraft be supporting
    2: _flyinHeight : <NUMBER> - The altittude the aircraft flys at
    3: _approachBearing : <NUMBER> - The bearing from which the aircraft will approach from (if below 0, it will be random)
    4: _defaultVehicleType : <STRING> - If the _aircraftType fails to meet the requirements
       to support, the fallback vehicle type that should be used
    5: _globalLimiter <STRING> - The global used to limit having too many of a certain support active at any time
    6: _side : <SIDE> - The side of the created helicopter

Returns:
    ARRAY - The vehicle info
        0: <OBJECT> - The vehicle created
        1: <ARRAY> - The vehicle crew
        2: <GROUP> - The group the crew is a part of
        3: <ARRAY> - Turret units

Examples:
    (begin example)
        private _aircraftType = [7] call BLWK_fnc_getFriendlyVehicleClass;
        private _timeOnStation = 300;
        private _flyInHeight = 30;
        private _defaultVehicleType = "B_Heli_Attack_01_dynamicLoadout_F";
        
        [
            _aircraftType,
            _timeOnStation,
            _flyInHeight,
            _defaultVehicleType
        ] call BLWK_fnc_passiveHelicopterGunner;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_passiveHelicopterGunner";

#define SPEED_LIMIT 10
#define FLY_IN_DIRECTION -1

params [
    ["_aircraftType","",[""]],
    ["_timeOnStation",300,[123]],
    ["_flyInHeight",30,[123]],
    ["_defaultVehicleType","",[""]],
    ["_globalLimiter","",[""]],
    ["_side",BLUFOR,[BLUFOR]]
];


if (_globalLimiter isNotEqualTo "") then {
    missionNamespace setVariable [_globalLimiter,true,true];
};


private _onSupportEnd = [[_globalLimiter,_side],{
    _this params ["_heli","","_crew"];
    _thisArgs params ["_globalLimiter","_side"];
    
    if (_globalLimiter isNotEqualTo "") then {
        missionNamespace setVariable [_globalLimiter,false,true];
    };

    if (_side isNotEqualTo BLUFOR) exitWith { true };

    if (isNull (currentPilot _heli)) then {
        [TYPE_HELO_DOWN] call BLWK_fnc_supportRadioGlobal;
    } else {
        [TYPE_CAS_ABORT] call BLWK_fnc_supportRadioGlobal;
    };

    true
}];


private _args = [
    BLWK_playAreaCenter,
    BLWK_playAreaRadius,
    _aircraftType,
    _timeOnStation,
    SPEED_LIMIT,
    _flyInHeight,
    FLY_IN_DIRECTION,
    _side,
    _onSupportEnd
];

private _heliInfo = _args call KISKA_fnc_helicopterGunner;

if (_heliInfo isEqualTo []) then {
    _args set [2,_defaultVehicleType];
    _heliInfo = _args call KISKA_fnc_helicopterGunner;
};


_heliInfo params ["_helicopter"];
[BLWK_zeus,[[_helicopter],true]] remoteExec ["addCuratorEditableObjects",2];


_heliInfo

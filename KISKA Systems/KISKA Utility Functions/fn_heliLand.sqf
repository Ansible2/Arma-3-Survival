/* ----------------------------------------------------------------------------
Function: KISKA_fnc_heliLand

Description:
    Makes a helicopter land at a given position.

Parameters:
    0: _aircraft <OBJECT> - The helicopter
    1: _landingPosition <ARRAY or OBJECT> - Where to land. If object, position ATL is used.
    2: _landMode <STRING> - Options are "LAND", "GET IN", and "GET OUT"
    3: _createHelipad <BOOL> - If true, and invisible helipad will be created. Helipads strongly encourage where a unit will land.
    4: _afterLandCode <CODE, STRING, or ARRAY> - Code to spawn after the helicopter has landed. See KISKA_fnc_callBack
        
        Parameters:
        - 0: <OBJECT> - The helicopter

Returns:
    <BOOL> - True if helicopter can attempt, false if problem

Examples:
    (begin example)
        [myHeli,position player] call KISKA_fnc_heliLand;
    (end)

Author:
    Karel Moricky,
    Modified By: Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_heliLand";

#define HELIPAD_BASE "Helipad_base_F"
#define INVISIBLE_PAD_TYPE "Land_HelipadEmpty_F"
#define LAND_EVENT "KISKA_landedEvent"
#define HIGH_LANDED_THRESHOLD 3

params [
    ["_aircraft",objNull,[objNull]],
    ["_landingPosition",[],[[],objNull]],
    ["_landMode","LAND",[""]],
    ["_createHelipad",true,[true]],
    ["_afterLandCode",{},[{},"",[]]]
];

if (isNull _aircraft) exitWith {
    ["_aircraft is a null object",true] call KISKA_fnc_log;
    false
};

if (!(_aircraft isKindOf "Helicopter") AND {!(_aircraft isKindOf "VTOL_Base_F")}) exitWith {
    [[_aircraft," is not a helicopter or VTOL, exiting..."],true] call KISKA_fnc_log;
    false
};

// disable aceX hc transfer
[group (currentPilot _aircraft),true] call KISKA_fnc_ACEX_setHCTransfer;

// move command only supports positions, not objects
if (_landingPosition isEqualType objNull) then {
    // if LZ is already a pad, don't create another one
    if (_createHelipad AND {_landingPosition isKindOf HELIPAD_BASE}) then {
        _createHelipad = false;
    };
    _landingPosition = getPosATL _landingPosition;
};

// helipads are where AI will primarly look to land
if (_createHelipad) then {
    INVISIBLE_PAD_TYPE createVehicle _landingPosition;
};

private _keepEngineOn = false;
private _landedHeight = 0.1;
_landMode = toUpperANSI _landMode;
if (_landMode isNotEqualTo "LAND") then {
    switch (_landMode) do {
        case "GET IN";
        case "GET OUT": {
            _keepEngineOn = true;
            _landedHeight = HIGH_LANDED_THRESHOLD;
        };

        default {
            [["Unknown land type: ", _landMode," used for aircraft: ",_aircraft," . Changing to mode 'LAND'"],true] call KISKA_fnc_log;
            _landMode = "LAND";
        };
    };
};


[_aircraft,_landingPosition,_landMode,_afterLandCode,_keepEngineOn,_landedHeight] spawn {
    params ["_aircraft","_landingPosition","_landMode","_afterLandCode","_keepEngineOn","_landedHeight"];

    _aircraft move _landingPosition;
    _aircraft setVariable ["KISKA_isLanding",true];

    private _landed = false;
    private _wasToldToLand = false;
    private "_unitAlt";
    waitUntil {
        sleep 1;
        if (!alive _aircraft) exitWith {true};
        // to interrupt a landing aircraft
        if (_aircraft getVariable ["KISKA_cancelLanding",false]) exitWith {true};

        if !(_wasToldToLand) then {
            // tell unit to land at position when ready
            if (unitReady _aircraft) then {
                _aircraft land _landMode;
                _wasToldToLand = true;
            };

        } else {
            _unitAlt = (getPosATL _aircraft) select 2;
            if (isTouchingGround _aircraft OR (_unitAlt <= _landedHeight)) then {
                _landed = true;
                // reinforce land
                // sometimes, the helicopter will "land" but immediately take off again
                // this is why the thing is told to land again
                sleep 2;
                _aircraft land _landMode;

                if (_keepEngineOn) then {
                    _aircraft engineon true;
                };
            };

        };

        _landed
    };

    // variable to track if other code can run
    _aircraft setVariable ["KISKA_cancelLanding",false];
    _aircraft setVariable ["KISKA_isLanding",false];

    [[_aircraft],_afterLandCode] call KISKA_fnc_callBack;
    [_aircraft,LAND_EVENT,[_aircraft]] call BIS_fnc_callScriptedEventHandler;
};


true

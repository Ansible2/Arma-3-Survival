#include "..\Headers\View Distance Limiter Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_viewDistanceLimiter

Description:
    Starts a looping function for limiting a player's viewDistance.
    Loop can be stopped by setting mission variable "KISKA_VDL_run" to false.
    All other values have global vars that can be edited while it is in use.

    See each param for associated global var.

Parameters:
    0: _targetFPS <NUMBER> - The desired FPS (lower) limit (KISKA_VDL_fps)
    1: _checkFreq <NUMBER> - The frequency of checks for FPS (KISKA_VDL_freq)
    2: _minObjectDistance <NUMBER> - The minimum the objectViewDistance, can be set by (KISKA_VDL_minDist)
    3: _maxObjectDistance <NUMBER> - The max the objectViewDistance, can be set by (KISKA_VDL_maxDist)
    4: _increment <NUMBER> - The amount the viewDistance can incriment up or down each cycle (KISKA_VDL_inc)
    5: _viewDistance <NUMBER> - This is the static overall viewDistance, can be set by (KISKA_VDL_viewDist)
                                 This is static because it doesn't affect FPS too much.

Returns:
    NOTHING

Examples:
    (begin example)
        Every 3 seconds, check
        [45,3,500,1700,25,3000] spawn KISKA_fnc_viewDistanceLimiter;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_viewDistanceLimiter";

#define DEFAULT_TARGET_FPS 60
#define DEFAULT_FREQ 0.5
#define DEFAULT_MIN_DIST 500
#define DEFAULT_MAX_DIST 1200
#define DEFAULT_INCREMENT 25
#define DEFAULT_VIEW_DIST 3000

if (!hasInterface) exitWith {};

if (!canSuspend) exitWith {
    ["Must be run in a scheduled environment. Exiting to scheduled...",true] call KISKA_fnc_log;
    _this spawn KISKA_fnc_viewDistanceLimiter
};

params [
    ["_targetFPS",localNamespace getVariable ["KISKA_VDL_fps",DEFAULT_TARGET_FPS],[123]],
    ["_checkFreq",localNamespace getVariable ["KISKA_VDL_freq",DEFAULT_FREQ],[123]],
    ["_minObjectDistance",localNamespace getVariable ["KISKA_VDL_minDist",DEFAULT_MIN_DIST],[123]],
    ["_maxObjectDistance",localNamespace getVariable ["KISKA_VDL_maxDist",DEFAULT_MAX_DIST],[123]],
    ["_increment",localNamespace getVariable ["KISKA_VDL_increment",DEFAULT_INCREMENT],[123]],
    ["_viewDistance",localNamespace getVariable ["KISKA_VDL_viewDist",DEFAULT_VIEW_DIST],[123]]
];


localNamespace setVariable ["KISKA_VDL_run",true];
localNamespace setVariable ["KISKA_VDL_fps",_targetFPS];
localNamespace setVariable ["KISKA_VDL_freq",_checkFreq];
localNamespace setVariable ["KISKA_VDL_increment",_increment];
if (_minObjectDistance > _maxObjectDistance) then {
    _minObjectDistance = _maxObjectDistance;
};
localNamespace setVariable ["KISKA_VDL_minDist",_minObjectDistance];
localNamespace setVariable ["KISKA_VDL_maxDist",_maxObjectDistance];
if (_viewDistance < _maxObjectDistance) then {
    _viewDistance = _maxObjectDistance;
};
localNamespace setVariable ["KISKA_VDL_viewDist",_viewDistance];

localNamespace setVariable ["KISKA_VDL_isRunning",true];
while {
    private _adjustmentFrequency = localNamespace getVariable ["KISKA_VDL_freq",DEFAULT_FREQ];
    sleep _adjustmentFrequency;

    localNamespace getVariable ["KISKA_VDL_run",false]
} do {
    private _currentObjectViewDistance = getObjectViewDistance select 0;
    private _isViewDistanceTied = localNamespace getVariable ["KISKA_VDL_tiedViewDistance",false];
    private _viewDistance = localNamespace getVariable ["KISKA_VDL_viewDist",DEFAULT_VIEW_DIST];
    if (
        (!_isViewDistanceTied) AND 
        (_viewDistance isNotEqualTo viewDistance)
    ) then {
        setViewDistance _viewDistance;
    };

    private _targetFPS = localNamespace getVariable ["KISKA_VDL_fps",DEFAULT_TARGET_FPS];
    private _adjustmentIncrement = localNamespace getVariable ["KISKA_VDL_increment",DEFAULT_INCREMENT];
    private _fpsIsHigherThanTarget = diag_fps > _targetFPS;
    private "_newViewDistance";
    if (_fpsIsHigherThanTarget) then {
        private _maxDistance = localNamespace getVariable ["KISKA_VDL_maxDist",DEFAULT_MAX_DIST];
        _newViewDistance = _currentObjectViewDistance + _adjustmentIncrement;
        if (_newViewDistance > _maxDistance) then {
            _newViewDistance = _maxDistance;
        };

    } else {
        private _minDistance = localNamespace getVariable ["KISKA_VDL_minDist",DEFAULT_MIN_DIST];
        _newViewDistance = _currentObjectViewDistance - _adjustmentIncrement;
        if (_newViewDistance < _minDistance) then {
            _newViewDistance = _minDistance;
        };

    };

    if (_newViewDistance == _currentObjectViewDistance) then { continue; };
    if (_isViewDistanceTied) then {
        setViewDistance _newViewDistance;
    };
    setObjectViewDistance _newViewDistance;
};

localNamespace setVariable ["KISKA_VDL_isRunning",false];
setViewDistance -1;
setObjectViewDistance -1;

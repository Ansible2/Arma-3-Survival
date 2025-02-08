/* ----------------------------------------------------------------------------
Function: CBAP_fnc_removePerFrameHandler

Description:
    A cheap imitation of CBAP_fnc_removePerFrameHandler that uses scheduled environment.

    Remove a handler that you have added using CBAP_fnc_addPerFrameHandler.

Parameters:
    _handle - The function handle you wish to remove. <NUMBER>

Returns:
    true if removed successful, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _handle = [{player sideChat format["every frame! _this: %1", _this];}, 0, ["some","params",1,2,3]] call CBA_fnc_addPerFrameHandler;
        sleep 10;
        [_handle] call CBA_fnc_removePerFrameHandler;
    (end)

Author:
    Nou & Jaynus, donated from ACRE project code for use by the community; commy2
---------------------------------------------------------------------------- */
params [
    ["_handle", -1, [0]]
];

[
    {
        params ["_handle"];

        private _runningVar = 'CBAP_runPerFrameHandler_' + (str _handle);
        private _isRunning = localNamespace getVariable [_runningVar,false];
        if (!_isRunning) exitWith { false };

        localNamespace setVariable [_runningVar,nil];
        true
    }, 
    _handle
] call CBAP_fnc_directCall
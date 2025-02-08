/* ----------------------------------------------------------------------------
Function: CBAP_fnc_addPerFrameHandler

Description:
    A cheap imitation of CBAP_fnc_addPerFrameHandler that uses scheduled environment.

    The actual code to run (_function) will be executed in an unscheduled environment.

    Avoid using this.

Parameters:
    0: _function <CODE> - The function you wish to execute.
    1: _delay <NUMBER> - The amount of time in seconds between executions, 0 for every frame. (optional, default: 0)
    2: _args <ANY> - Parameters passed to the function executing. This will be the same array every execution. (optional)

Returns:
    _handle - A number representing the handle of the function. Use this to remove the handler. <NUMBER>

Example:
    (begin example)
        _handle = [
            {player sideChat format ["every frame! _this: %1", _this];},
            0, 
            ["some","params",1,2,3]
        ] call CBAP_fnc_addPerFrameHandler;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
if (["cba_common"] call KISKA_fnc_isPatchLoaded) exitWith {
    _this call CBA_fnc_addPerFrameHandler;
};

params [
    ["_function", {}, [{}]], 
    ["_delay", 0, [0]], 
    ["_args", []]
];

if (_function isEqualTo {}) exitWith {-1};

private _id = localNamespace getVariable ['CBAP_perFrameHandlerIdCount',0];
localNamespace setVariable ['CBAP_perFrameHandlerIdCount',_id + 1];
localNamespace setVariable ['CBAP_runPerFrameHandler_' + (str _id),true];

[_function,_delay,_args,_id] spawn {
    private _runVar = 'CBAP_runPerFrameHandler_' + (str _id);
    waitUntil {
        [
            _function,
            _args
        ] call CBAP_fnc_directCall;

        if (_delay > 0) then {
            sleep _delay;
        };

        localNamespace getVariable [_runVar,false]
    };
};


_id

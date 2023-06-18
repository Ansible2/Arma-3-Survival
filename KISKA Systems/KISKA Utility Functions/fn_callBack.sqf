/* ----------------------------------------------------------------------------
Function: KISKA_fnc_callBack

Description:
    Standerdizes a means of passing a callback function to another function
    along with custom arguments.

Parameters:
    0: _defaultArgs <ARRAY> - Default arguements. These would be what a function
        writer would put inside of their code as arguements that will always be passed
        in the _this magic variable
    1: _callBackFunction <CODE, STRING, ARRAY> - Code to call, compile and call, and/or
        arguements to pass to the code (in _thisArgs variable). Array is formatted as
        [<args array>,code or string (to compile)]
    2: _runInScheduled <BOOL> - Spawns the code in a scheduled thread

Returns:
    <ANY> - Whatever the callback function returns or scripthandle if run in scheduled

Examples:
    (begin example)
        [
            [],
            [
                // hint player
                [player],
                {hint (_thisArgs select 0)}
            ]
        ] call KISKA_fnc_callBack
    (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_callBack";

params [
    ["_defaultArgs",[],[[]]],
    ["_callBackFunction",{},[[],"",{}]],
    ["_runInScheduled",false,[true]]
];

if (_callBackFunction isEqualType {}) exitWith {
    [
        _callBackFunction,
        _defaultArgs
    ] call CBAP_fnc_directCall;
};

if (_callBackFunction isEqualType "") exitWith {
    [
        compile _callBackFunction,
        _defaultArgs
    ] call CBAP_fnc_directCall;
};

if (
    !(_callBackFunction isEqualTypeParams [[],""]) AND
    {!(_callBackFunction isEqualTypeParams [[],{}])}
) exitWith {
    [["_callBackFunction improperly configured array. Must be [ARRAY,STRING] or [ARRAY,CODE]. Got: ", _callBackFunction],true] call KISKA_fnc_log;
    nil
};

private _thisArgs = _callBackFunction select 0;
_callBackFunction = _callBackFunction select 1;
if (_callBackFunction isEqualType "") then {
    _callBackFunction = compile _callBackFunction;
};


if (_runInScheduled) exitWith {
    [
        _defaultArgs,
        _thisArgs,
        _callBackFunction
    ] spawn {
        params ["_defaultArgs","_thisArgs","_callBackFunction"];
        _defaultArgs call _callBackFunction;
    };
};


[
    {
        params ["_defaultArgs","_thisArgs","_callBackFunction"];
        _defaultArgs call _callBackFunction;
    },
    [
        _defaultArgs,
        _thisArgs,
        _callBackFunction
    ]
] call CBAP_fnc_directCall;

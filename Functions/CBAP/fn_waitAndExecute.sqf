/* ----------------------------------------------------------------------------
Function: CBAP_fnc_waitAndExecute

Description:
    A cheap imitation of CBA_fnc_waitAndExecute that uses scheduled environment.

    The actual code to run (_function) will be executed in an unscheduled environment.

Parameters:
    0: _function <CODE> - The code to execute after the wait time
    1: _args <ANY> - Any arguments to pass to the _function
    2: _delay <NUMBER> - How long to wait until executed the _function in seconds

Returns:
    NOTHING

Example:
    (begin example)
        [
            {
                player sideChat format ["5s later! _this: %1", _this];
            },
            ["some","params",1,2,3], 
            5
        ] call CBAP_fnc_waitAndExecute;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
if (["cba_common"] call KISKA_fnc_isPatchLoaded) exitWith {
    _this call CBA_fnc_waitAndExecute;
};

params [
    ["_function", {}, [{}]],
    ["_args", []],
    ["_delay", 0, [123]]
];

if (_delay <= 0) exitWith {
    [_function,_args] call CBAP_fnc_directCall;
};

_this spawn {
    params ["_function","_args","_delay"];

    sleep _delay;

    [_function,_args] call CBAP_fnc_directCall;
};


nil

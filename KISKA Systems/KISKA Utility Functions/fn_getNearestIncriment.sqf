/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getNearestIncriment

Description:
    Rounds off a number to the nearest incriment.

Parameters:
    0: _numberToCheck : <NUMBER> - The number to round off
    1: _incriment : <NUMBER> - The incriment by which the number should be assessed

Returns:
    <NUMBER> - The nearest incriment to the given number

Examples:
    (begin example)
        // -0.22
        _nearestIncriment = [-0.223,0.01] call KISKA_fnc_getNearestIncriment;
    (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_getNearestIncriment";

params [
    ["_numberToCheck",0,[123]],
    ["_incriment",1,[123]]
];

_incriment = abs _incriment;
private _result = (abs _numberToCheck + (_incriment / 2));
_result = _result - (_result mod _incriment);

if (_numberToCheck < 0 AND (_result isNotEqualTo 0)) then {
    _result * -1

} else {
    _result

};

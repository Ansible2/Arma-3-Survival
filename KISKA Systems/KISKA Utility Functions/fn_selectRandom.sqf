/* ----------------------------------------------------------------------------
Function: KISKA_fnc_selectRandom

Description:
    Selects randomly an entry from an array be it weighted or unweighted.

Parameters:
    0: _array <ARRAY> - An array either formatted as [value, weight (number)], or
        just values ([value1,value2])
    1: _valueType <ANY> - A variable that should have the same type as the value
        entries in the array e.g. "" for string, [] for array
        (only needed for possibly weighted arrays)

Returns:
    <ANY> - Random entry from the array

Examples:
    (begin example)
        private _randomValue = [[
            "thing1",
            "thing2"
        ]] call KISKA_fnc_selectRandom;
    (end)
    
    (begin example)
        private _weight1 = 0.5;
        private _weight2 = 0.5;

        private _randomWeightedValue = [
            [
                "thing1", _weight1,
                "thing2", _weight2
            ],
            ""
        ] call KISKA_fnc_selectRandom;
    (end)

    (begin example)
        private _weight1 = 0.5;
        private _weight2 = 0.5;

        private _randomWeightedValue = [
            [
                ["thing1", "thing2"],
                [_weight1, _weight2]
            ],
            ""
        ] call KISKA_fnc_selectRandom;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_selectRandom";

#define VALUES_TO_SELECT (_array select 0)
#define WEIGHTS (_array select 1)

params [
    ["_array",[],[[]]],
    "_valueType"
];

if (isNil "_valueType") exitWith {
    selectRandom _array;
};

private _isWeightedArray_syntaxOne = (_array isEqualTypeParams [[],[]]) AND ((count _array) isEqualTo 2);
if (_isWeightedArray_syntaxOne) exitWith {
   VALUES_TO_SELECT selectRandomWeighted WEIGHTS;
};

private _isWeightedArray_syntaxTwo = _array isEqualTypeParams [_valueType,1];
if (_isWeightedArray_syntaxTwo) exitWith {
    selectRandomWeighted _array;
};


selectRandom _array;

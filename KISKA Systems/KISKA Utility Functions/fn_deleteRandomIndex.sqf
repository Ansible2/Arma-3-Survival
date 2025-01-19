/* ----------------------------------------------------------------------------
Function: KISKA_fnc_deleteRandomIndex

Description:
    Removes and returns a random item from an array

Parameters:
    0: _array <ARRAY> - The array to find a random index of.

Returns:
    <ANY> - The random item removed from the array

Examples:
    (begin example)
        private _randomDeletedItem = [[1,2,3]] call KISKA_fnc_deleteRandomIndex;
    (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_deleteRandomIndex";

params [
    ["_array",[],[[]]]
];


private _randomIndex = floor (random (count _array));
_array deleteAt _randomIndex
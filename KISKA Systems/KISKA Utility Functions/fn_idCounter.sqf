/* ----------------------------------------------------------------------------
Function: KISKA_fnc_idCounter

Description:
    For a given string id, return the latest "index" for that id.
     This increments the id by one each time it is called. This function does not
     check if the provided namespace is not null, so ensure it is checked

Parameters:
    0: _id <string> - The id to increment
    1: _namespace <GROUP, OBJECT, LOCATION, NAMESPACE, CONTROL, DISPLAY, TASK, TEAM-MEMBER> - The namespace
     to check the id count in, this is `localNamespace` by default.

Returns:
    <NUMBER> - the latest index of the given id

Examples:
    (begin example)
        private _latesIndexFor_myId = ["myId"] call KISKA_fnc_idCounter;
    (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_idCounter";

#define NULL_TYPES [grpNull,objNull,locationNull,controlNull,displayNull,taskNull,teamMemberNull]

params [
    ["_id","",[""]],
    ["_namespace",localNamespace,[grpNull,objNull,locationNull,controlNull,displayNull,taskNull,teamMemberNull,localNamespace]]
];


if ((_namespace isEqualTypeAny NULL_TYPES) AND {isNull _namespace}) exitWith {
    [["Null namespace passed for id ",_id," namespace ",_namespace],true] call KISKA_fnc_log;
    -1
};

if (_id isEqualTo "") exitWith {
    ["Empty _id provided",true] call KISKA_fnc_log;
    -1
};


_id = toLowerANSI _id;
private _indexMap = _namespace getVariable "KISKA_indexMap";
if (isNil "_indexMap") then {
    _indexMap = createHashMap;
    _namespace setVariable ["KISKA_indexMap",_indexMap];
};

private _latestIndex = _indexMap getOrDefault [_id, 0];
_indexMap set [_id,_latestIndex + 1];


_latestIndex

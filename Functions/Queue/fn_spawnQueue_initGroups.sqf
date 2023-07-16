/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_initGroups

Description:
    Creates the limited set of groups that the spawn queue will use during the
     mission.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_spawnQueue_initGroups;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_spawnQueue_initGroups";

#define NUMBER_OF_GROUPS 50

if !(local BLWK_theAIHandlerEntity) exitWith {
    [
        [
            "BLWK_fnc_spawnQueue_initGroups was called on machine where clientOwner is: ",
            clientOwner,
            " but BLWK_theAIHandlerEntity is not local"
        ]
    ] remoteExecCall ["KISKA_fnc_log",2];

    nil
};

private _groups = [];
for "_i" from 1 to NUMBER_OF_GROUPS do { 
    _groups pushBack (createGroup [OPFOR,false]);
};

localNamespace setVariable ["BLWK_spawnQueue_groups",_groups];
localNamespace setVariable ["BLWK_spawnQueue_cleanUpGroup",createGroup [OPFOR,false]];






// A limited number of groups are used by the AI handler
// dead AI are moved into a group to be used for dead units on the AI handler
// Multiple AI are assigned to a given group
// Players can choose group sizes as a parameter
// stalker system rewritten to handle groups and dynamically change leader
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spawnQueue_initGroups

Description:
    Creates the clean up group used by the spawn queue units to be able to immediately
     delete empty groups.

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

localNamespace setVariable ["BLWK_spawnQueue_cleanUpGroup",createGroup [OPFOR,false]];

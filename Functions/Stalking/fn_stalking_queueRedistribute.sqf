/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stalking_queueRedistribute

Description:
    Queues a redistribute for groups that are currently stalking players to find
     a new player to stalk.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        [] remoteExec ["BLWK_fnc_stalking_start",BLWK_theAiHandlerOwnerId];
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_stalking_queueRedistribute";

(groups OPFOR) apply {
    private _isStalkingGroup = _x getVariable ["BLWK_stalking_doStalk",false];
    if !(_isStalkingGroup) then { continue };
    
    _x setVariable ["BLWK_stalking_redistribute",true];
};


nil

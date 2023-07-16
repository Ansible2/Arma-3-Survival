/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stalking_setStalkedPlayer

Description:
    Updates a player's stalker number and sets variables on the stalker group.

Parameters:
    0: _stalkerGroup : <GROUP> - The group to add as a stalker
    1: _playerToStalk : <OBJECT> - The player to set as being stalked by the group

Returns:
    NOTHING

Examples:
    (begin example)
        [aStalkerGroup,player] call BLWK_fnc_stalking_setStalkedPlayer;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_stalking_setStalkedPlayer";

params [
    ["_stalkerGroup",grpNull,[grpNull]],
    ["_playerToStalk",objNull,[objNull]]
];

if ((isNull _stalkerGroup) OR (isNull _playerToStalk)) exitWith {
    [["Null argument passed, params are: ",_this]] call KISKA_fnc_log;
    nil
};


[_stalkerGroup] call BLWK_fnc_stalking_removeStalkedPlayer;


private _currentStalkingGroupCount = _playerToStalk getVariable ["BLWK_stalking_numberOfStalkerGroups",0];
_playerToStalk setVariable ["BLWK_stalking_numberOfStalkerGroups",_currentStalkingGroupCount + 1];

_stalkerGroup setVariable ["BLWK_stalking_stalkedPlayer",_playerToStalk];

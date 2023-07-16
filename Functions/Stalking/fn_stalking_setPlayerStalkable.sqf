/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stalking_setPlayerStalkable

Description:
    Sets whether or not a player can be stalked.

    Changing this setting from it's previous will trigger a redistribution of AI
     stalkers on all players.

Parameters:
    0: _player : <OBJECT> - The player to allow or disallow stalking
    1: _newSetting : <BOOLEAN> - Whether or not to allow stalking

Returns:
    NOTHING

Examples:
    (begin example)
        [player,false] remoteExecCall [
            "BLWK_fnc_stalking_setPlayerStalkable",
            BLWK_theAiHandlerOwnerId
        ];
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_stalking_setPlayerStalkable";

params [
    ["_player",objNull,[objNull]],
    ["_newSetting",true,[true]]
];

// can stalked is true by default
private _previousSetting = _player getVariable ["BLWK_stalking_canBeStalked",true];
if (_previousSetting isEqualTo _newSetting) exitWith {};

_player setVariable ["BLWK_stalking_canBeStalked",_newSetting];

call BLWK_fnc_stalking_queueRedistribute;

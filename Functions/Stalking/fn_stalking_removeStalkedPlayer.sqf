/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stalking_removeStalkedPlayer

Description:
    Updates a player's stalker number and sets variables on the stalker group.

Parameters:
    0: _stalkerGroup : <GROUP> - The group to remove stalked player from

Returns:
    NOTHING

Examples:
    (begin example)
        [aStalkerGroup] call BLWK_fnc_stalking_removeStalkedPlayer;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_stalking_removeStalkedPlayer";

params [
    ["_stalkerGroup",grpNull,[grpNull]]
];

if ((isNull _stalkerGroup) OR (isNull _playerToStalk)) exitWith {
    [["Null argument passed, params are: ",_this]] call KISKA_fnc_log;
    nil
};

private _playerBeingStalked = _stalkerGroup getVariable ["BLWK_stalking_stalkedPlayer",objNull];

if !(isNull _playerBeingStalked) then {
    private _numberOfStalkerGroups = _playerToStalk getVariable ["BLWK_stalking_numberOfStalkerGroups",0];
    _playerToStalk setVariable [
        "BLWK_stalking_numberOfStalkerGroups",
        (_numberOfStalkerGroups - 1) max 0
    ];
};

_stalkerGroup setVariable ["BLWK_stalking_stalkedPlayer",nil];

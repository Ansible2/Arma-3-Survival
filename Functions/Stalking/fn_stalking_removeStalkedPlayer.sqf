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

private _playerBeingStalked = _stalkerGroup getVariable ["BLWK_stalking_stalkedPlayer",objNull];
if ((isNull _stalkerGroup) AND (isNull _playerBeingStalked)) exitWith {
    ["Both _stalkerGroup AND _playerBeingStalked are null, exiting..."] call KISKA_fnc_log;
    nil
};


if !(isNull _playerBeingStalked) then {
    private _numberOfStalkerGroups = _playerBeingStalked getVariable ["BLWK_stalking_numberOfStalkerGroups",0];
    _playerBeingStalked setVariable [
        "BLWK_stalking_numberOfStalkerGroups",
        (_numberOfStalkerGroups - 1) max 0
    ];
};

_stalkerGroup setVariable ["BLWK_stalking_stalkedPlayer",nil];

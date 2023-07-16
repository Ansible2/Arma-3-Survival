/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stalking_getPlayer

Description:
    Finds the player with the least amount of stalkers that can be stalked.

Parameters:
    NONE

Returns:
    <OBJECT> - player with least amount of stalkers or null object if none found

Examples:
    (begin example)
        private _bestStalkablePlayer = call BLWK_fnc_stalking_getPlayer;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
private _players = call CBAP_fnc_players;
// sort players that can be stalked

_players = _players select { [_x] call BLWK_fnc_stalking_canPlayerBeStalked };
if (_players isEqualTo []) exitWith {
    objNull
};


private _playerStalkerCounts = [];
private ["_lowestStalkerCount","_playerWithLowestStalkers"];
{
    private _playersCurrentStalkerCount = _x getVariable [STALKER_COUNT_VAR,0];
    _playerStalkerCounts pushBack _playersCurrentStalkerCount;
    if (_forEachIndex isEqualTo 0) then {
        _lowestStalkerCount = _playersCurrentStalkerCount;
        _playerWithLowestStalkers = _x;
        continue;
    };
    
    if (_playersCurrentStalkerCount < _lowestStalkerCount) then {
        _lowestStalkerCount = _playersCurrentStalkerCount;
        _playerWithLowestStalkers = _x;
    };
} forEach _players;


_playerWithLowestStalkers

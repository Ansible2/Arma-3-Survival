#include "..\..\Headers\Stalker Global Strings.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_getAPlayerToStalk

Description:
	Finds the player with the least amount of stalkers that can be stalked.

Parameters:
	NONE

Returns:
	OBJECT - player with least amount of stalkers or null object if none found

Examples:
    (begin example)
		_bestStalkablePlayer = call BLWK_fnc_getAPlayerToStalk;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
private _players = call CBAP_fnc_players;
// sort players that can be stalked
_players = _players select {[_x] call BLWK_fnc_canUnitBeStalked};
if (_players isEqualTo []) exitWith {
	objNull
};

// get the player with the least amount of stalkers
private _playerStalkerCounts = [];
private ["_lowestStalkerCount","_playerWithLowestStalkers","_numberOfStalkers"];
{
	_numberOfStalkers = _x getVariable [STALKER_COUNT_VAR,0];
	_playerStalkerCounts pushBack _numberOfStalkers;
	if (_forEachIndex isEqualTo 0) then {
		_lowestStalkerCount = _numberOfStalkers;
		_playerWithLowestStalkers = _x;
	} else {
		if (_numberOfStalkers < _lowestStalkerCount) then {
			_lowestStalkerCount = _numberOfStalkers;
			_playerWithLowestStalkers = _x;
		};
	};
} forEach _players;

//private _lowestStalkerCount = selectMin _playerStalkerCounts;
//private _playerWithLowestStalkers = _players select (_playerStalkerCounts findIf {_x isEqualTo _lowestStalkerCount});


[["Returning player: ",_playerWithLowestStalkers," with a stalker count of: ",_lowestStalkerCount],false] call KISKA_fnc_log;
_playerWithLowestStalkers
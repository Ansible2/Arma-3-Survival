#include "..\..\Headers\Stalker Global Strings.hpp"

private _players = call CBAP_fnc_players;
// sort players that can be stalked
_players = _players select {[_x] call BLWK_fnc_canUnitBeStalked};
if (_players isEqualTo []) exitWith {
	objNull
};
private _playerStalkerCounts = [];
_players apply {
	_playerStalkerCounts pushBack (_x getVariable [STALKER_COUNT_VAR,0]); 
};
private _lowestStalkerCount = selectMin _playerStalkerCounts;
private _playerWithLowestStalkers = _players select (_playerStalkerCounts findIf {_x isEqualTo _lowestStalkerCount});


_playerWithLowestStalkers
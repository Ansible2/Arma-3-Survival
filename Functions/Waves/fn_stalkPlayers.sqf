/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stalkPlayer

Description:
	Continuously updates a groups waypoints to that of an alive player
	 so that it appears they are following them.
	The group's' stalking can be turned off setting "BLWK_doStalkPlayers" in the
	 group's namespace to false.

Parameters:
	0: _stalkerGroupGroup : <OBJECT or GROUP> - The unit/group that you want to be constantly stalking players.
	1: _defaultPosition : <OBJECT, ARRAY, or GROUP> - If all player units are dead, the stalker(s) will move to this position
	1: _checkRate : <NUMBER> - How often to update the stalker's waypoints and to check the _conditionToEndStalking (OPTIONAL)
	2: _conditionToEndStalking : <CODE> - The code that gets check every refresh to see if the stalking shoudld end (OPTIONAL) Current players array are passed var
	
Returns:
	NOTHING

Examples:
    (begin example)

		null = [myGroup,bulwarkBox,10] spawn BLWK_fnc_stalkPlayer;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define STALK_PLAYERS_VAR "BLWK_doStalkPlayers"
#define STALKER_COUNT_VAR "BLWK_stalkerAmount"

if (!canSuspend) exitWith {
	"BLWK_fnc_stalkPlayer must be run in a scheduled environment" call BIS_fnc_error;
};

params [
	["_stalkerGroup",grpNull,[objNull,grpNull]],
	["_defaultPosition",bulwarkBox,[objNull,grpNull,[]]],
	["_checkRate",10,[123]],
	["_conditionToEndStalking",{},[{}]]
];

if (isNull _stalkerGroup) exitWith {
	"BLWK_fnc_stalkPlayer _stalkerGroup isNull" call BIS_fnc_error;
};

if (_stalkerGroup isEqualType objNull) then {
	_stalkerGroup = group _stalkerGroup;
};


if (_conditionToEndStalking isEqualTo {}) then {
	_conditionToEndStalking = {false};
};


private "_players";
private _fn_allPlayersDead = {
	_players = call CBAP_fnc_players;
	private _return = _players findIf {alive _x};

	if (_return isEqualTo -1) then {
		true
	} else {
		false
	};
};

private _fn_findAPlayerToStalk = {	
	_players = call CBAP_fnc_players;

	private _playerWithLowestStalkers = _players select 0;
	private _lowestStalkerCount = 0;
	private "_currentPlayersStalkerCount_temp";
	
	_players apply {
		_currentPlayersStalkerCount_temp = _x getVariable [STALKER_COUNT_VAR,0];	
		if (_currentPlayersStalkerCount_temp < _lowestStalkerCount) then {
			_playerWithLowestStalkers = _x;
			_lowestStalkerCount = _currentPlayersStalkerCount_temp;
		};
	};

	_playerWithLowestStalkers setVariable [STALKER_COUNT_VAR,_lowestStalkerCount + 1];

	_playerWithLowestStalkers
};


_stalkerGroup setVariable [STALK_PLAYERS_VAR,true];


private _currentlyStalkedPlayer = objNull;

while {_stalkerGroup getVariable STALK_PLAYERS_VAR} do {
	if (isNull _currentlyStalkedPlayer OR {!(alive _currentlyStalkedPlayer)}) then {
		_currentlyStalkedPlayer = call _fn_findAPlayerToStalk;
	};

	[_stalkerGroup] call CBAP_fnc_clearWaypoints;
	[_stalkerGroup, _currentlyStalkedPlayer, 10, "MOVE", "AWARE", "RED"] call CBAP_fnc_addWaypoint;
	
	sleep _checkRate;

	if ([_players] call _conditionToEndStalking OR {call _fn_allPlayersDead}) exitWith {
		[_stalkerGroup, _defaultPosition, 10, "MOVE", "AWARE", "RED"] call CBAP_fnc_addWaypoint;
	};
};
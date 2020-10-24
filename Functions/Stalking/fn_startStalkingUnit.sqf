#define DO_STALK_PLAYERS_VAR "BLWK_doStalkPlayers"
#define STALKER_COUNT_VAR "BLWK_stalkerAmount"

if (!canSuspend) exitWith {
	"BLWK_fnc_stalkPlayer must be run in a scheduled environment" call BIS_fnc_error;
};


params [
	["_stalkerGroup",grpNull,[objNull,grpNull]],
	["_defaultPosition",bulwarkBox,[objNull,grpNull,[]]],
	["_checkRate",10,[123]],
	["_conditionToEndStalking",{false},[{}]]
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







_stalkerGroup setVariable [DO_STALK_PLAYERS_VAR,true];


private _currentlyStalkedPlayer = objNull;
private "_stalkerGroupUnits";
while {(!isNull _stalkerGroup) AND (_stalkerGroup getVariable DO_STALK_PLAYERS_VAR)} do {
	// check if there are any units left in the stalker group to do the stalking
	_stalkerGroupUnits = units _stalkerGroup;
	if (_stalkerGroupUnits isEqualTo [] OR {(_stalkerGroupUnits findIf {alive _x}) isEqualTo -1}) exitWith {
		_stalkerGroup setVariable [DO_STALK_PLAYERS_VAR,nil];
	};

	// check if player is worth stalking and if not, get another player to stalk
	if (isNull _currentlyStalkedPlayer OR {!(alive _currentlyStalkedPlayer)} OR {!(incapacitatedState _currentlyStalkedPlayer isEqualTo "")}) then {
		_currentlyStalkedPlayer = call _fn_findAPlayerToStalk;
	};

	[_stalkerGroup] call CBAP_fnc_clearWaypoints;
	[_stalkerGroup, _currentlyStalkedPlayer, 10, "MOVE", "AWARE", "RED"] call CBAP_fnc_addWaypoint;

	sleep _checkRate;

	// check if stalking should end
	if (([_players] call _conditionToEndStalking) OR {call _fn_allPlayersDead}) exitWith {
		_stalkerGroup setVariable [DO_STALK_PLAYERS_VAR,nil];
		[_stalkerGroup, _defaultPosition, 10, "MOVE", "AWARE", "RED"] call CBAP_fnc_addWaypoint;
	};
};
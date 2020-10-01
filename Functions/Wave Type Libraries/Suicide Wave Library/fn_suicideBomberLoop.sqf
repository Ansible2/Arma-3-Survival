if (!canSuspend) exitWith {};

params ["_bomber"];

private ["_players","_nearPlayer"];
while {alive _bomber} do {
	_players = call CBAP_fnc_players;
	
	[_bomber,["suicideAudio",70]] remoteExec ["say3D",_players];
	
	_nearPlayer = _players findIf {(_bomber distance2D _x) <= 10};
	
	if (!(_nearPlayer isEqualTo -1) OR {_bomber distance2D bulwarkBox <= 10}) exitWith {
		[_bomber] call BLWK_fnc_explodeSuicideBomberEvent;
	};

	sleep 3;
};	
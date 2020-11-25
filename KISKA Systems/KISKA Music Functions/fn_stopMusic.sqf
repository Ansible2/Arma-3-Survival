if (!hasInterface) exitWith {};

if (!canSuspend) exitWith {
	"KISKA_fnc_stopMusic should be run in a scheduled environment" call BIS_fnc_error;
	null = _this spawn KISKA_fnc_stopMusic;
};

params [
	["_fadeTime",3,[123]]
];

if !(call KISKA_fnc_isMusicPlaying) exitWith {};

if (_fadeTime > 0) then {
	_fadeTime fadeMusic 0;
};
playMusic "";

// reset event handler values as playMusic "" does not activate music events
call KISKA_fnc_musicStopEvent;
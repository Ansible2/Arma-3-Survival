if (!hasInterface) exitWith {};

if (!canSuspend) exitWith {
	"KISKA_fnc_stopMusic should be run in a scheduled environment" call BIS_fnc_error;
	null = _this spawn KISKA_fnc_stopMusic;
};

params [
	["_fadeTime",3,[123]]
];

if !(call KISKA_fnc_isMusicPlaying) exitWith {};

_fadeTime fadeMusic 0;

playMusic "";

diag_log "manual music stop";
KISKA_musicPlaying = false;
KISKA_currentTrack = "";
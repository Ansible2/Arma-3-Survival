if (!isServer) exitWith {
	"Random music system needs to be stopped on the server" call BIS_fnc_error;
	false
};

params [
	["_playLastSong",false,[true]]
];

missionNamespace setVariable ["KISKA_musicSystemIsRunning",false];
if (!_playLastSong) then {
	null = remoteExec ["KISKA_fnc_stopRandomMusicClient",[0,-2] select isDedicated];
};

true
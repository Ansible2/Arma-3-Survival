if (!isServer) exitWith {
	"Random music system needs to be stopped on the server" call BIS_fnc_error;
	false
};

params [
	["_playLastSong",false,[true]]
];

if (_playLastSong) then {
	missionNamespace setVariable ["KISKA_musicSystemIsRunning",false];
} else {
	missionNamespace setVariable ["KISKA_musicSystemIsRunning",false,2];
	
	null = remoteExec ["KISKA_fnc_stopRandomMusicClient",0];
};

true
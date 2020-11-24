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

};

true
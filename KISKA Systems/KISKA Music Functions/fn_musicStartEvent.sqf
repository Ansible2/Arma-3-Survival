if (!hasInterface) exitWith {};

params [
	["_trackClassname","",[""]]
];
diag_log "music start";

KISKA_musicPlaying = true;
KISKA_currentTrack = _trackClassName;
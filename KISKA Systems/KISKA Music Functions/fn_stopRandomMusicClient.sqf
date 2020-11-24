if ((call KISKA_fnc_getMusicPlaying) == (call KISKA_fnc_getCurrentRandomMusicTrack)) then {
	call KISKA_fnc_stopMusic;
	
	true
} else {
	false
};
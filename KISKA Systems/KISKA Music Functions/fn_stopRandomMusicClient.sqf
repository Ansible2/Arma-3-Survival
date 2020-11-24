if (!hasInterface) exitWith {false};

if ((call KISKA_fnc_getMusicPlaying) == (call KISKA_fnc_getCurrentRandomMusicTrack)) then {
	/*
		there should in the future be a more robust way of determining if a track did indeed come
		 from KISKA_fnc_randomMusic. As it stands, if a manual song is playing that is ALSO in the list
		 and was played from random music, then it will still stop it
	*/
	null = [] spawn KISKA_fnc_stopMusic;
	
	true
} else {
	false
};
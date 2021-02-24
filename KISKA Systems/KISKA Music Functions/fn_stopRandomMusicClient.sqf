/* ----------------------------------------------------------------------------
Function: KISKA_fnc_stopRandomMusicClient

Description:
	The clientside part of stopping random music system.
	Ideally, should not be called on its own but used from KISKA_fnc_stopRandomMusicServer

Parameters:
	NONE

Returns:
	<BOOL> - True if done, false if nothing done

Examples:
    (begin example)

		call KISKA_fnc_stopRandomMusicClient;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_stopRandomMusicClient";

if (!hasInterface) exitWith {false};

if ((call KISKA_fnc_getMusicPlaying) == (call KISKA_fnc_getCurrentRandomMusicTrack)) then {
	/*
		there should in the future be a more robust way of determining if a track did indeed come
		 from KISKA_fnc_randomMusic. As it stands, if a manual song is playing that is ALSO in the list
		 and was played from random music, then it will still stop it
	*/
	[] spawn KISKA_fnc_stopMusic;
	
	true
} else {
	false
};
params ["_control"];


_control ctrlAddEventHandler ["MouseButtonDown",{
	// if music was playing
	if (uiNamespace getVariable ["BLWK_musicManager_doPlay",false]) then {
		playMusic ""; // stop music while adjusting
		call KISKA_fnc_musicStopEvent;
		uiNamespace setVariable ["BLWK_musicManager_doResume",true]; // tell music player in the mouse up event to resume
		uiNamespace setVariable ["BLWK_musicManager_doPlay",false]; // stop music player
	};
}];

_control ctrlAddEventHandler ["MouseButtonUp",{
	params ["_control"];

	// don't immediately play music if the music is paused
	if (uiNamespace getVariable ["BLWK_musicManager_doResume",false]) then {
		uiNamespace setVariable ["BLWK_musicManager_doResume",nil];
		private _musicClass = uiNamespace getVariable ["BLWK_musicManager_selectedTrack",""];
		null = [_musicClass,sliderPosition _control] spawn BLWK_fnc_musicManager_playMusic;
	};
}];
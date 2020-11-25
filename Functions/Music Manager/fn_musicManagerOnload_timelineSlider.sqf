params ["_control"];

_control ctrlAddEventHandler ["MouseButtonDown",{
	hint "mouse down";
	playMusic ""; // stop music while adjusting
}];
_control ctrlAddEventHandler ["MouseButtonUp",{
	params ["_control"];
	hint "mouse up";

	// don't immediately play music if the music is paused
	if (
		!(uiNamespace getVariable ["BLWK_musicManager_paused",false]) AND 
		{uiNamespace getVariable ["BLWK_musicManager_doPlay",false]}
	) then {
		private _musicClass = uiNamespace getVariable ["BLWK_musicManager_selectedTrack",""];
		null = [_musicClass,sliderPosition _control] spawn BLWK_fnc_musicManager_playMusic;
	};
}];
params ["_control"];

_control ctrlAddEventHandler ["sliderPosChanged",{
	params ["_control","_position"];

	// don't immediately play music if the music is paused
	if !(uiNamespace getVariable ["BLWK_musicManager_paused",false]) then {
		private _musicClass = uiNamespace getVariable ["BLWK_musicManager_selectedTrack",""];
		if !(_musicClass isEqualTo "") then {
			null = [_musicClass,_position] spawn BLWK_fnc_musicManager_playMusic;
		};
	};
}];
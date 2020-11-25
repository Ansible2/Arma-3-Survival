if (!canSuspend) exitWith {
	"BLWK_fnc_musicManager_moveTimeLine needs to be run in scheduled" call BIS_fnc_error;
};

private _sliderControl = uiNamespace getVariable "BLWK_musicManager_control_timelineSlider";
private _sliderMax = _sliderControl (sliderRange select 1);
private _currentTrack = uiNamespace getVariable "BLWK_musicManager_selectedTrack";
while { 
	(uiNamespace getVariable ["BLWK_musicManager_doPlay",true]) AND 
	{sliderPosition _sliderControl < _sliderMax} AND
	{_currentTrack == (uiNamespace getVariable "BLWK_musicManager_selectedTrack")}
} do {
 	
	sleep 1;
};
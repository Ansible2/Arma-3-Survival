if (!canSuspend) exitWith {
	"BLWK_fnc_musicManager_playMusic needs to be run in scheduled" call BIS_fnc_error;
};

params [
	"_musicClass",
	["_startTime",0]
];

private _sliderControl = uiNamespace getVariable "BLWK_musicManager_control_timelineSlider";
private _sliderMax = _sliderControl (sliderRange select 1);

if (_startTime isEqualTo 0) then {
	playMusic _musicClass;
} else {
	playMusic [_musicClass,_startTime];
};

while { 
	(uiNamespace getVariable ["BLWK_musicManager_doPlay",true]) AND 
	{sliderPosition _sliderControl < _sliderMax} AND
	{_musicClass == (uiNamespace getVariable "BLWK_musicManager_selectedTrack")}
} do {
	sleep 1;
 	_sliderControl sliderSetPosition ((sliderPosition _sliderControl) + 1);
};
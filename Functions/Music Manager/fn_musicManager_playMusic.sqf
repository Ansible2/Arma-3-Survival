if (!canSuspend) exitWith {
	"BLWK_fnc_musicManager_playMusic needs to be run in scheduled" call BIS_fnc_error;
};
#define INTERVAL 0.25

params [
	"_musicClass",
	["_startTime",0]
];

private _sliderControl = uiNamespace getVariable "BLWK_musicManager_control_timelineSlider";
private _sliderMax = (sliderRange _sliderControl) select 1;

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
	sleep INTERVAL;
 	_sliderControl sliderSetPosition ((sliderPosition _sliderControl) + INTERVAL);
};
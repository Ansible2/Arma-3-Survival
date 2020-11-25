params ["_control"];

_control sliderSetPosition (musicVolume);

_control ctrlAddEventHandler ["sliderPosChanged",{
	_this spawn {
		params ["_control", "_newValue"];
		0 fadeMusic _newValue;
	};
}];
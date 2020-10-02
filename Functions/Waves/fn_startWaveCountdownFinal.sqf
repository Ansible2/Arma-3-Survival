if (!hasInterface) exitWith {};

private _countDown = 15;
while {_countDown >= 0} do {
/*	
	if (_countDown isEqualTo 0) exitWith {
		playSound "Alarm";
	};
*/
	if (_countDown <= 10) then {
		playSound "beep_target";
	};

	null = [str _countDown, 0, 0, 1, 0] spawn BIS_fnc_dynamicText;
	
	sleep 1;
	_countDown = _countDown - 1;
};
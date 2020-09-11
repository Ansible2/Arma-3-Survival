if (BLWK_hitPointsShown) exitWith {

};

{
	_pos    = _x select 0;
	_label  = _x select 1;
	_unit   = _x select 2;
	_age    = _x select 3;
	_active = _x select 4;
	_colour = _x select 5;

	if(_active) then {
		_x set [3, _age + 1];

		_alpha = 1;
		_scale = 0;
		if(_age > 0 && _age <= 10) then {
			_scale = 0.035 * _age / 10;
		};
		if(_age > 10) then {
			_scale = 0.035;
		};
		if(_age > 30 && _age <= 40) then {
			_alpha = 1 - ((_age - 40) / 10);
		};
		_textPos = _pos vectorAdd [0, 0, 1 +_age / 100];

		if(_age > 40) then {_x set [4, false];};
		drawIcon3D ["", [_colour select 0, _colour select 1, _colour select 2, _alpha], _textPos, 1, 1, 0, format ["%1", _label], 0, _scale, "RobotoCondensed", "center", false];
	};
} foreach hitMarkers;
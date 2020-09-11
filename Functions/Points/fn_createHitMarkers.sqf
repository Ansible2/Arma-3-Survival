

{
	_pos    = _x select 0;
	_label  = _x select 1;
	_unit   = _x select 2;
	_age    = _x select 3;
	_active = _x select 4;
	_colour = _x select 5;


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

} foreach hitMarkers;

if (!BLWK_showHitPoints) exitWith {};

params [
	["_hitUnit",objNull,[objNull]],
	["_pointsToDisplay",0,[123]]
];

// RGBA format
#define ICON_COLOR [1, 0.1, 0.1]
#define ICON_ALPHA_START 1
#define START_FRAME 0

private _handleNumber = addMissionEventHandler ["EachFrame", {

	private _globalVarString = "BLWK_hitPointHandleInfo_" + (str _thisEventHandler);	
	if (!isNil _globalVarString) exitWith {
		private _iconInfo = missionNamespace getVariable _globalVarString;
		_iconInfo params [
			"_frameNo",
			"_pointsToDisplayString",
			"_color",
			"_alpha",
			"_textPosition"
			["_textSize",0],
		];
		_color pushBack _alpha;
		drawIcon3D ["",_color, _textPosition, 1, 1, 0,_pointsToDisplayString, 0, _textSize, "RobotoCondensed", "center", false];
		_frameNo = _frameNo + 1;
		_alpha

		
		_iconInfo set [0,_frameNo];
		_iconInfo set [3,_alpha];
		_iconInfo set [4,_textPosition];
		_iconInfo set [5,_textSize];
	};

}];

private _globalVarString = "BLWK_hitPointHandleInfo_" + (str _handleNumber);
private _textPositionStart = getPosATLVisual _hitUnit;
missionNamespace setVariable [_globalVarString,[START_FRAME,str _pointsToDisplay,ICON_COLOR,ICON_ALPHA_START,_textPositionStart,_textSize]];
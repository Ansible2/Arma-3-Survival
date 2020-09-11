/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createHitMarker

Description:
	Spawns the points to show when a unit is hit

	Executed from ""

Parameters:
	0: _hitUnit : <OBJECT> - The unit that number will display off of
	1: _pointsToDisplay : <NUMBER> - The number of points to display

Returns:
	NOTHING

Examples:
    (begin example)

		// draw a 100 point hit marker
		[hitUnit,100] call BLWK_fnc_createHitMarker;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!BLWK_showHitPoints) exitWith {};

params [
	["_hitUnit",objNull,[objNull]],
	["_pointsToDisplay",0,[123]]
];

// RGB format
#define ICON_COLOR [1, 0.1, 0.1]
#define ICON_ALPHA_START 1
#define START_FRAME 0
#define TEXT_SIZE_BASE 0.0035

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
		
		// kill event handler if it's been 40 frames
		if (_alpha isEqualTo 0) exitWith {
			removeMissionEventHandler ["EachFrame",_thisEventHandler];
		};
		_frameNo = _frameNo + 1;

		_color pushBack _alpha;
		drawIcon3D ["",_color, _textPosition, 1, 1, 0,_pointsToDisplayString, 0, _textSize, "RobotoCondensed", "center", false];
		
		// increases the text up to 0.035
		if (_frameNo > 0 AND {_frameNo <= 10}) then {
			_textSize = TEXT_SIZE_BASE * _frameNo;
		};
		// fade the icon out by eventually setting it's alpha to 0;
		if (_frameNo > 30 AND {_frameNo <= 40}) then {
			_alpha = _alpha - 0.1;
		};
		_textPosition = _textPosition vectorAdd [0,0,_frameNo/100]
		
		_iconInfo set [0,_frameNo];
		_iconInfo set [3,_alpha];
		_iconInfo set [4,_textPosition];
		_iconInfo set [5,_textSize];
	};

}];

// setup a unique global variable so we can pass params to the eventhandler
private _globalVarString = "BLWK_hitPointHandleInfo_" + (str _handleNumber);
private _textPositionStart = getPosATLVisual _hitUnit;
missionNamespace setVariable [_globalVarString,[START_FRAME,str _pointsToDisplay,ICON_COLOR,ICON_ALPHA_START,_textPositionStart,_textSize]];
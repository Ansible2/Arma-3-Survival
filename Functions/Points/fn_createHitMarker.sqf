/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createHitMarker

Description:
	Spawns the points animation when a unit is hit or killed

Parameters:
	0: _hitUnit : <OBJECT> - The unit that number will display off of
	1: _pointsToDisplay : <NUMBER> - The number of points to display
	2: _redPoints : <BOOL> - To show red points for kill

Returns:
	NOTHING

Examples:
    (begin example)

		// draw a 100 point hit marker
		[hitUnit,100] call BLWK_fnc_createHitMarker;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
//#define PLAYER_FOV_SCALE (getObjectFOV player / (getResolution select 6))
#define TEXT_SIZE_CONSTANT 0.0025
// this is used to try and get numbers to not crowd together so much
#define RANOM_NUMBER_SPACING_BASE random [-1.35,0,1.35]
#define DISTANCE_MULTIPLIER 0.025

if (!BLWK_showHitPoints) exitWith {};

params [ 
	["_hitUnit",objNull,[objNull]], 
	["_pointsToDisplay",123,[123]],
	["_redPoints",false,[true]] 
]; 


private _handleNumber = addMissionEventHandler ["EachFrame", { 

	private _globalVarString = "BLWK_hitPointHandleInfo_" + (str _thisEventHandler);  
	if (!isNil _globalVarString) then { 

		private _iconInfo = missionNamespace getVariable _globalVarString; 
		_iconInfo params [ 
			"_frameNo", 
			"_pointsToDisplayString", 
			"_color", 
			"_alpha", 
			"_textPosition",
			"_textSize"
		]; 

		// kill event handler if it's been 110 frames
		if (_frameNo isEqualTo 111) exitWith {
			// clear global
			missionNamespace setVariable [_globalVarString,nil]; 
			removeMissionEventHandler ["EachFrame",_thisEventHandler]; 
		}; 
		_frameNo = _frameNo + 1; 
		
		drawIcon3D ["",_color, _textPosition, 1, 1, 0,_pointsToDisplayString, 0, _textSize, "RobotoCondensed", "center", false]; 

		// controls max text size
		if (_frameNo > 0 AND {_frameNo <= 15}) then { 
			_textSize = TEXT_SIZE_CONSTANT * _frameNo;
		}; 
		// fade the icon out by eventually setting it's alpha to 0; 
		if (_frameNo > 100 AND {_frameNo <= 110}) then { 
			_alpha = _alpha - 0.1; 
		}; 

		// update global var for use in next frame 
		_textPosition = _textPosition vectorAdd [0,0,_frameNo/15000]; 
		_iconInfo set [0,_frameNo]; 
		_color set [3,_alpha];
		_iconInfo set [2,_color]; 
		_iconInfo set [4,_textPosition]; 
		_iconInfo set [5,_textSize]; 
		_iconInfo set [6,_leftOrRight]; 

		missionNamespace setVariable [_globalVarString,_iconInfo]; 
	}; 

}]; 

// setup a unique global variable so we can pass params to the eventhandler 
private _globalVarString = "BLWK_hitPointHandleInfo_" + (str _handleNumber);

private _distanceToShooter = _hitUnit distance player;
private _randomStartPosition = RANOM_NUMBER_SPACING_BASE;
if (_distanceToShooter > 10) then {
	_randomStartPosition = _randomStartPosition * (_distanceToShooter * DISTANCE_MULTIPLIER);
};

private _textPositionStart = (getPosATLVisual _hitUnit) vectorAdd [_randomStartPosition,_randomStartPosition,1.25];

// If minus, show points as red, else show as green
private _color = [[0.1,1,0,1],[1,0.1,0.1,1]] select _redPoints;
missionNamespace setVariable [_globalVarString,[0,str _pointsToDisplay, _color, 1,_textPositionStart,TEXT_SIZE_CONSTANT]];
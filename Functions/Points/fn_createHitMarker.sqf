/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createHitMarker

Description:
	Spawns the points to show when a unit is hit

Parameters:
	0: _hitUnit : <OBJECT> - The unit that number will display off of
	1: _pointsToDisplay : <NUMBER> - The number of points to display
	2: _minusPoints : <BOOL> - Is this subtracting points

Returns:
	NOTHING

Examples:
    (begin example)

		// draw a 100 point hit marker
		[hitUnit,100] call BLWK_fnc_createHitMarker;

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!BLWK_showHitPoints) exitWith {};

params [ 
	["_hitUnit",objNull,[objNull]], 
	["_pointsToDisplay",100,[123]],
	["_minusPoints",false,[true]] 
]; 


private _handleNumber = addMissionEventHandler ["EachFrame", { 

	private _globalVarString = "BLWK_hitPointHandleInfo_" + (str _thisEventHandler);  
	if (!isNil _globalVarString) exitWith { 

		private _iconInfo = missionNamespace getVariable _globalVarString; 
		_iconInfo params [ 
			"_frameNo", 
			"_pointsToDisplayString", 
			"_color", 
			"_alpha", 
			"_textPosition",
			"_textSize" 
		]; 

		// kill event handler if it's been 40 frames 
		if (_frameNo isEqualTo 71) exitWith { 
			removeMissionEventHandler ["EachFrame",_thisEventHandler]; 
		}; 
		_frameNo = _frameNo + 1; 
		
		drawIcon3D ["",_color, _textPosition, 1, 1, 0,_pointsToDisplayString, 0, _textSize, "RobotoCondensed", "center", false]; 

		// increases the text up to 0.035 
		if (_frameNo > 0 AND {_frameNo <= 10}) then { 
			_textSize = 0.0035 * _frameNo; 
		}; 
		// fade the icon out by eventually setting it's alpha to 0; 
		if (_frameNo > 60 AND {_frameNo <= 70}) then { 
			_alpha = _alpha - 0.1; 
		}; 

		// update global var for use in next frame 
		_textPosition = _textPosition vectorAdd [0,0,_frameNo/500]; 
		_iconInfo set [0,_frameNo]; 
		_color set [3,_alpha];
		_iconInfo set [2,_color]; 
		_iconInfo set [4,_textPosition]; 
		_iconInfo set [5,_textSize]; 

		missionNamespace setVariable [_globalVarString,_iconInfo]; 
	}; 

}]; 
 
// setup a unique global variable so we can pass params to the eventhandler 
private _globalVarString = "BLWK_hitPointHandleInfo_" + (str _handleNumber); 
private _textPositionStart = getPosATLVisual _hitUnit;

// If minus, show points as red, else show as green
private _color = [[0.1,1,0,1],[1,0.1,0.1,1]] select _minusPoints;
missionNamespace setVariable [_globalVarString,[0,str _pointsToDisplay, _color, 1,_textPositionStart,0.0035]];
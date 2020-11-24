params ["_control"];

// cache and/or get music info for list

// get classes
private "_musicClasses";
if (isNil {uiNamespace getVariable "BLWK_musicManager_allMusicClasses"}) then {		
	_musicClasses = "true" configClasses (configFile >> "cfgMusic");

	if (isClass (missionConfigFile >> "cfgMusic")) then {
		private _missionMusicClasses = "true" configClasses (missionConfigFile >> "cfgMusic");
		_musicClasses append _missionMusicClasses;
	};
	uiNamespace setVariable ["BLWK_musicManager_allMusicClasses",_musicClasses];
} else {
	_musicClasses = uiNamespace getVariable "BLWK_musicManager_allMusicClasses";
};


// music display names
private _musicNames = [];
if (isNil {uiNamespace getVariable "BLWK_musicManager_allMusicNames"}) then {
	private "_name_temp";
	_musicClasses apply {
		_name_temp = getText(_x >> "name");
		if (_name_temp isEqualTo "") then {
			_name_temp = configName _x;
		};
		_musicNames pushBack _name_temp;
	};
	uiNamespace setVariable ["BLWK_musicManager_allMusicNames",_musicNames];
} else {
	_musicNames = uiNamespace getVariable "BLWK_musicManager_allMusicNames";
};


// track durations
private _musicDurations = [];
if (isNil {uiNamespace getVariable "BLWK_musicManager_allMusicDurations"}) then {
	private "_duration_temp";
	_musicClasses apply {
		_duration_temp = round ([_x >> "duration"] call BIS_fnc_getCfgData);
		_musicDurations pushBack _duration_temp;
	};
	uiNamespace setVariable ["BLWK_musicManager_allMusicDurations",_musicDurations];
} else {
	_musicDurations = uiNamespace getVariable "BLWK_musicManager_allMusicDurations";
};


// fill list
private "_row";
private _durationColumn = _control lnbAddColumn 1;
_control lnbSetColumnsPos [0,0.82];
{
	_control lnbAddRow [_musicNames select _forEachIndex,str (_musicDurations select _forEachIndex)];
} forEach _musicClasses;

_control lnbSort [0,false];

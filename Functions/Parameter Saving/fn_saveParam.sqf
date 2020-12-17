params [
	["_missionParamName",""]
];

if (_missionParamName == "") exitWith {
	"Mission param name is empty string" call BIS_fnc_error;
};

private _saveIndex = [_missionParamName] call BLWK_fnc_getSavedParamIndex;
private _missionParameterArray = profileNamespace getVariable ["BLWK_savedMissionParameters",[]];
private _paramValue = missionNamespace getVariable _missionParamName;

if (_saveIndex isEqualTo -1) then { // if param not found
	_missionParameterArray pushBack [_missionParamName,_paramValue]
} else {// if param found
	_missionParameterArray set [_saveIndex,[_missionParamName,_paramValue]]
};
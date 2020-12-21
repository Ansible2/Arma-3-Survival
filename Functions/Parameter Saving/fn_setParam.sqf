if !(isServer) exitWith {};

params [
	["_missionParamName",""]
];

if (_missionParamName == "") exitWith {
	"Mission param name is empty string" call BIS_fnc_error;
};

private _saveIndex = [_missionParamName] call BLWK_fnc_getSavedParamIndex;
private _missionParameterArray = profileNamespace getVariable ["BLWK_savedMissionParameters",[]];
private _paramValue = _missionParamName call BIS_fnc_getParamValue;

if (_saveIndex isEqualTo -1) then { // if param not found
	_missionParameterArray pushBack [_missionParamName,_paramValue]
} else {// if param found
	_missionParameterArray set [_saveIndex,[_missionParamName,_paramValue]]
};

// this is required
profileNamespace setVariable ["BLWK_savedMissionParameters",_missionParameterArray];
params [
	["_missionParamName",""],
	["_defaultValue",0,[123]]
];

private _index = [_missionParamName] call BLWK_fnc_getSavedParamIndex;

// exit if param not found
if (_index isEqualTo -1) exitWith {_defaultValue}

private _paramArray = _missionParameterArray select _index;

private _savedParamValue = _paramArray select 1;


_savedParamValue
params [
	["_missionParamName",""]
];

private _missionParameterArray = profileNamespace getVariable ["BLWK_savedMissionParameters",[]];

// exit if no params saved
if (_missionParameterArray isEqualTo []) exitWith {-1};

private _index = _missionParameterArray findIf {
	(_x select 0) == _missionParamName
};

_index
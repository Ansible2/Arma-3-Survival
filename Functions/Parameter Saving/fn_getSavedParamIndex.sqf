/* ----------------------------------------------------------------------------
Function: BLWK_fnc_getSavedParamIndex

Description:
	Gets the array index in the "BLWK_savedMissionParameters" array inside
	 of the profileNamespace.

Parameters:
	0: _missionParamName <STRING> - The name of the saved parameter

Returns:
	<NUMBER> - The index inside BLWK_savedMissionParameters, -1 if does not exist

Examples:
    (begin example)

		_indexInArray = ["myParameterName"] call BLWK_fnc_getSavedParamIndex;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
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
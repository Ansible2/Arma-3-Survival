/* ----------------------------------------------------------------------------
Function: BLWK_fnc_getSavedParamValue

Description:
	Gets the saved value inside of the "BLWK_savedMissionParameters" inside the
	 profileNamespace. 
	Returns a default value if the parameter does not exist.

Parameters:
	0: _missionParamName <STRING> - The name of the saved parameter
	1: _defaultValue <NUMBER> - The default numerical value in of the saved parameter
		if the parameter is found to not exist

Returns:
	<NUMBER> - The index inside BLWK_savedMissionParameters, -1 if does not exist

Examples:
    (begin example)

		_savedValue = ["myParameterName"] call BLWK_fnc_getSavedParamValue;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_missionParamName",""],
	["_defaultValue",0,[123]]
];

private _index = [_missionParamName] call BLWK_fnc_getSavedParamIndex;

// exit if param not found
if (_index isEqualTo -1) exitWith {_defaultValue};

private _paramArray = _missionParameterArray select _index;

private _savedParamValue = _paramArray select 1;


_savedParamValue
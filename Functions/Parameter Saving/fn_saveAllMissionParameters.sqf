/* ----------------------------------------------------------------------------
Function: BLWK_fnc_saveAllMissionParameters

Description:
	Saves all mission parameters to the profileNamespace in "BLWK_savedMissionParameters"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		remoteExecCall ["BLWK_fnc_saveAllMissionParameters",2];
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};

private _paramClasses = "true" configClasses (missionConfigFile >> "Params");

private ["_configName","_paramValue"];
private _paramHash = createHashMap;
_paramClasses apply {
	_configName = configName _x;

	// check to see if they are just the header or space entries for readability
	if (!("SPACE" in _configName) AND {!("LABEL" in _configName)}) then {
		_paramValue = _configName call BIS_fnc_getParamValue;
		_paramHash set [_configName,_paramValue];
	};
};

profileNamespace setVariable ["BLWK_savedMissionParameters",_paramHash];
saveProfileNamespace;

["Mission parameters saved"] remoteExecCall ["hint",remoteExecutedOwner];
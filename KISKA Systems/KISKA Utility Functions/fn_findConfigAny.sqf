/* ----------------------------------------------------------------------------
Function: KISKA_fnc_findConfigAny

Description:
	Searchs missionConfigFile, campaignConfigFile, and the configFile
	 (in that order) to find a config based upon the sub paths provided.
	
	Reutrns the first one it finds.

	The BIS counterpart to this is BIS_fnc_loadClass and while it can be about 0.0005-0.0010ms
	 faster if the path is short (about 2 entries). It can yield about 0.005ms faster in various cases

Parameters:
	0: _pathArray : <ARRAY> - The array in string format

Returns:
	<CONFIG> - The first config path if found or configNull if not

Examples:
    (begin example)
		[["CfgMusic","Music_Intro_02_MissionStart"]] call KISKA_fnc_findConfigAny;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_findConfigAny";

params [
	["_pathArray",[],[[]]]
];

if (_pathArray isEqualTo []) exitWith {
	["_pathArray is empty array!",true] call KISKA_fnc_log;
};

private "_config_temp";
private _configFound = false;
private _configReturn = configNull;
[missionConfigFile,campaignConfigFile,configFile] apply {
	_config_temp = _x;
	_pathArray apply {
		// stop going down the list if config does not exist
		if !(isClass(_config_temp >> _x)) exitWith {
			_configFound = false;
		};
		_config_temp = _config_temp >> _x;
		_configFound = true;
	};
	
	if (_configFound) exitWith {
		_configReturn = _config_temp;
	};
};


_configReturn
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_findConfigAny

Description:
	Searchs configFile, missionConfigFile, and the campaignConfigFile
	 (in that order) to find a config based upon the sub paths provided.
	
	Reutrns the first one it finds.

Parameters:
	0: _pathArray : <ARRAY> - The global array in string format

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
	"_pathArray is empty array!" call BIS_fnc_error;
};

private "_config_temp";
private _configFound = false;
private _configReturn = configNull;
[configFile,missionConfigFile,campaignConfigFile] apply {
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

// alt method, slightly slower (0.010s about) when _pathArray gets longer
/*
	private _newArray = [];
	["musicManagerDialog","controls","musicManagerDialogcomboBox_trackSpacing","ComboScrollBar"] apply {
	_newArray pushBack (str _x)
	};

	private _string = _newArray joinString ">>";

	private _stringNew = ["configFile >>",_string] joinString "";
	_config = call compile _stringNew;
	if (isClass _config) exitWith {_config};

	_stringNew = ["missionConfigFile >>",_string] joinString "";
	_config = call compile _stringNew;
	if (isClass _config) exitWith {_config};

	_stringNew = ["campaignConfigFile >>",_string] joinString "";
	_config = call compile _stringNew;
	if (isClass _config) exitWith {_config};

	configNull
*/
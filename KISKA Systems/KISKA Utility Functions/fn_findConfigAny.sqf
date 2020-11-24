params [
	["_pathArray",[],[]]
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
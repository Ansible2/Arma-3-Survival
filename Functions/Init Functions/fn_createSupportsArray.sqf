/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createSupportsArray

Description:
	Creates an array in the format of BLWK_supports_array from a config.

Parameters:
	0: _configClass : <STRING> - The parent class of all the items to convert

Returns:
	ARRAY - all the classes formatted into an array

Examples:
    (begin example)

		BLWK_supports_array = ["BLWK_supportItems"] call BLWK_fnc_createSupportsArray;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_configClass","",[""]]
];

if (_configClass isEqualTo "") exitWith {
	"_configClass is undefined string" call BIS_fnc_error;
};

private _configs = call {
	if (isClass (configFile >> _configClass)) exitWith {
		"true" configClasses (configFile >> _configClass)
	};
	if (isClass (missionConfigFile >> _configClass)) exitWith {
		"true" configClasses (missionConfigFile >> _configClass)
	};

	[]
};

if (_configs isEqualTo []) exitWith {
	["%1 classes not found in mission or main config",_configClass] call BIS_fnc_error;
};

private _returnArray = [];
private [
	"_name_temp",
	"_price_temp",
	"_category_temp"
];
_configs apply {
	_name_temp configName _config;
	_price_temp = [_config >> "price"] call BIS_fnc_getCfgData;
	_category_temp = [_config >> "category"] call BIS_fnc_getCfgData;

	_returnArray pushBack [
		_name_temp,
		_price_temp,
		_category_temp
	];
};


_returnArray
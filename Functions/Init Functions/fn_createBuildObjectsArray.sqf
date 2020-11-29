/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createBuildObjectsArray

Description:
	Creates an array in the format of BLWK_buildableObjects_array from a config.

Parameters:
	0: _configToSearch : <CONFIG> - The config path you wish to search for build item data

Returns:
	ARRAY - all the classes formatted into an array

Examples:
    (begin example)

		BLWK_buildableObjects_array = [missionConfigFile >> "BLWK_buildableItems"] call BLWK_fnc_createBuildObjectsArray;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_configToSearch",configNull,[configNull]]
];

if (isNull _configToSearch) exitWith {
	"_configToSearch isNull" call BIS_fnc_error;
};

if !(isClass _configToSearch) exitWith {
	["_configToSearch %1 is not a class",_configToSearch] call BIS_fnc_error;
};

private _configs = "true" configClasses _configToSearch;

if (_configs isEqualTo []) exitWith {
	["No classes found in _configToSearch %1",_configToSearch] call BIS_fnc_error;
};

private _returnArray = [];
private [
	"_class_temp",
	"_price_temp",
	"_category_temp",
	"_hasAI_temp",
	"_rotation_temp",
	"_attachmentX_temp",
	"_attachmentY_temp",
	"_attachmentZ_temp",
	"_invincible_temp",
	"_keepInventory_temp"
];
_configs apply {
	_class_temp = configName _x;

	if (isClass (configFile >> "cfgVehicles" >> _class_temp)) then {
		_price_temp = [_x >> "price"] call BIS_fnc_getCfgData;
		_category_temp = [_x >> "category"] call BIS_fnc_getCfgData;
		_hasAI_temp = [_x >> "hasAI"] call BIS_fnc_getCfgDataBool;
		_rotation_temp = [_x >> "rotation"] call BIS_fnc_getCfgData;
		_attachmentX_temp = [_x >> "attachmentX"] call BIS_fnc_getCfgData;
		_attachmentY_temp = [_x >> "attachmentY"] call BIS_fnc_getCfgData;
		_attachmentZ_temp = [_x >> "attachmentZ"] call BIS_fnc_getCfgData;
		_invincible_temp = [_x >> "invincible"] call BIS_fnc_getCfgDataBool;
		_keepInventory_temp = [_x >> "keepInventory"] call BIS_fnc_getCfgDataBool;


		_returnArray pushBack [
			_price_temp,
			_class_temp,
			_category_temp,
			[_rotation_temp,[_attachmentX_temp,_attachmentY_temp,_attachmentZ_temp]],
			_hasAI_temp,
			_invincible_temp,
			_keepInventory_temp
		];
	};
};

_returnArray
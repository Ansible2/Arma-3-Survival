/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createBuildObjectsHash

Description:
	Creates a hash for looking up configed values for the buildable items.
	Used for faster look up times.

	Executed from "BLWK_fnc_prepareGlobals"

Parameters:
	0: _configToSearch : <CONFIG> - The config path you wish to search for build item data

Returns:
	HASHMAP - all the classes formatted into a hash

Examples:
    (begin example)

		BLWK_buildableObjectsHash = [missionConfigFile >> "BLWK_buildableItems"] call BLWK_fnc_createBuildObjectsHash;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "BLWK_fnc_createBuildObjectsHash"
scriptName SCRIPT_NAME;

params [
	["_configToSearch",configNull,[configNull]]
];

private _hash = createHashMap;

if (isNull _configToSearch) exitWith {
	["_configToSearch is null",true] call KISKA_fnc_log;
	_hash
};

if !(isClass _configToSearch) exitWith {
	[["The _configToSearch ",_configToSearch," does not exist. Exiting..."],true] call KISKA_fnc_log;
	_hash
};

private _configs = "true" configClasses _configToSearch;

if (_configs isEqualTo []) exitWith {
	[["The _configToSearch ",_configToSearch," does not have any classes. Exiting..."],true] call KISKA_fnc_log;
	_hash
};


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
	"_keepInventory_temp",
	"_detectCollision_temp",
	"_displayName_temp"
];
_configs apply {
	_class_temp = configName _x;

	if (isClass (configFile >> "cfgVehicles" >> _class_temp)) then {
		private _propertiesArray = [];

		// price
		_price_temp = [_x >> "price"] call BIS_fnc_getCfgData;
		_propertiesArray pushBack _price_temp;
		// shop category
		_category_temp = [_x >> "category"] call BIS_fnc_getCfgData;
		_propertiesArray pushBack _category_temp;
		// pickup default rotation
		_rotation_temp = [_x >> "rotation"] call BIS_fnc_getCfgData;
		_propertiesArray pushBack _rotation_temp;
		// pickup default attachment coordinates
		_attachmentX_temp = [_x >> "attachmentX"] call BIS_fnc_getCfgData;
		_attachmentY_temp = [_x >> "attachmentY"] call BIS_fnc_getCfgData;
		_attachmentZ_temp = [_x >> "attachmentZ"] call BIS_fnc_getCfgData;
		_propertiesArray pushBack [_attachmentX_temp,_attachmentY_temp,_attachmentZ_temp];
		// has AI
		_hasAI_temp = [_x >> "hasAI"] call BIS_fnc_getCfgDataBool;
		_propertiesArray pushBack _hasAI_temp;
		// indestructable
		_invincible_temp = [_x >> "invincible"] call BIS_fnc_getCfgDataBool;
		_propertiesArray pushBack _invincible_temp;
		// keep inventory
		_keepInventory_temp = [_x >> "keepInventory"] call BIS_fnc_getCfgDataBool;
		_propertiesArray pushBack _keepInventory_temp;
		// detect collision
		_detectCollision_temp = [_x >> "detectCollision"] call BIS_fnc_getCfgDataBool;
		_propertiesArray pushBack _detectCollision_temp;

		// displaynames
		// for handling custom display names of items
		_displayName_temp = getText(_x >> "displayName");
		if (_displayName_temp isEqualTo "") then {
			_displayName_temp = [configFile >> "cfgVehicles" >> _class_temp] call BIS_fnc_displayName;
		};
		_propertiesArray pushBack _displayName_temp;


		_hash set [toLowerANSI _class_temp,_propertiesArray];
	};
};


_hash
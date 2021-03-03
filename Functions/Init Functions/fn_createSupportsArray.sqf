/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createSupportsArray

Description:
	Creates an array in the format of BLWK_supports_array from a config.

Parameters:
	0: _configToSearch : <CONFIG> - The config path you wish to search for support data

Returns:
	ARRAY - all the classes formatted into an array

Examples:
    (begin example)

		BLWK_supports_array = [missionConfigFile >> "BLWK_supportItems"] call BLWK_fnc_createSupportsArray;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "BLWK_fnc_createSupportsArray"
scriptName SCRIPT_NAME;

params [
	["_configToSearch",configNull,[configNull]]
];

if (isNull _configToSearch) exitWith {
	["_configToSearch is null",true] call KISKA_fnc_log;
};

if !(isClass _configToSearch) exitWith {
	[["The _configToSearch ",_configToSearch," does not exist"],true] call KISKA_fnc_log;
};

private _configs = "true" configClasses _configToSearch;

if (_configs isEqualTo []) exitWith {
	[["The _configToSearch ",_configToSearch," does not have any classes"],true] call KISKA_fnc_log;
};

private _returnArray = [];
private [
	"_class_temp",
	"_price_temp",
	"_category_temp",
	"_patch_temp"
];
_configs apply {
	_patch_temp = [_x >> "patch"] call BIS_fnc_getCfgData;
	
	// check if the appropriate patch is loaded for the support
	if ((_patch_temp isEqualTo "") OR {[_patch_temp] call KISKA_fnc_isPatchLoaded}) then {
		_class_temp = configName _x;

		// if a support is tagged as a basclass, do not add it
		if !("_baseClass" in _class_temp) then {
			_price_temp = [_x >> "price"] call BIS_fnc_getCfgData;
			_category_temp = [_x >> "category"] call BIS_fnc_getCfgData;

			_returnArray pushBack [
				_price_temp,
				_class_temp,
				_category_temp
			];
		};
	};
};


_returnArray
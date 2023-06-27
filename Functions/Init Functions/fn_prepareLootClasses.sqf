/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareLootClasses

Description:
	Gets all the loot classes for spawning it during the mission and caches them.

	It is executed from the "BLWK_fnc_prepareGlobals".

Parameters:
    0: _currentWhitelist <STRING> - The whitelist mode currently
    1: _fallbackWhitelist <STRING> - The _currentWhitelist to fallback to 
		should the whitelist fail validation
	2: _whitelistParamConfig <CONFIG> - the config path to the parameter that controls the
		loot whitelist mode

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_prepareLootClasses
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_prepareLootClasses";

#define DEFAULT_CONFIFG missionConfigFile >> "KISKA_missionParams" >> "Loot" >> "_currentWhitelist"
#define DEFAULT_WHITELIST "ALL"

// This should run for headless and the server but not player clients
if ((!isServer) AND hasInterface) exitWith {};


params [
	["_currentWhitelist",DEFAULT_WHITELIST,[""]],
	["_fallbackWhitelist",DEFAULT_WHITELIST,[""]],
	["_whitelistParamConfig",DEFAULT_CONFIFG,[configNull]]
];

if (_currentWhitelist == _fallbackWhitelist) then {
	_fallbackWhitelist = DEFAULT_WHITELIST
};

/* ----------------------------------------------------------------------------

	Parse Master & Custom Lists

---------------------------------------------------------------------------- */
private _mainListConfig = missionConfigFile >> "BLWK_lootLists";
private _masterListConfig = _mainListConfig >> "MasterLootList";

private _fn_toLowerArray = {
	params ["_array"];

	_array apply {
		toLowerANSI _x
	};
};
/* ----------------------------------------------------------------------------
	Master Blacklist
---------------------------------------------------------------------------- */
BLWK_lootBlacklist = [];
private _masterBlacklist = getArray(_masterListConfig >> "lootBlackList");
if (_masterBlacklist isNotEqualTo []) then {
	BLWK_lootBlacklist = [_masterBlacklist] call _fn_toLowerArray;
};


/* ----------------------------------------------------------------------------
	Master Whitelists
---------------------------------------------------------------------------- */
private _primaryWeaponClasses = getArray(_masterListConfig >> "lootWhitelist_primaries");
private _handgunWeaponClasses = getArray(_masterListConfig >> "lootWhitelist_handguns");
private _launcherClasses = getArray(_masterListConfig >> "lootWhitelist_launchers");
private _backpackClasses = getArray(_masterListConfig >> "lootWhitelist_backpacks");
private _vestClasses = getArray(_masterListConfig >> "lootWhitelist_vests");
private _uniformClasses = getArray(_masterListConfig >> "lootWhitelist_uniforms");
private _headgearClasses = getArray(_masterListConfig >> "lootWhitelist_headgear");
private _itemClasses = getArray(_masterListConfig >> "lootWhitelist_items");
private _explosiveClasses = getArray(_masterListConfig >> "lootWhitelist_explosives");




private _customLootListConfig = configNull;
private _lootCondition_weapons = { true };
private _lootCondition_clothes = { true };
private _lootCondition_magazines = { true };
private _checkForDuplicates = false;
// if whitelist is Not set to off

private _exitToFallback = false;
if (_currentWhitelist != DEFAULT_WHITELIST) then {
	private _lootListNames = call BLWK_fnc_KISKAParams_populateLootWhitelists;
	private _indexOfList = _lootListNames find _currentWhitelist;
	private _customListNotFound = _indexOfList isEqualTo -1;
	if (_customListNotFound) exitWith { _exitToFallback = true };

	_customLootListConfig = (localNamespace getVariable "BLWK_lootListConfigs") select _indexOfList;
	private _patches = getArray(_customLootListConfig >> "patches");
	private _hasPatches = _patches isNotEqualTo [];
	if (_hasPatches) then {
		// find false entry e.g. not loaded patch
		private _notLoadedIndex = _patches findIf { !([_x] call KISKA_fnc_isPatchLoaded) };
		private _missingPatch = _notLoadedIndex isNotEqualTo -1;
		if (_missingPatch) then {
			private _patchName = _patches select _notLoadedIndex;
			[["Found that patch ",_patchName," was not loaded for loot list. Fallback list will be used..."],true] call KISKA_fnc_log;		
			_exitToFallback = true;
		};
	};


	if (_exitToFallback) exitWith {};


	_checkForDuplicates = [_customLootListConfig >> "checkForDuplicates"] call BIS_fnc_getCfgDataBool;

	[
		[_primaryWeaponClasses,"lootWhitelist_primaries"],
		[_handgunWeaponClasses,"lootWhitelist_handguns"],
		[_launcherClasses,"lootWhitelist_launchers"],
		[_backpackClasses,"lootWhitelist_backpacks"],
		[_vestClasses,"lootWhitelist_vests"],
		[_uniformClasses,"lootWhitelist_uniforms"],
		[_headgearClasses,"lootWhitelist_headgear"],
		[_itemClasses,"lootWhitelist_items"],
		[_explosiveClasses,"lootWhitelist_explosives"],
		[BLWK_lootBlacklist,"lootBlackList"]
	] apply {
		_x params ["_arrayToAppend","_configName"];
		_arrayToAppend append (getArray(_customLootListConfig >> _configName));
	};

	private _conditionWeapons = getText(_customLootListConfig >> "conditionWeapons");
	if (_conditionWeapons isNotEqualTo "") then {
		_lootCondition_weapons = compileFinal _conditionWeapons;
	};

	private _conditionClothes = getText(_customLootListConfig >> "conditionClothes");
	if (_conditionClothes isNotEqualTo "") then {
		_lootCondition_clothes = compileFinal _conditionClothes;
	};

	private _conditionMagazines = getText(_customLootListConfig >> "conditionMagazines");
	if (_conditionMagazines isNotEqualTo "") then {
		_lootCondition_magazines = compileFinal _conditionMagazines;
	};
};


private _fn_exitToFallBack = {
	params [
		["_logMessage",""]
	];

	if (_logMessage isNotEqualTo "") then {
		[
			[
				_errorMessage,": ",
				_currentWhitelist,
				", changing to fall back list: ",
				_fallbackWhitelist
			],
			true
		] call KISKA_fnc_log;
	};

	[
		[
			"There was an error changing to loot list: ",
			_currentWhitelist,
			". Changing to fallback list: ",
			_fallbackWhitelist
		] joinString "",
		8
	] remoteExec ["KISKA_fnc_errorNotification",0];

	if (isServer) then {
		private _serialConfig = [_whitelistParamConfig] call KISKA_fnc_paramsMenu_serializeConfig;
		[_serialConfig,_fallbackWhitelist] call KISKA_fnc_paramsMenu_paramChangedRemote;
	};

	[_fallbackWhitelist] spawn {
		params ["_fallbackWhitelist"];
		waitUntil {
			sleep 1;
			missionNamespace getVariable ["_currentWhitelist","ALL"] == _fallbackWhitelist;
		};
		call BLWK_fnc_prepareLootClasses;
	};
};

if (_exitToFallback) exitWith _fn_exitToFallBack;


/* ----------------------------------------------------------------------------

	Functions

---------------------------------------------------------------------------- */
private _fn_pushBackTempClass = {
	if (_checkForDuplicates) then {
		(_this select 0) pushBackUnique _tempClass;
	} else {
		(_this select 0) pushBack _tempClass;
	};
};


// some of this is setup with the intention that things may be further broken down into more categories
// this is why the functions are here that just pushBack something
private _tempClass = "";
private _tempItemInfo = [];
private _tempItemCategory = "";
private _tempItemType = "";


// sort through clothes, vests, backpacks, headgear
private _fn_sortEquipment = {
	if (_tempItemType == "headgear") exitWith {[_headgearClasses] call _fn_pushBackTempClass};
	if (_tempItemType == "vest") exitWith {[_vestClasses] call _fn_pushBackTempClass};
	if (_tempItemType == "Uniform") exitWith {[_uniformClasses] call _fn_pushBackTempClass};
	if (_tempItemType == "Backpack") exitWith {[_backpackClasses] call _fn_pushBackTempClass};
};


private _fn_sortWeapons = {
	// if no mags are present in weapon config
	if ((getArray (configFile >> "CfgWeapons" >> _tempClass >> "magazines")) isEqualTo []) exitWith {};

	if (_tempItemType == "Handgun") exitWith {
		[_handgunWeaponClasses] call _fn_pushBackTempClass
	};

	if (
		_tempItemType == "MissileLauncher" OR
		{_tempItemType == "Launcher"} OR
		{_tempItemType == "RocketLauncher"}
	) exitWith {
		[_launcherClasses] call _fn_pushBackTempClass
	};

	if (_tempItemType == "AssaultRifle" OR
		{_tempItemType == "MachineGun"} OR
		{_tempItemType == "Shotgun"} OR
		{_tempItemType == "Rifle"} OR
		{_tempItemType == "SubmachineGun"} OR
		{_tempItemType == "SniperRifle"}
	) exitWith {
		[_primaryWeaponClasses] call _fn_pushBackTempClass
	};
};

private _fn_sortMagazines = {
	/*
		All we care about getting is the things like grenades.
		This is because the magazines spawned in BLWK_fnc_spawnLoot are taken directly
		 from the weapon classes available so that, for instance, no mags for a blacklisted gun spawn.
	*/
	if ((toLowerANSI _tempItemType) in ["grenade","flare"]) exitWith {
		[_explosiveClasses] call _fn_pushBackTempClass;
	};
};


private _fn_sortType = {
	// get the class name of the item and check if it is in the blacklist
	if (_tempClass in BLWK_lootBlacklist) exitWith {};

	_tempItemInfo = [_tempClass] call BIS_fnc_itemType;
	_tempItemCategory = _tempItemInfo select 0;
	_tempItemType = _tempItemInfo select 1;

	if (_tempItemCategory == "weapon") exitWith {call _fn_sortWeapons};
	if (_tempItemCategory == "magazine") exitWith {call _fn_sortMagazines};
	if (_tempItemCategory == "equipment") exitWith {call _fn_sortEquipment};
	if (_tempItemCategory == "item") exitWith {
		[_itemClasses] call _fn_pushBackTempClass;
	};
	if (_tempItemCategory == "mine") exitWith {
		[_explosiveClasses] call _fn_pushBackTempClass;
	};

};


/* ----------------------------------------------------------------------------

	Execution

---------------------------------------------------------------------------- */
_primaryWeaponClasses = [_primaryWeaponClasses] call _fn_toLowerArray;
_handgunWeaponClasses = [_handgunWeaponClasses] call _fn_toLowerArray;
_launcherClasses = [_launcherClasses] call _fn_toLowerArray;
_backpackClasses = [_backpackClasses] call _fn_toLowerArray;
_vestClasses = [_vestClasses] call _fn_toLowerArray;
_uniformClasses = [_uniformClasses] call _fn_toLowerArray;
_headgearClasses = [_headgearClasses] call _fn_toLowerArray;
_itemClasses = [_itemClasses] call _fn_toLowerArray;
_explosiveClasses = [_explosiveClasses] call _fn_toLowerArray;


[
	[configFile >> "CfgWeapons",_lootCondition_weapons],
	[configFile >> "CfgVehicles",_lootCondition_clothes],
	[configFile >> "CfgMagazines",_lootCondition_magazines]
] apply {
	_x params ["_config","_conditionToAdd"];

	private _publicConfigs = "getNumber (_x >> 'scope') isEqualTo 2" configClasses _config;
	_publicConfigs apply {
		_tempClass = configName _x;
		if ([_tempClass,_config] call _conditionToAdd) then {
			call _fn_sortType;
		};
	};
};

private _preparedTypeArrays = [
	_primaryWeaponClasses,
	_handgunWeaponClasses,
	_launcherClasses,
	_backpackClasses,
	_vestClasses,
	_uniformClasses,
	_headgearClasses,
	_itemClasses,
	_explosiveClasses
];

private _emptyIndex = _preparedTypeArrays find [];



if (_errorMessage isNotEqualTo "") exitWith {
	private _errorMessage = "";
	switch (_emptyIndex) do {
		case 0: {
			_errorMessage = "There are no weapon classes (handgun, primaries, and/or launchers) loaded in the current list";
		};
		case 1: {
			_errorMessage = "There are no backpack classes loaded in the current list";
		};
		case 2: {
			_errorMessage = "There are no vest classes loaded in the current list";
		};
		case 3: {
			_errorMessage = "There are no uniform classes loaded in the current list";
		};
		case 4: {
			_errorMessage = "There are no headgear classes loaded in the current list";
		};
		case 5: {
			_errorMessage = "There are no item classes loaded in the current list";
		};
		case 6: {
			_errorMessage = "There are no explosive classes loaded in the current list";
		};
	};

	[_errorMessage] call _fn_exitToFallBack;
};


// the headless client needs this for weapon randomization
BLWK_loot_weaponClasses = []; // for getting all weapons into the same pool for spawning loot
BLWK_loot_primaryWeapons = _primaryWeaponClasses; // the individual split ups are for use with BLWK_fnc_randomizeWeapons
BLWK_loot_weaponClasses append BLWK_loot_primaryWeapons;
BLWK_loot_handgunWeapons = _handgunWeaponClasses;
BLWK_loot_weaponClasses append BLWK_loot_handgunWeapons;
BLWK_loot_launchers = _launcherClasses;
BLWK_loot_weaponClasses append BLWK_loot_launchers;

BLWK_loot_backpackClasses = _backpackClasses;
BLWK_loot_vestClasses = _vestClasses;
BLWK_loot_uniformClasses = _uniformClasses;
BLWK_loot_headGearClasses = _headgearClasses;
BLWK_loot_itemClasses = _itemClasses;
BLWK_loot_explosiveClasses = _explosiveClasses;


nil

// set up MACRO vars that can be used between files and make changes easier
#include "..\..\Headers\descriptionEXT\Loot Lists\Define Loot Lists.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareLootClasses

Description:
	Gets all the loot classes for spawning it during the mission and caches them.

	It is executed from the "BLWK_fnc_prepareGlobals".

Parameters:
	NONE

Returns:
	ARRAY - Format [
		primary weapons,
		secondary weapons,
		launchers,
		backpacks,
		vests,
		uniforms,
		headgear,
		items,
		explosives
	]

Examples:
    (begin example)
		call BLWK_fnc_prepareLootClasses
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_prepareLootClasses";


if (!isServer AND {hasInterface}) exitWith {false};


/* ----------------------------------------------------------------------------

	Parse Master & Custom Lists

---------------------------------------------------------------------------- */
private _mainListConfig = missionConfigFile >> "BLWK_lootLists";
private _masterListConfig = _mainListConfig >> "masterList";

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
private _lootCondition_weapons = {true};
private _lootCondition_clothes = {true};
private _lootCondition_magazines = {true};
private _checkForDuplicates = false;
// if whitelist is Not set to off
if (BLWK_loot_whiteListMode isNotEqualTo 0) then {
	private _factionTitle = [LOOT_LIST_STRINGS] select BLWK_loot_whiteListMode;
	private _lootListConfigs = "true" configClasses (_mainListConfig >> "CustomLootLists");

	private _index = _lootListConfigs findIf {
		getText(_x >> "title") == _factionTitle
	};

	if (_index isNotEqualTo -1) then {
		_customLootListConfig = _lootListConfigs select _index;
		[[_customLootListConfig],false] call KISKA_fnc_log;

		private _useCustomList = true;
		private _patches = getArray(_customLootListConfig >> "patches");
		if (_patches isNotEqualTo []) then {
			private _passArray = _patches apply {
				[_x] call KISKA_fnc_isPatchLoaded
			};

			private _nonPassIndex = _passArray find false;
			private _nonPassPatch = "";
			if (_nonPassIndex isNotEqualTo -1) then {
				_nonPassPatch = _patches select _nonPassIndex;
				[["Found that patch ",_nonPassPatch," was not loaded for loot list. Default list will be used"],true] call KISKA_fnc_log;
				_useCustomList = false;
			};
		};

		if !(_useCustomList) exitWith {};


		_checkForDuplicates = [_customLootListConfig >> "checkForDuplicates"] call BIS_fnc_getCfgDataBool;

		_primaryWeaponClasses append (getArray(_customLootListConfig >> "lootWhitelist_primaries"));
		_handgunWeaponClasses append (getArray(_customLootListConfig >> "lootWhitelist_handguns"));
		_launcherClasses append (getArray(_customLootListConfig >> "lootWhitelist_launchers"));
		_backpackClasses append (getArray(_customLootListConfig >> "lootWhitelist_backpacks"));
		_vestClasses append (getArray(_customLootListConfig >> "lootWhitelist_vests"));
		_uniformClasses append (getArray(_customLootListConfig >> "lootWhitelist_uniforms"));
		_headgearClasses append (getArray(_customLootListConfig >> "lootWhitelist_headgear"));
		_itemClasses append (getArray(_customLootListConfig >> "lootWhitelist_items"));
		_explosiveClasses append (getArray(_customLootListConfig >> "lootWhitelist_explosives"));
		BLWK_lootBlacklist append (getArray(_customLootListConfig >> "lootBlackList"));


		private _conditionWeapons = getText(_customLootListConfig >> "conditionWeapons");
		if (_conditionWeapons isNotEqualTo "") then {
			[_conditionWeapons,false] call KISKA_fnc_log;
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
};



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


private _weaponConfig = configFile >> "CfgWeapons";
private _publicWeaponConfigs = "getNumber (_x >> 'scope') isEqualTo 2" configClasses _weaponConfig;
_publicWeaponConfigs apply {
	_tempClass = configName _x;
	if ([_tempClass,_weaponConfig] call _lootCondition_weapons) then {
		call _fn_sortType;
	};
};


private _vehicleConfig = configFile >> "CfgVehicles";
// things such as vests and backpacks are located in CfgVehicles
private _publicVehicleConfigs = "getNumber (_x >> 'scope') isEqualTo 2" configClasses _vehicleConfig;
_publicVehicleConfigs apply {
	_tempClass = configName _x;
	if ([_tempClass,_vehicleConfig] call _lootCondition_clothes) then {
		call _fn_sortType;
	};
};


private _magazineConfig = configFile >> "CfgMagazines";
// for mags and throwable explosives
private _publicMagazineConfigs = "getNumber (_x >> 'scope') isEqualTo 2" configClasses _magazineConfig;
_publicMagazineConfigs apply {
	_tempClass = configName _x;
	if ([_tempClass,_magazineConfig] call _lootCondition_magazines) then {
		call _fn_sortType;
	};
};


[
	_primaryWeaponClasses,
	_handgunWeaponClasses,
	_launcherClasses,
	_backpackClasses,
	_vestClasses,
	_uniformClasses,
	_headgearClasses,
	_itemClasses,
	_explosiveClasses
]

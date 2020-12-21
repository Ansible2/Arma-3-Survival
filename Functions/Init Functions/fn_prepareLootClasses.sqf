/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareLootClasses

Description:
	Gets all the loot classes for spawning it during the mission and caches them.
	Also handles the exclusion of items for DLC.
	
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
if (!isServer AND {hasInterface}) exitWith {false};

// get white and black lists for loot
BLWK_lootBlacklist = [missionConfigFile >> "BLWK_lootLists" >> "lootBlacklist"] call BIS_fnc_getCfgDataArray;
private _whitelist_primaries = [missionConfigFile >> "BLWK_lootLists" >> "lootWhitelist_primaries"] call BIS_fnc_getCfgDataArray;
private _whitelist_handguns = [missionConfigFile >> "BLWK_lootLists" >> "lootWhitelist_handguns"] call BIS_fnc_getCfgDataArray;
private _whitelist_launchers = [missionConfigFile >> "BLWK_lootLists" >> "lootWhitelist_launchers"] call BIS_fnc_getCfgDataArray;	
private _whitelist_backpacks = [missionConfigFile >> "BLWK_lootLists" >> "lootWhitelist_backpacks"] call BIS_fnc_getCfgDataArray;
private _whitelist_vests = [missionConfigFile >> "BLWK_lootLists" >> "lootWhitelist_vests"] call BIS_fnc_getCfgDataArray;
private _whitelist_uniforms = [missionConfigFile >> "BLWK_lootLists" >> "lootWhitelist_uniforms"] call BIS_fnc_getCfgDataArray;
private _whitelist_headgear = [missionConfigFile >> "BLWK_lootLists" >> "lootWhitelist_headgear"] call BIS_fnc_getCfgDataArray;
private _whitelist_items = [missionConfigFile >> "BLWK_lootLists" >> "lootWhitelist_items"] call BIS_fnc_getCfgDataArray;
private _whitelist_explosives = [missionConfigFile >> "BLWK_lootLists" >> "lootWhitelist_explosives"] call BIS_fnc_getCfgDataArray;


// Check if we are in whitelisted items only mode
if (BLWK_loot_whiteListMode isEqualTo 1) exitWith {
	[
		_whitelist_primaries,
		_whitelist_handguns,
		_whitelist_launchers,
		_whitelist_backpacks,
		_whitelist_vests,
		_whitelist_uniforms,
		_whitelist_headgear,
		_whitelist_items,
		_whitelist_explosives
	]
};



/* ----------------------------------------------------------------------------

	Functions

---------------------------------------------------------------------------- */
// some of this is setup with the intention that things may be further broken down into more categories
// this is why the functions are here that just pushBack something
private _tempClass = "";
private _tempItemInfo = [];
private _tempItemCategory = "";
private _tempItemType = "";
private _dlcAllowedTemp = true;
private _dlcString = "";
private _configHierarchyTemp = "";

// sort through clothes, vests, backpacks, headgear
private _backpackClasses = [];
private _vestClasses = [];
private _uniformClasses = [];
private _headgearClasses = [];
private _fn_sortEquipment = {
	if (_tempItemType == "headgear") exitWith {_headgearClasses pushBack _tempClass};
	if (_tempItemType == "vest") exitWith {_vestClasses pushBack _tempClass};
	if (_tempItemType == "Uniform") exitWith {_uniformClasses pushBack _tempClass};
	if (_tempItemType == "Backpack") exitWith {_backpackClasses pushBack _tempClass};
};

private _handgunWeaponClasses = [];
private _primaryWeaponClasses = [];
private _launcherClasses = [];
private _fn_sortWeapons = {
	if ((getArray (configFile >> "CfgWeapons" >> _tempClass >> "magazines")) isEqualTo []) exitWith {};
	if (_tempItemType == "MissileLauncher" OR {_tempItemType == "Launcher"} OR {_tempItemType == "RocketLauncher"}) exitWith {_launcherClasses pushBack _tempClass};
	if (_tempItemType == "Handgun") exitWith {_handgunWeaponClasses pushBack _tempClass};
	
	if (_tempItemType == "AssaultRifle" OR 
		{_tempItemType == "MachineGun"} OR 
		{_tempItemType == "Shotgun"} OR 
		{_tempItemType == "Rifle"} OR 
		{_tempItemType == "SubmachineGun"} OR 
		{_tempItemType == "SniperRifle"}) exitWith {
		_primaryWeaponClasses pushBack _tempClass
	};
};

// nvgs, gps, medkit, toolkit, compass, etc.
private _itemClasses = [];
private _fn_sortItems = {
	_itemClasses pushBack _tempClass;
};

private _explosiveClasses = [];
private _fn_sortExplosives = {
	_explosiveClasses pushBack _tempClass;
};

private _fn_sortMagazines = {
	/*
		All we care about getting is the things like grenades.
		This is because the magazines spawned in BLWK_fnc_spawnLoot are taken directly
		 from the weapon classes available so that, for instance, no mags for a blacklisted gun spawn.
	*/
	if ((toLowerANSI _tempItemType) in ["grenade","flare"]) exitWith {call _fn_sortExplosives};
};

private _fn_sortType = {
	// get the class name of the item and check if it is in the blacklist
	_tempClass = configName (_this select 0);
	if (_tempClass in LOOT_BLACKLIST) exitWith {};

	// CIPHER COMMENT: DLC check is awaiting 2.0 release for getAssetDLCInfo command
	/*
		_configHierarchyTemp = _this select 1;
		_dlcAllowedTemp = [_tempClass,_configHierarchyTemp] call BLWK_fnc_checkDLC;
		if !(_dlcAllowedTemp) exitWith {};
	*/

	_tempItemInfo = [_tempClass] call BIS_fnc_itemType;

	_tempItemCategory = _tempItemInfo select 0;
	_tempItemType = _tempItemInfo select 1;

	// sort through item categories
	if (_tempItemCategory == "weapon") exitWith {call _fn_sortWeapons};
	if (_tempItemCategory == "item") exitWith {call _fn_sortItems};
	if (_tempItemCategory == "equipment") exitWith {call _fn_sortEquipment};
	if (_tempItemCategory == "mine") exitWith {call _fn_sortExplosives};
	if (_tempItemCategory == "magazine") exitWith {call _fn_sortMagazines};
};



/* ----------------------------------------------------------------------------

	Execution

---------------------------------------------------------------------------- */
private _publicWeaponConfigs = "getNumber (_x >> 'scope') isEqualTo 2" configClasses (configFile >> "CfgWeapons");
_publicWeaponConfigs apply {
	[_x,"CfgWeapons"] call _fn_sortType; // first we sort the item type
};
// things such as vests and backpacks are located in CfgVehicles
private _publicVehicleConfigs = "getNumber (_x >> 'scope') isEqualTo 2" configClasses (configFile >> "CfgVehicles");
_publicVehicleConfigs apply {
	[_x,"CfgVehicles"] call _fn_sortType;	
};
// for mags and throwable explosives
private _publicMagazineConfigs = "getNumber (_x >> 'scope') isEqualTo 2" configClasses (configFile >> "CfgMagazines");
_publicMagazineConfigs apply {
	[_x,"CfgMagazines"] call _fn_sortType;	
};


// check white list mode to see if we should add whitelisted items to arrays
if (BLWK_loot_whiteListMode isEqualTo 2) then {
    _backpackClasses append _whitelist_backpacks;
    _explosiveClasses append _whitelist_explosives;
    _itemClasses append _whitelist_items;
    _uniformClasses append _whitelist_uniforms;
    _vestClasses append _whitelist_vests;
	_headgearClasses append _whitelist_headgear;
	_primaryWeaponClasses append _whitelist_primaries;
	_handgunWeaponClasses append _whitelist_handguns;
	_launcherClasses append _whitelist_launchers;
};

// return
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
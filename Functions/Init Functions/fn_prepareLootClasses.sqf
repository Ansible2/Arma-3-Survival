/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareLootClasses

Description:
	Gets all the loot classes for spawning it during the mission and caches them.
	Also handles the exclusion of items for DLC.
	
	It is executed from the "BLWK_fnc_prepareGlobals".
	
Parameters:
	NONE

Returns:
	ARRAY - Format [primary weapons, secondary weapons, launchers, backpacks, vests, uniforms, headgear, items, explosives]

Examples:
    (begin example)

		call BLWK_fnc_prepareLootClasses

    (end)
Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false};


// get white and black lists for loot
#include "..\..\Headers\Loot Lists.hpp"

// Check if we are in whitelisted items only mode
if (BLWK_loot_whiteListMode isEqualTo 1) exitWith {
	[
		WHITELIST_PRIMARY_WEAPONS,
		WHITELIST_HANDGUN_WEAPONS,
		WHITELIST_LAUNCHERS,
		WHITELIST_BACKPACKS,
		WHITELIST_VESTS,
		WHITELIST_UNIFORMS,
		WHITELIST_HEADGEAR,
		WHITELIST_ITEMS,
		WHITELIST_EXPLOSIVES
	]
};



/* ----------------------------------------------------------------------------

	Functions

---------------------------------------------------------------------------- */
// some of this is setup with the intention that things may be further broken down into more categories
// this is why the functions are here that just pushback something
private _tempClass = "";
private _tempReturn = [];
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
	if (_tempItemType == "MissileLauncher" OR {_tempItemType == "Launcher"} OR {_tempItemType == "RocketLauncher"}) exitWith {_launcherClasses pushBack _tempClass};
	if (_tempItemType == "Handgun") exitWith {_handgunWeaponClasses pushBack _tempClass};
	if (_tempItemType == "AssaultRifle" OR 
		{_tempItemType == "MachineGun"} OR 
		{_tempItemType == "Shotgun"} OR 
		{_tempItemType == "Rifle"} OR 
		{_tempItemType == "SubmachineGun"} OR 
		{_tempItemType == "SniperRifle"}) exitWith {_primaryWeaponClasses pushBack _tempClass};
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

//CIPHER COMMENT: Haven't really used this, may just need to roll it into explosive classes since it already does so with grenades
//private _magazineClasses = [];
private _fn_sortMagazines = {
	// CIPHER COMMENT: possibly add more to this list. Depends on how you want to spawn magazines
	if (_tempItemType in ["grenade","flare"]) exitWith {call _fn_sortExplosives};

	//_magazineClasses pushBack _tempClass
};

private _fn_sortType = {
	_tempClass = configName (_this select 0);

	if (_tempClass in LOOT_BLACKLIST) exitWith {};

	// CIPHER COMMENT: DLC check is awaiting 2.0 release for getAssetDLCInfo command
	/*
		_configHierarchyTemp = _this select 1;
		_dlcAllowedTemp = [_tempClass,_configHierarchyTemp] call BLWK_fnc_checkDLC;
		if !(_dlcAllowedTemp) exitWith {};
	*/

	_tempReturn = [_tempClass] call BIS_fnc_itemType;

	_tempItemCategory = _tempReturn select 0;
	_tempItemType = _tempReturn select 1;

	if (_tempItemCategory == "weapon") exitWith {call _fn_sortWeapons};
	if (_tempItemCategory == "item") exitWith {call _fn_sorItems};
	if (_tempItemCategory == "equipment") exitWith {call _fn_sortEquipment};
	if (_tempItemCategory == "mine") exitWith {call _fn_sortExplosives};
	if (_tempItemCategory == "magazine") exitWith {call _fn_sortMagazines};
};



/* ----------------------------------------------------------------------------

	Execution

---------------------------------------------------------------------------- */
private _publicWeaponConfigs = "getNumber (_x >> 'scope') isEqualTo 2" configClasses (configFile >> "CfgWeapons");
_publicWeaponConfigs apply {
	[_x,"CfgWeapons"] call _fn_sortType;	
};
// things such as vests and backpacks are located in CfgVehicles
private _publicVehicleConfigs = "getNumber (_x >> 'scope') isEqualTo 2" configClasses (configFile >> "CfgVehicles");
_publicVehicleConfigs apply {
	[_x,"CfgVehicles"] call _fn_sortType;	
};
// for throwable explosives
private _publicMagazineConfigs = "getNumber (_x >> 'scope') isEqualTo 2" configClasses (configFile >> "CfgMagazines");
_publicMagazineConfigs apply {
	[_x,"CfgMagazines"] call _fn_sortType;	
};


// check white list mode to see if we should add whitelisted items to arrays
if (BLWK_loot_whiteListMode isEqualTo 2) then {
    _backpackClasses append WHITELIST_BACKPACKS;
    _explosiveClasses append WHITELIST_EXPLOSIVES;
    _itemClasses append WHITELIST_ITEMS;
    _uniformClasses append WHITELIST_UNIFORMS;
    _vestClasses append WHITELIST_VESTS;
	_headgearClasses append WHITELIST_HEADGEAR;
	_primaryWeaponClasses append WHITELIST_PRIMARY_WEAPONS;
	_handgunWeaponClasses append WHITELIST_HANDGUN_WEAPONS;
	_launcherClasses append WHITELIST_LAUNCHERS;
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
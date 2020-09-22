/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareLootClasses

Description:
	Gets all the loot classes for spawning it during the mission.
	
	It is executed from the "BLWK_fnc_prepareGlobals".
	
Parameters:
	NONE

Returns:
	ARRAY - Format [weapons,backpacks,vests,uniforms,headgear,items,explosives]

Examples:
    (begin example)

		call BLWK_fnc_prepareLootClasses

    (end)
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false};


/* Loot Blacklist */
// items that will NOT be spawned in as loot
private _loot_blacklist = [
    "O_Static_Designator_02_weapon_F", // If players find and place CSAT UAVs they count as hostile units and round will not progress
    "O_UAV_06_backpack_F",
    "O_UAV_06_medical_backpack_F",
    "O_UAV_01_backpack_F",
    "B_IR_Grenade",
    "O_IR_Grenade",
    "I_IR_Grenade"
];


/* Whitelist modes */
/* 0 = Off */
/* 1 = Only Whitelist Items will spawn as loot */
/* 2 = Whitelist items get added to existing loot (increases the chance of loot spawning */
private _whitelist_weaponClasses = [
	//"example_weapon_1",
	//"example_weapon_2"
];
private _whitelist_backpackClasses = [

];
private _whitelist_vestClassess = [

];
private _whitelist_uniformClasses = [

];
private _whitelist_headgearClasses = [

];

private _whitelist_itemClasses = [

];
private _whitelist_explosiveClasses = [

];


// Check if we are in whitelisted items only mode
if (BLWK_loot_whiteListMode isEqualTo 1) exitWith {
	[
		_whitelist_weaponClasses,
		_whitelist_backpackClasses,
		_whitelist_vestClassess,
		_whitelist_uniformClasses,
		_whitelist_headgearClasses,
		_whitelist_itemClasses,
		_whitelist_explosiveClasses
	]
};
///////////////////////////////////////////////////////////////////////
///////////////////////////////Functions///////////////////////////////
///////////////////////////////////////////////////////////////////////


// some of this is setup with the intention that things may be further broken down into more categories
// this is why the functions are here that just pushback something
private _tempClass = "";
private _tempReturn = [];
private _tempItemCategory = "";
private _tempItemType = "";
private _dlcAllowed = true;
private _dlcString = "";
private _configHierarchy = "";

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

private _weaponClasses = [];
private _fn_sortWeapons = {
	_weaponClasses pushBack _tempClass;
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

//CIPHER COMMENT: Haven't really used this, may just need to roll it inot explosive classes since it already does so with grenades
//private _magazineClasses = [];
private _fn_sortMagazines = {
	// CIPHER COMMENT: possibly add more to this list. Depends on how you want to spawn magazines
	if (_tempItemType in ["grenade","flare"]) exitWith {call _fn_sortExplosives};

	//_magazineClasses pushBack _tempClass
};


private _fn_sortType = {
	_tempClass = configName (_this select 0);
	// exclude blacklist items
	if (_tempClass in _loot_blacklist) exitWith {};

	_configHierarchy = _this select 1;
	// CIPHER COMMENT: DLC check is awaiting 2.0 release for getAssetDLCInfo command
	//_dlcAllowed = [_tempClass,_configHierarchy] call BLWK_fnc_checkDLC;
	if !(_dlcAllowed) exitWith {};

	_tempReturn = [_tempClass] call BIS_fnc_itemType;
	// some of the string checks are case sensetive
	// CIPHER COMMENT: this may be uneccessary now to tolower it
	_tempItemCategory = toLower (_tempReturn select 0);
	_tempItemType = toLower (_tempReturn select 1);

	if (_tempItemCategory == "weapon") exitWith {call _fn_sortWeapons};
	if (_tempItemCategory == "item") exitWith {call _fn_sorItems};
	if (_tempItemCategory == "equipment") exitWith {call _fn_sortEquipment};
	if (_tempItemCategory == "mine") exitWith {call _fn_sortExplosives};
	if (_tempItemCategory == "magazine") exitWith {call _fn_sortMagazines};
};




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
    _backpackClasses append _whitelist_backpackClasses;
    _explosiveClasses append _whitelist_explosiveClasses;
    _itemClasses append _whitelist_itemClasses;
    _uniformClasses append _whitelist_uniformClasses;
    _vestClasses append _whitelist_vestClassess;
	_headgearClasses append _whitelist_headgearClasses;
	_weaponClasses append _whitelist_weaponClasses;
};



[
	_weaponClasses,
	_backpackClasses,
	_vestClasses,
	_uniformClasses,
	_headgearClasses,
	_itemClasses,
	_explosiveClasses
]
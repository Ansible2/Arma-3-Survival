/* Loot Blacklist */
// items that will NOT be spawned in as loot
_blacklist = [
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
BLWK_loot_whiteListMode = 0;

/* Loot Whitelists */
private _whitelist_weaponClasses = [
	//"example_item_1",
	//"example_item_2"
];
private _whitelist_vestClassess = [

];
private _whitelist_clothingClasses = [

];
private _whitelist_itemClasses = [

];
private _whitelist_explosiveClasses = [

];
private _whitelist_backpackClasses = [

];


/* Loot Spawn */
BLWK_loot_weaponClasses    = List_AllWeapons - BLWK_blacklist;   
BLWK_loot_vestClasses = List_Vests; //Cipher Comment: not used yet, need to implement instead of having it added to the clothing pool
BLWK_loot_clothingClasses   = List_AllClothes /*+ List_Vests*/ - BLWK_blacklist;
BLWK_loot_itemClasses      = List_Optics + List_Items - BLWK_blacklist;
BLWK_loot_explosiveClasses = List_Mines + List_Grenades + List_Charges - BLWK_blacklist;
BLWK_loot_backpackClasses   = List_Backpacks - BLWK_blacklist;

// adjusut to white list mode
if (BLWK_loot_whiteListMode isEqualTo 1) then {
    BLWK_loot_backpackClasses = BLWK_whitelist_backpackClasses;
    BLWK_loot_explosiveClasses = BLWK_whitelist_explosiveClasses;
    BLWK_loot_itemClasses = BLWK_whitelist_itemClasses;
    BLWK_loot_clothingClasses = BLWK_whitelist_clothingClasses;
    BLWK_loot_vestClasses = BLWK_whitelist_vestClassess;
	BLWK_loot_weaponClasses = BLWK_whitelist_weaponClasses;
};
if (BLWK_loot_whiteListMode isEqualTo 2) then {
    BLWK_loot_backpackClasses append BLWK_whitelist_backpackClasses;
    BLWK_loot_explosiveClasses append BLWK_whitelist_explosiveClasses;
    BLWK_loot_itemClasses append BLWK_whitelist_itemClasses;
    BLWK_loot_clothingClasses append BLWK_whitelist_clothingClasses;
    BLWK_loot_vestClasses append BLWK_whitelist_vestClassess;
	BLWK_loot_weaponClasses append BLWK_whitelist_weaponClasses;
};






/*
 	need to exclude DLC
	need to sort Items into: 
	- backpacks
	- vests
	- items
	- Clothes
	- Weapons
	- Explosives (grenades too?)
*/





private _tempClass = "";
private _tempReturn = [];
private _tempItemCategory = "";
private _tempItemType = "";
private _dlcAllowed = false;
private _dlcString = "";

// sort through clothes, vests, backpacks, headgear
private _fn_sortEquipment = {

};
private _fn_sortWeapons = {

};
// nvgs, gps, medkit, toolkit,
private _fn_sortItems = {

};
private _fn_checkDLC = {
	_dlcString = (getAssetDLCInfo [_tempClass,_config]) select 5;

	if (_dlcString in BLWK_useableDLCs) then {
		true
	} else {
		false
	};
};

private _fn_sortType = {
	params ["_config"];
	_tempClass = configName _x;

	_dlcAllowed = call _fn_checkDLC;

	if (_dlcAllowed) then {
		_tempReturn = [_tempClass] call BIS_fnc_itemType;
		_tempItemCategory = _tempReturn select 0;
		_tempItemType = _tempReturn select 1;

		if (_tempItemCategory in ["Weapon","Item","Equipment","mine"]) then {
			switch (toLower _tempItemCategory) do {
				case "weapon": {call _fn_sortWeapons};
				case "item": {call _fn_sorItems};
				case "equipment": {};
				case "mine": {};
			};
		};
	};
};

private _publicConfigs = "getNumber (_x >> 'scope') isEqualTo 2" configClasses (configFile >> "CfgWeapons");
// things such as vests and backpacks are located in CfgVehicles
_publicConfigs append ("getNumber (_x >> 'scope') isEqualTo 2" configClasses (configFile >> "cfgVehicles"));

_publicConfigs apply {
	[_x] call _fn_sortType;	
};

_publicWeaponClasses





























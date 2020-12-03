/* ----------------------------------------------------------------------------
Function: BLWK_fnc_randomizeWeapons

Description:
	Uses loot lists to give a unit an random assortment of weapons.
	The unit will always get a primary but will only have certain
	 chances to get things such as grenades, launchers, pistols, etc.

	Executed from "BLWK_fnc_handleEnemyWeapons"

Parameters:
	0: _unit : <OBJECT> - The unit to give random weapons to

Returns:
	NOTHING

Examples:
    (begin example)

		[theUnit] call BLWK_fnc_randomizeWeapons;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
// these random numbers are to increase the chance of the extremses like 1 or 3 
//  but keep it impossible to get to 0 or 4
#define RANOM_123 [0.51,2,3.49]
#define RANDOM_345 [2.51,4,5.49]
#define RANOM_234 [1.51,3,4.49]

params ["_unit"];

removeAllWeapons _unit;

// primary
private _primaryWeaponClass = selectRandom BLWK_loot_primaryWeapons;
_unit addweapon _primaryWeaponClass;
_unit selectWeapon _primaryWeaponClass;
private _primaryMagazineClass = selectRandom (getArray (configFile >> "CfgWeapons" >> _primaryWeaponClass >> "magazines"));
_unit addPrimaryWeaponItem _primaryMagazineClass;
_unit addMagazineCargoGlobal [_primaryMagazineClass,round random RANDOM_345];

// handgun
private _addHandgunWeapon = selectRandomWeighted [true,0.3,false,0.7];
if (_addHandgunWeapon) then {
	private _handgunWeaponClass = selectRandom BLWK_loot_primaryWeapons;
	_unit addweapon _handgunWeaponClass;
	private _handgunMagazineClass = selectRandom (getArray (configFile >> "CfgWeapons" >> _handgunWeaponClass >> "magazines"));
	_unit addHandgunItem _handgunMagazineClass;
	_unit addMagazineCargoGlobal [_handgunMagazineClass,round random RANOM_234];
};

// launcher
private _addLauncher = selectRandomWeighted [true,0.1,false,0.9];
if (_addLauncher) then {
	private _launcherClass = selectRandom BLWK_loot_primaryWeapons;
	_unit addweapon _launcherClass;
	private _launcherMagazineClass = selectRandom (getArray (configFile >> "CfgWeapons" >> _launcherClass >> "magazines"));
	_unit addSecondaryWeaponItem _launcherMagazineClass;
	_unit addMagazineCargoGlobal [_launcherMagazineClass,1];
};

// explosives
private _addExplosives = selectRandomWeighted [true,0.1,false,0.9];
if (_addExplosives) then {
	private _explossivesClass = selectRandom BLWK_loot_primaryWeapons;
	_unit addMagazineCargoGlobal [_explossivesClass,round random RANOM_123];
};

// First Aid Kit
private _addFirstAidKit = selectRandomWeighted [true,0.5,false,0.5];
if (_addFirstAidKit) then {
	_unit addItemCargoGlobal ["FirstAidKit",RANOM_123];
};
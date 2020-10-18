/* ----------------------------------------------------------------------------
Function: BLWK_fnc_doMagRepack

Description:
	Completes a repack on the units current weapon.

	Executed from a displayAddEventHandler for Ctrl+R
	 that is added in the "initClientAlias.sqf"

Parameters:
	0: _player : <OBJECT> - The person doing the repack

Returns:
	NOTHING

Examples:
    (begin example)

		[player] call BLWK_fnc_doMagRepack;

    (end)

Author:
	Quicksilver,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_player",player,[objNull]]
];

// get all mags execept for empty ones
private _playerMags = (magazinesAmmoFull _player) select {(_x select 1) != 0};
if (_playerMags isEqualTo []) exitWith {
	hint "You have no mags to repack";
	
	false
};

private _sortedMagClasses = [];
private ["_currentMagazineClass_temp","_magType_temp","_numberOfMags_temp","_magInfo_temp","_allMagsOfClass_temp","_totalBulletsForClass_temp"];
private _fn_pushToSorted = {
	_sortedMagClasses pushBack _currentMagazineClass_temp;
};

// sort the mags in on the player to find those that can be repacked
private "_totalBulletsForClass_temp";
private _playerMagsSorted = [];
_playerMags apply {
	_magInfo_temp = _x;
	_currentMagazineClass_temp = _magInfo_temp select 0;

	// see if mag class was already sorted
	if !(_currentMagazineClass_temp in _sortedMagClasses) then {
		_magType_temp = ([_currentMagazineClass_temp] call BIS_fnc_itemType) select 1;
		// sort through mags to get those that aren't are grenades, flares, etc.
		if (_magType_temp == "Bullet" OR {_magType_temp == "Missile"} OR {_magType_temp == "Rocket"}) then {
			// check to make sure there are multiple mags of this type in the units inventory
			_allMagsOfClass_temp = _playerMags select {(_x select 0) == _currentMagazineClass_temp};
			if ((count _allMagsOfClass_temp) > 1) then {
				
				// get the total number of bullets for this mag className
				_totalBulletsForClass_temp = 0;
				_allMagsOfClass_temp apply {
					_totalBulletsForClass_temp = _totalBulletsForClass_temp + (_x select 1);
				};
				_playerMagsSorted pushBack [_currentMagazineClass_temp,_totalBulletsForClass_temp];
			};
		}
		call _fn_pushToSorted;
	};
};


private _fn_magTypeInWeapon = {
	if (_magClassnameTemp == _primaryWeaponMagClass) exitWith {
		_player removePrimaryWeaponItem _magClassnameTemp;
		_player addPrimaryWeaponItem _magClassnameTemp;
		true
	};
	if (_magClassnameTemp == _handgunWeaponMagClass) exitWith {
		_player removeHandgunItem _magClassnameTemp;
		_player addHandgunItem _magClassnameTemp;
		true
	};
	if (_magClassnameTemp == _secondaryWeaponMagClass) exitWith {
		_player removeSecondaryWeaponItem _magClassnameTemp;
		_player addSecondaryWeaponItem _magClassnameTemp;
		true
	};

	false
};
// if there are no mags to repack, just hint
if !(_playerMagsSorted isEqualTo []) then {
	_player playMove "AinvPknlMstpSnonWnonDr_medic2";

	// get mags loaded into current handgun and primary
	private _primaryWeaponMagClass = (primaryWeaponMagazine _player) select 0;
	private _handgunWeaponMagClass = (handgunMagazine _player) select 0;
	private _secondaryWeaponMagClass = (secondaryWeaponMagazine _player) select 0;

	private ["_magCapacity","_numberOfFullMagsToAdd","_totalBulletCountForClass","_remainderMagBulletCount","_magClassnameTemp"];
	_playerMagsSorted apply {
		_magClassnameTemp = _x select 0;
		_totalBulletCountForClass = _x select 1;
		_magCapacity = getNumber (configFile >> "CfgMagazines" >> _magClassnameTemp >> "Count");
		
		// if the total bullets for the mag are not going to equal more than one mag
		if (_totalBulletCountForClass <= _magCapacity) then {
			if (call _fn_magTypeInWeapon) then {
				private _index = [_primaryWeaponMagClass,_handgunWeaponMagClass,_secondaryWeaponMagClass] findIf {_x == _magClassnameTemp};
				switch _index do {
					case 0: {_player setAmmo [primaryWeapon _player,_totalBulletCountForClass]};
					case 1: {_player setAmmo [handgunWeapon _player,_totalBulletCountForClass]};
					case 2: {_player setAmmo [secondaryWeapon _player,_totalBulletCountForClass]};
				};
			} else {
				_player addMagazine [_magClassnameTemp,_totalBulletCountForClass];
			};
		} else {		
			_numberOfFullMagsToAdd = floor (_totalBulletCountForClass / _magCapacity);
			
			// if the mag type is currently inserted into a weapon
			if (call _fn_magTypeInWeapon) then {
				_numberOfFullMagsToAdd = _numberOfFullMagsToAdd - 1;
			};
			
			// remove every mag (that's not in the gun) including empty ones
			_player removeMagazines _magClassnameTemp;
			_player addMagazines [_magClassnameTemp,_numberOfFullMagsToAdd];

			// check for if we need that one not full mag to hold the excess ammo
			_remainderMagBulletCount = _totalBulletCountForClass mod _magCapacity;
			if !(_remainderMagBulletCount isEqualTo 0) then {
				_player addMagazine [_magClassnameTemp,_remainderMagBulletCount];
			};
		};
	};

	true;
} else {
	hint "You have no mags that need to be repacked";

	false
};
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_doMagRepack

Description:
	Completes a repack on the units current weapon.

Parameters:
	0: _unit : <OBJECT> - The person doing the repack
	1: _doHint : <BOOL> - Should the local client be informed of packs?

Returns:
	<BOOL> - false if not completed, true if it was

Examples:
    (begin example)

		[player] call BLWK_fnc_doMagRepack;

    (end)

Author(s):
	Quicksilver,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_unit",player,[objNull]],
	["_doHint",true,[true]]
];

// get all mags except for empty ones
private _unitMags = (magazinesAmmoFull _unit) select {(_x select 1) != 0};
if (_unitMags isEqualTo []) exitWith {
	if (_doHint) then {
		hint "You have no mags to repack";
	};
	false
};

private _sortedMagClasses = [];
private ["_currentMagazineClass_temp","_magType_temp","_numberOfMags_temp","_magInfo_temp","_allMagsOfClass_temp","_totalBulletsForClass_temp"];
private _fn_pushToSorted = {
	_sortedMagClasses pushBack _currentMagazineClass_temp;
};

// sort the mags in on the player to find those that can be repacked
private "_totalBulletsForClass_temp";
private _unitMagsSorted = [];
_unitMags apply {
	_magInfo_temp = _x;
	_currentMagazineClass_temp = _magInfo_temp select 0;

	// see if mag class was already sorted
	if !(_currentMagazineClass_temp in _sortedMagClasses) then {
		_magType_temp = ([_currentMagazineClass_temp] call BIS_fnc_itemType) select 1;
		// sort through mags to get those that aren't are grenades, flares, etc.
		if (_magType_temp == "Bullet" OR {_magType_temp == "Missile"} OR {_magType_temp == "Rocket"}) then {
			// check to make sure there are multiple mags of this type in the units inventory
			_allMagsOfClass_temp = _unitMags select {(_x select 0) == _currentMagazineClass_temp};
			if ((count _allMagsOfClass_temp) > 1) then {
				
				// get the total number of bullets for this mag className
				_totalBulletsForClass_temp = 0;
				_allMagsOfClass_temp apply {
					_totalBulletsForClass_temp = _totalBulletsForClass_temp + (_x select 1);
				};
				_unitMagsSorted pushBack [_currentMagazineClass_temp,_totalBulletsForClass_temp];
			};
		}
		call _fn_pushToSorted;
	};
};



// if there are no mags to repack, just hint
if !(_unitMagsSorted isEqualTo []) then {
	_unit playMove "AinvPknlMstpSnonWnonDr_medic2";

	// get mags loaded into current handgun and primary
	private _primaryMag = primaryWeaponMagazine _unit;
	private _primaryWeaponMagClass = "";
	if !(_primaryMag isEqualTo []) then { // if there is a primary magazine
		_primaryWeaponMagClass = _primaryMag select 0;
	};
	
	private _handgunMag = handgunMagazine _unit;
	private _handgunWeaponMagClass = "";
	if !(_handgunMag isEqualTo []) then { // if there is a handgun magazine
		_handgunWeaponMagClass = _handgunMag select 0;
	};

	private _secondaryMag = secondaryWeaponMagazine _unit;
	private _secondaryWeaponMagClass = "";
	if !(_secondaryMag isEqualTo []) then { // if there is a secondary magazine
		_secondaryWeaponMagClass = _secondaryMag select 0;
	};
	

	private _fn_magTypeInWeapon = {
		params [
			["_doAddMag",true]
		];

		if (_magClassnameTemp == _primaryWeaponMagClass) exitWith {
			if (_doAddMag) then {
				_unit removePrimaryWeaponItem _magClassnameTemp;
				_unit addPrimaryWeaponItem _magClassnameTemp;
			};
			true
		};
		if (_magClassnameTemp == _handgunWeaponMagClass) exitWith {
			if (_doAddMag) then {
				_unit removeHandgunItem _magClassnameTemp;
				_unit addHandgunItem _magClassnameTemp;
			};
			true
		};
		if (_magClassnameTemp == _secondaryWeaponMagClass) exitWith {
			if (_doAddMag) then {
				_unit removeSecondaryWeaponItem _magClassnameTemp;
				_unit addSecondaryWeaponItem _magClassnameTemp;
			};
			true
		};

		false
	};


	private ["_magCapacity","_numberOfFullMagsToAdd","_totalBulletCountForClass","_remainderMagBulletCount","_magClassnameTemp"];
	_unitMagsSorted apply {
		_magClassnameTemp = _x select 0;
		_totalBulletCountForClass = _x select 1;
		_magCapacity = getNumber (configFile >> "CfgMagazines" >> _magClassnameTemp >> "Count");

		// remove every mag (that's not in the gun) including empty ones
		_unit removeMagazines _magClassnameTemp;
		
		// if the total bullets for the mag are not going to equal more than one mag
		if (_totalBulletCountForClass <= _magCapacity) then {
			if ([false] call _fn_magTypeInWeapon) then {
				private _index = [_primaryWeaponMagClass,_handgunWeaponMagClass,_secondaryWeaponMagClass] find _magClassnameTemp;
				switch _index do {
					case 0: {_unit setAmmo [primaryWeapon _unit,_totalBulletCountForClass]};
					case 1: {_unit setAmmo [handgunWeapon _unit,_totalBulletCountForClass]};
					case 2: {_unit setAmmo [secondaryWeapon _unit,_totalBulletCountForClass]};
				};
			} else {
				_unit addMagazine [_magClassnameTemp,_totalBulletCountForClass];
			};
		} else {
			_numberOfFullMagsToAdd = floor (_totalBulletCountForClass / _magCapacity);
			
			// if the mag type is currently inserted into a weapon
			if ([true] call _fn_magTypeInWeapon) then {
				_numberOfFullMagsToAdd = _numberOfFullMagsToAdd - 1;
			};
			
			_unit addMagazines [_magClassnameTemp,_numberOfFullMagsToAdd];

			// check for if we need that one not full mag to hold the excess ammo
			_remainderMagBulletCount = _totalBulletCountForClass mod _magCapacity;
			if !(_remainderMagBulletCount isEqualTo 0) then {
				_unit addMagazine [_magClassnameTemp,_remainderMagBulletCount];
			};
		};
	};

	true;
} else {
	if (_doHint) then {
		hint "You have no mags that need to be repacked";
	};
	false
};
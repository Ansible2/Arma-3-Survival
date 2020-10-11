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

		call BLWK_fnc_doMagRepack;

    (end)

Author:
	Quicksilver,
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_player",player,[objNull]]
];

private _playerFullMags = magazinesAmmo _player;

private _fullAmmoCountArr = [];
private _foundMags = [];
_playerFullMags apply {
	_magName = (_x select 0);

	if ((_foundMags find _magName) isEqualTo -1) then {
		_fullAmmoCountArr pushback [_magName, 0];
		_foundMags pushback _magName;
	};
};


private ["_magArrayTemp","_magClassName","_currentRoundCount","_roundsinCurrentMag","_totalRounds"];
_playerFullMags apply {
	_magArrayTemp = _x;
	_magClassName = (_magArrayTemp select 0);
	{
		if (_magClassName isEqualTo (_x select 0)) then {
			_currentRoundCount = _x select 1; // get rounds currently in array
			_roundsinCurrentMag = _magArrayTemp select 1; // get rounds in current mag
			_totalRounds = _currentRoundCount + _roundsinCurrentMag; //add them
			(_fullAmmoCountArr select _forEachIndex) set [1, _totalRounds]; //delete current entry in array
		};
	} forEach _fullAmmoCountArr;
};

_fullAmmoCountArr = _fullAmmoCountArr - [["test",0]];

private ["_roundCount","_magCapacity","_roundsDivByMagCap"];
_fullAmmoCountArr apply {
	_magClassName = (_x select 0);
	_roundCount = (_x select 1);
	_magCapacity = getNumber (configFile >> "CfgMagazines" >> _magClassName >> "Count");
	_roundsDivByMagCap = (_roundCount / _magCapacity);
	if (_roundsDivByMagCap > 1) then { // more than one mag
		_player removeMagazines _magClassName;
		for "_magToAddIter" from 1 to (floor _roundsDivByMagCap) do {
			_player addMagazine _magClassName;
		};
		_remainingRounds = _roundCount - (floor _roundsDivByMagCap * _magCapacity);
		if (_remainingRounds != 0) then {
			_player addMagazine [_magClassName, _remainingRounds];
		};
	};
};

if (!(_foundMags isEqualTo [])) then {
	_player playMove "AinvPknlMstpSnonWnonDr_medic2";
};
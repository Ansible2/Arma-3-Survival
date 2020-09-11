/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spendPoints

Description:
	Subtracts a specified number of the player's points

Parameters:
	0: _pointsSpent : <NUMBER> - The amount to subtract

Returns:
	BOOL

Examples:
    (begin example)

		// remove 10 points from player
		[10] call BLWK_fnc_spendPoints;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
QS_fnc_magRepack = {
	params [
		["_player",player,[objNull]]
	];

	_playerFullMags = magazinesAmmo _player;

	_fullAmmoCountArr = [];
	_foundMags = [];
	{
		_magName = (_x select 0);

		if ((_foundMags find _magName) == -1) then {
			_fullAmmoCountArr pushback [_magName, 0];
			_foundMags pushback _magName;
		};
	}forEach _playerFullMags;

	{
		_aMagArray = _x;
		_magClassName = (_aMagArray select 0);
		{
			if (_magClassName isEqualTo (_x select 0)) then {
				_currentRoundCount = _x select 1; // get rounds currently in array
				_roundsinCurrentMag = _aMagArray select 1; // get rounds in current mag
				_totalRounds = _currentRoundCount + _roundsinCurrentMag; //add them
				(_fullAmmoCountArr select _forEachIndex) set [1, _totalRounds]; //delete current entry in array
			};
		}forEach _fullAmmoCountArr;
	}forEach _playerFullMags;
	_fullAmmoCountArr = _fullAmmoCountArr - [["test",0]];

	{
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
	}forEach _fullAmmoCountArr;

	if (!(_foundMags isEqualTo [])) then {
		_player playMove "AinvPknlMstpSnonWnonDr_medic2";
	};
};


MY_KEYDOWN_FNC = {
    _handled = false;
    params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];
    
	if (_dikCode isEqualTo 19 AND _ctrlKey) exitWith { // using if instead of switch since it's faster when evaluating only one condition
        call QS_fnc_magRepack;
    };
};

waituntil {!(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyDown",{_this call MY_KEYDOWN_FNC}];
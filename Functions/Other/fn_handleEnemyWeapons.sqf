params ["_unit"];

if (!local _unit) exitWith {false};

// handle pistol only wave and random weapons
if (BLWK_currentWaveNumber <= BLWK_maxPistolOnlyWaves) then {
	removeAllWeapons _unit;
	private _pistolMagClass = "16Rnd_9x21_Mag";
	_unit addMagazine _pistolMagClass;
	_unit addMagazine _pistolMagClass;
	_unit addWeaponGlobal "hgun_P07_F";
	_unit addHandgunItem _pistolMagClass;

	private _addFirstAidKit = selectRandomWeighted [true,0.5,false,0.5];
	if (_addFirstAidKit) then {
		_unit addItemCargoGlobal ["FirstAidKit",round random [0.51,2,3.49]];
	};
} else {
	if (BLWK_randomizeEnemyWeapons) then {
		[_unit] call BLWK_fnc_randomizeEnemyWeapons;
	};
};


true
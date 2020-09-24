/* ----------------------------------------------------------------------------
Function: BLWK_fnc_animateRandomWeaponBox

Description:
	Performs the "animation" for the box and handles creating and deleting the weapon
	
	It is executed from the "".
	
Parameters:
	NONE

Returns:
	Nothing

Examples:
    (begin example)

		null = [BLWK_randomWeapon] spawn BLWK_fnc_spinRandomWeaponBox;

    (end)
---------------------------------------------------------------------------- */
if (!canSuspend) exitWith {};

// check if player has enough to use the box
if ((missionNamespace getVariable ["BLWK_playerKillPoints",0]) < BLWK_costToSpinRandomBox) exitWith {
	hint "You Do Not Enough Points To Spin The Box"
};

[BLWK_costToSpinRandomBox] call BLWK_fnc_subtractPoints;

// so that others can't use the box
missionNamespace setVariable ["BLWK_randomWeaponBoxInUse",true,true];

#define SLEEP_TIME 0.1
#define NUMBER_OF_FRAMES 60

// create weapon holder
private _boxPositiion = getPosATL BLWK_randomWeaponBox;
private _weaponHolder = createVehicle ["WeaponHolderSimulated_Scripted", _boxPositiion, [], 0, "can_collide"];

// so that people can't take a weapon while animation plays
_weaponHolder enableSimulationGlobal false;


// CIPHER COMMENT: Need to add the sound for the box spin
// animate up
private _incriment = 1/NUMBER_OF_FRAMES;
private "_tempWeapon";
private _possibleWeapons = BLWK_loot_weaponClasses;
for "_i" from 1 to NUMBER_OF_FRAMES do {
	_tempWeapon = selectRandom _possibleWeapons;
	_weaponHolder addWeaponCargoGlobal [_tempWeapon,1];
	_weaponHolder setPosATL ((getPosATLVisual _weaponHolder) vectorAdd [0,0,_incriment]);
	_weaponHolder setVectorDirAndUp [vectorDir BLWK_randomWeaponBox, vectorUp BLWK_randomWeaponBox];
	
	sleep SLEEP_TIME;

	// if on last frame add the ammo for the selected weapon and allow player to grab it
	if (_i isEqualTo NUMBER_OF_FRAMES) exitWith {  
		private _ammoArray = getArray (configFile >> "CfgWeapons" >> _tempWeapon >> "magazines");
  		_weaponHolder addMagazineCargoGlobal [selectRandom _ammoArray, 1];
		// enable pick up
		_weaponHolder enableSimulationGlobal true;
	};

	clearWeaponCargoGlobal _weaponHolder;
};

sleep 5;

// if weapon was taken, delete the holder, else animate down
if ((weaponCargo _weaponHolder) isEqualTo []) then {
	deleteVehicle _weaponHolder;
} else {
	_weaponHolder enableSimulationGlobal false;

	// animate down
	for "_i" from 1 to NUMBER_OF_FRAMES do {
		_weaponHolder setPosATL ((getPosATLVisual _weaponHolder) vectorDiff [0,0,_incriment]);
		_weaponHolder setVectorDirAndUp [vectorDir BLWK_randomWeaponBox, vectorUp BLWK_randomWeaponBox];

		sleep SLEEP_TIME;

		// if on last step
		if (_i isEqualTo NUMBER_OF_FRAMES) exitWith {  
			clearWeaponCargoGlobal _weaponHolder;
			deleteVehicle _weaponHolder;
		};
	};
};
 
missionNamespace setVariable ["BLWK_randomWeaponBoxInUse",false,true];
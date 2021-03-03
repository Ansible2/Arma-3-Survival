/* ----------------------------------------------------------------------------
Function: BLWK_fnc_spinRandomWeaponBox

Description:
	Performs the "animation" for the box and handles 
	 creating and deleting the weapon.
	
	Executed from the action added in "BLWK_fnc_addWeaponBoxSpinAction"
	
Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		[] spawn BLWK_fnc_spinRandomWeaponBox;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
// CIPHER COMMENT: might be worth just passing the box as an arguement instead
//  of using the global var synced over the network. It would already be available in the
//  action 
#define SLEEP_TIME 0.1
#define NUMBER_OF_FRAMES 25

if (!canSuspend) exitWith {};

// so that others can't use the box
missionNamespace setVariable ["BLWK_randomWeaponBoxInUse",true,true];

// create weapon holder
private _boxPosition = getPosATL BLWK_randomWeaponBox;
private _weaponHolder = createVehicle ["GroundWeaponHolder_scripted", _boxPosition, [], 0, "can_collide"];

// so that people can't take a weapon while animation plays
_weaponHolder enableSimulationGlobal false;


// animate up
private _boxPosition_X = _boxPosition select 0;
private _boxPosition_Y = _boxPosition select 1;
private _increment = 1/NUMBER_OF_FRAMES;
private ["_tempWeapon","_weaponHolderPosition"];
private _possibleWeapons = BLWK_loot_weaponClasses;
for "_i" from 1 to NUMBER_OF_FRAMES do {
	_tempWeapon = selectRandom _possibleWeapons;
	_weaponHolder addWeaponCargoGlobal [_tempWeapon,1];
	_weaponHolderPosition = getPosATLVisual _weaponHolder;
	_weaponHolder setPosATL [_boxPosition_X,_boxPosition_Y,(_weaponHolderPosition select 2) + _increment];
	//_weaponHolder setVectorDirAndUp [vectorDir BLWK_randomWeaponBox, vectorUp BLWK_randomWeaponBox];
	
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

sleep 10;

// if weapon was taken, delete the holder, else animate down
if ((weaponCargo _weaponHolder) isEqualTo []) then {
	deleteVehicle _weaponHolder;
} else {
	_weaponHolder enableSimulationGlobal false;

	// animate down
	for "_i" from 1 to NUMBER_OF_FRAMES do {
		_weaponHolder setPosATL ((getPosATLVisual _weaponHolder) vectorDiff [0,0,_increment]);
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
if (BLWK_enemyInfantryQue isEqualTo []) exitWith {objNull};

// CIPHER COMMENT: need to adjust skill depending on wave number

// get the first available unit in the que
(BLWK_enemyInfantryQue deleteAt 0) params ["_position","_type"];

private _group = createGroup OPFOR;
private _unit = _type createVehicle _position;
[_unit] joinSilent _group;

_group allowFleeing false;
[_group, bulwarkBox, 20, "SAD", "AWARE", "RED"] call CBAP_fnc_addWaypoint;

[BLWK_zeus, [[_unit],false]] remoteExec ["addCuratorEditableObjects",2];

// CIPHER COMMENT: May not need this variable for anything at the moment
BLWK_aliveEnemies pushBack _unit;


// Didn't use MPHit event to avoid the networking of it to every preloadCamera
// may try in the future
[_unit] remoteExecCall ["BLWK_fnc_addEnemyHitEH",BLWK_allClientsTargetID,true];

_unit addMPEventHandler ["mpKilled",{
	[_this,_thisEventHandler] call BLWK_fnc_enemyKilledEvent;
}];


// keep items (maps, nvgs, binoculars, etc.) as needing to be loot pickups
removeAllAssignedItems _unit;

// handle pistol only wave and random weapons
if (BWLK_currentWaveNumber <= BLWK_maxPistolOnlyWaves) then {
	removeAllWeapons _unit;
	private _pistolMagClass = "16Rnd_9x21_Mag";
	_unit addMagazine _pistolMagClass;
	_unit addMagazine _pistolMagClass;
	_unit addWeaponGlobal "hgun_P07_F";
	_unit addHandgunItem _pistolMagClass;

	private _addFirstAidKit = selectRandomWeighted [true,0.5,false,0.5];
	if (_addFirstAidKit) then {
		_unit addItemCargoGlobal ["FirstAidKit",[0.51,2,3.49]];
	};
} else {
	if (BLWK_randomizeEnemyWeapons) then {
		[_unit] call BLWK_fnc_randomizeEnemyWeapons;
	};
};


_unit
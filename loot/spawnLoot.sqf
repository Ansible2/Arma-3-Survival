/**
*  spawnLoot
*
*  Spawns loot randomly around the play area
*
*  Domain: Server
**/


/* Item to reveal all loot on the Map (1 spawns every wave) */

droneRoom = while {true} do {
	_lootBulding = selectRandom BLWK_playAreaBuildings;
	_lootRooms = _lootBulding buildingPos -1;
	_lootRoom = selectRandom _lootRooms;
	if(!isNil "_lootRoom") exitWith {_lootRoom};
};
_droneSupport = createVehicle ["Box_C_UAV_06_Swifd_F", droneRoom, [], 0, "CAN_COLLIDE"];
[_droneSupport, ["<t color='#ff00ff'>" + "Reveal loot", "removeAllActions (_this select 0); [ [],'supports\lootDrone.sqf'] remoteExec ['execVM',0];","",1,true,false,"true","true",2.5]] remoteExec ["addAction", 0, true];
BLWK_zeus addCuratorEditableObjects [[_droneSupport], true];

/* Item to unlock Support Menu (1 spawns every wave until found) */
satRoom = [];
if (!BLWK_supportDishFound) then {
	satRoom = while {true} do {
		_satBulding = selectRandom BLWK_playAreaBuildings;
		_satRooms = _satBulding buildingPos -1;
		_satRoom = selectRandom _satRooms;
		if(!isNil "_satRoom") exitWith {_satRoom};
	};
	_satSupport = createVehicle ["Land_SatelliteAntenna_01_F", satRoom, [], 0, "CAN_COLLIDE"];
	[_satSupport, ["<t color='#ff00ff'>" + "Unlock Support Menu", "
		_satSupport = _this select 0;
		_player = _this select 1;
		[_satSupport] remoteExec ['removeAllActions', 0];
		_pointsMulti = ('BLWK_pointsForKill' call BIS_fnc_getParamValue);
		if (!BLWK_supportDishFound) then {
			['TaskAssigned',['Support','Support Menu Unlocked at Bulwark Box']] remoteExec ['BIS_fnc_showNotification', 0];
			['comNoise'] remoteExec ['playSound', 0];
		};
		BLWK_supportDishFound = true;
		SatUnlocks = missionNamespace getVariable 'SatUnlocks';
		[_player, (20 * _pointsMulti)] remoteExecCall ['killPoints_fnc_add', 2];
		{
			[_x] remoteExec ['deleteVehicle', 2];
		} forEach SatUnlocks;
	"]] remoteExec ["addAction", 0, true];
	SatUnlocks pushBack _satSupport;
	publicVariable 'SatUnlocks';
	BLWK_zeus addCuratorEditableObjects [[_satSupport], true];
};

//activeLoot pushback _droneSupport;

// Item to give KillPoints (1 spawns every wave)
pointsLootRoom = while {true} do {
	_lootBulding = selectRandom BLWK_playAreaBuildings;
	_lootRooms = _lootBulding buildingPos -1;
	_lootRoom = selectRandom _lootRooms;
	if(!isNil "_lootRoom") exitWith {_lootRoom};
};
pointsLoot = createVehicle ["Land_Money_F", pointsLootRoom, [], 0, "CAN_COLLIDE"];
[pointsLoot, ["<t color='#00ff00'>" + "Collect Points", "[_this select 0, _this select 1] execVM 'loot\lootPoints.sqf'; [_this select 0] remoteExec ['removeAllActions', 0];","",1,true,false,"true","true",2.5]] remoteExec ["addAction", 0, true];

//activeLoot pushback pointsLoot;

/* Master loot spawner */
_houseCount = floor random 3; // Mix up the loot houses a bit
_houseLoot = 0;
_roomCount = 0;
{
	_houseCount = _houseCount + 1;
	if (_houseCount mod BLWK_loot_cityDistribution == 0) then {
		_houseLoot = _houseLoot + 1;

		_lootBulding = _x;
		_lootRooms = _lootBulding buildingPos -1;

		_roomCount = -1;
		{
			_roomCount = _roomCount + 1;
			if (_roomCount mod BLWK_loot_distributionInBuildings == 0) then {
				if (!(_x isEqualTo droneRoom) && !(_x isEqualTo satRoom) && !(_x isEqualTo pointsLootRoom)) then {
					_lootRoomPos = _x;
					_lootHolder = "WeaponHolderSimulated_Scripted" createVehicle _lootRoomPos;
					if (BLWK_loot_whiteListMode != 1) then {
						switch (floor random 6) do {
							case 0: {
								_weapon = selectRandom BLWK_loot_weaponClasses;
								_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
								_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 1];
								_lootHolder addWeaponCargoGlobal [_weapon, 1];
							};
							case 1: {
								_weapon = selectRandom BLWK_loot_weaponClasses;
								_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
								_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 1 + (floor random 3)];
							};
							case 2: {
								_clothes = selectRandom BLWK_loot_clothingClasses;
								_lootHolder addItemCargoGlobal [_clothes, 1];
							};
							case 3: {
								_items = selectRandom BLWK_loot_itemClasses;
								_lootHolder addItemCargoGlobal [_items, 1];
							};
							case 4: {
								_backpack = selectRandom BLWK_loot_backpackClasses;
								_lootHolder addBackpackCargoGlobal [_backpack, 1];
							};
							case 5: {
								_explosive = selectRandom BLWK_loot_explosiveClasses;
								_lootHolder addMagazineCargoGlobal [_explosive, 1 + (floor random 3)];
							};
						};
					};
					if (BLWK_loot_whiteListMode > 0) then {
						switch (floor random 6) do {
							case 0: {
								_weapon = selectRandom BLWK_whitelist_weaponClasses;
								_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
								_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 1];
								_lootHolder addWeaponCargoGlobal [_weapon, 1];
							};
							case 1: {
								_weapon = selectRandom BLWK_whitelist_weaponClasses;
								_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
								_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 1 + (floor random 3)];
							};
							case 2: {
								_clothes = selectRandom BLWK_whitelist_clothingClasses;
								_lootHolder addItemCargoGlobal [_clothes, 1];
							};
							case 3: {
								_items = selectRandom BLWK_whitelist_itemClasses;
								_lootHolder addItemCargoGlobal [_items, 1];
							};
							case 4: {
								_backpack = selectRandom BLWK_whitelist_backpackClasses;
								_lootHolder addBackpackCargoGlobal [_backpack, 1];
							};
							case 5: {
								_explosive = selectRandom BLWK_whitelist_explosiveClasses;
								_lootHolder addMagazineCargoGlobal [_explosive, 1 + (floor random 3)];
							};
						};
					};
					_lootHolder setPos [_lootRoomPos select 0, _lootRoomPos select 1, (_lootRoomPos select 2) + 0.1];

					//activeLoot pushback _lootHolder; // Add object to array for later cleanup

					[_lootHolder, ['ContainerClosed', { // Add event to delete container if empty
							params ['_container','_player'];
							[_container] call loot_fnc_deleteIfEmpty;
					}]] remoteExec ['addEventHandler', 0];

				};

			};
		} forEach _lootRooms;
	};

} forEach BLWK_playAreaBuildings;

/* Supply Drop */
[BLWK_playAreaCenter, ["<t color='#00ff00'>" + "FILL AMMO", "supports\ammoDrop.sqf","",2,true,false,"true","true",4], "B_T_VTOL_01_vehicle_F"] remoteExec ["supports_fnc_supplyDrop", 2];

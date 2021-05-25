/* ----------------------------------------------------------------------------
Function: BLWK_fnc_itemReclaimer_reclaim

Description:
	Initializes the item reclaimer object.

	Executed from its reclaim action added in "BLWK_fnc_itemReclaimer_addActions"

Parameters:
	0: _reclaimerObject : <OBJECT> - The item reclaimer object

Returns:
	NOTHING

Examples:
    (begin example)
		[anObject] call BLWK_fnc_itemReclaimer_reclaim;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define POINTS_FOR_MAGAZINES 20
#define POINTS_FOR_WEAPONS 125
#define POINTS_FOR_ITEMS 75
#define POINTS_FOR_BACKPACKS 200

#define ADD_TO(COUNT_VAR,NUM) COUNT_VAR = COUNT_VAR + NUM;

scriptName "BLWK_fnc_itemReclaimer_reclaim";

params ["_reclaimerObject"];

if (isNull _reclaimerObject) exitWith {
	["_reclaimerObject was null, exiting...",true] call KISKA_fnc_log;
	nil
};

private _weaponCount = 0;
private _itemCount = 0;
private _backpackCount = 0;
private _magazineCount = 0;

private _fn_countWeaponItems = {
	params ["_container"];
	private "_attachment";
	(weaponsItemsCargo _container) apply {
		ADD_TO(_weaponCount)

		for "_i" from 1 to 6 do {
			_attachment = _x select _i;
			switch _i do {
				case 1; // muzzle attachment
				case 2; // rail attachment
				case 3:{ // optic
					if (_attachment != "") then {
						ADD_TO(_itemCount,1)
					};
				};
				case 4; // magazine
				case 5:{ // secondary muzzle magazine
					if !(_attachment isEqualTo []) then {
						ADD_TO(_magazineCount,1)
					};
				};
				case 6:{ // bipod
					if (_attachment != "") then {
						ADD_TO(_itemCount,1)
					};
				};
			};
		};
	};
};


private _reclaimerBox = _reclaimerObject getVariable "BLWK_reclaimBox";
// get items in containers within the box
(everyContainer _reclaimerBox) apply {
	[_x select 1] call _fn_countWeaponItems;
};

[_reclaimerBox] call _fn_countWeaponItems;

ADD_TO(_itemCount,count (itemCargo _reclaimerBox))
ADD_TO(_magazineCount,count (magazineCargo _reclaimerBox))
ADD_TO(_backpackCount,count (backpackCargo _reclaimerBox))

// delete all inventory
clearItemCargoGlobal _reclaimerBox;
clearBackpackCargoGlobal _reclaimerBox;
clearWeaponCargoGlobal _reclaimerBox;
clearMagazineCargoGlobal _reclaimerBox;

private _totalPoints = 0;
ADD_TO(_totalPoints,_weaponCount * POINTS_FOR_WEAPONS)
ADD_TO(_totalPoints,_magazineCount * POINTS_FOR_MAGAZINES)
ADD_TO(_totalPoints,_itemCount * POINTS_FOR_ITEMS)
ADD_TO(_totalPoints,_backpackCount * POINTS_FOR_BACKPACKS)

private _currentPoints = missionNamespace getVariable ["BLWK_communityKillPoints",0];
missionNamespace setVariable ["BLWK_communityKillPoints",_totalPoints + _currentPoints,true];

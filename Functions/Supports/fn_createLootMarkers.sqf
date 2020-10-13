/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createLootMarkers

Description:
	Creates the loot markers when a player finds the reveal loot box.

	Executed from the action added in "BLWK_fnc_addRevealLootAction"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_createLootMarkers;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
private _fn_setUpMarker = {
	params ["_lootHolder","_index"];

	// checking unique items first
	if (!BLWK_supportDishFound AND {_lootHolder isEqualTo BLWK_supportDish}) exitWith {
		private _marker = createMarker ["BLWK_lootMarker_" + str _index,getPos _lootHolder];
		_marker setMarkerText "Support Dish";
		_marker setMarkerType "hd_dot";
		_marker setMarkerColor "ColorBlack";
		_marker
	};
	if (!(isNil "BLWK_moneyPile") AND {_lootHolder isEqualTo BLWK_moneyPile}) exitWith {
		private _marker = createMarker ["BLWK_lootMarker_" + str _index,getPos _lootHolder];
		_marker setMarkerText "Money Pile";
		_marker setMarkerType "hd_dot";
		_marker setMarkerColor "ColorBlack";
		_marker
	};
	if (!BLWK_randomWeaponBoxFound AND {_lootHolder isEqualTo BLWK_randomWeaponBox}) exitWith {
		private _marker = createMarker ["BLWK_lootMarker_" + str _index,getPos _lootHolder];
		_marker setMarkerText "Random Weapon Box";
		_marker setMarkerType "hd_dot";
		_marker setMarkerColor "ColorBlack";
		_marker
	};

	private _marker = createMarker ["BLWK_lootMarker_" + str _index,getPos _lootHolder];
	_marker setMarkerType "hd_dot";
	_marker setMarkerAlpha 0.60;
	
	// see what type of loot it is
	private _lootClassName = _lootHolder getVariable "BLWK_primaryLootClass";
	private _config = ([_lootClassName] call CBAP_fnc_getItemConfig) select 0;
	_marker setMarkerText ([_config] call BIS_fnc_displayName);
	private _categoryAndType = [_lootClassName] call BIS_fnc_itemType;
	private _category = _categoryAndType select 0;
	private _type = _categoryAndType select 1;
		
	if (_category == "weapon") exitWith {
		_marker setMarkerColor "ColorPink";
		_marker
	};
	if (_category == "magazine") exitWith {
		_marker setMarkerColor "ColorBlue";
		_marker
	};
	if (_type == "headgear") exitWith {
		_marker setMarkerColor "ColorGreen";
		_marker
	};
	if (_category == "item") exitWith {
		_marker setMarkerColor "ColorGreen";
		_marker
	};
	if (_type == "backpack") exitWith {
		_marker setMarkerColor "ColorYellow";
		_marker
	};
	if (_type == "vest") exitWith {
		_marker setMarkerColor "ColorOrange";
		_marker
	};
	// set red if nothing else
	_marker setMarkerColor "ColorRed";
	
	
	_marker
};


{	
	private _marker = [_x,_forEachIndex] call _fn_setUpMarker;
	
	BLWK_lootMarkers pushBack _marker;
} forEach BLWK_spawnedLoot;
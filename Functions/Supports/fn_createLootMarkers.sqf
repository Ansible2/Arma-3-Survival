/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createLootMarkers

Description:
	Creates the loot markers when a player finds the reveal loot box.

	Executed from "BLWK_fnc_addRevealLootAction"

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
	params ["_loot","_index"];

	// checking unique items first
	if (_loot isEqualTo BLWK_supportDish) exitWith {
		private _marker = createMarker ["BLWK_lootMarker_" + str _index,getPos _loot];
		_marker setMarkerText "Support Dish";
		_marker setMarkerColor "ColorBlack";
		_marker
	};
	if (_loot isEqualTo BLWK_moneyPile) exitWith {
		private _marker = createMarker ["BLWK_lootMarker_" + str _index,getPos _loot];
		_marker setMarkerText "Money Pile";
		_marker setMarkerColor "ColorBlack";
		_marker
	};

	// see what type of loot it is
	private _configAndType = [typeOf _loot] call CBAP_fnc_getItemConfig;
	private _config = _configAndType select 0;
	private _type = _configAndType select 1;
	
	private _marker = createMarker ["BLWK_lootMarker_" + str _index,getPos _loot];
	_marker setMarkerText ([_config] call BIS_fnc_displayName;);
	
	if (_type == "CfgWeapons") exitWith {
		_marker setMarkerColor "ColorPink";
		_marker
	};
	if (_type == "CfgMagazines") exitWith {
		_marker setMarkerColor "ColorBlue";
		_marker
	};
	if (_type == "CfgGlasses") exitWith {
		_marker setMarkerColor "ColorGreen";
		_marker
	};
	if (_type == "isItem") exitWith {
		_marker setMarkerColor "ColorGreen";
		_marker
	};
	if (_type == "isBackpack") exitWith {
		_marker setMarkerColor "ColorYellow";
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

//CIPHER COMMENT: Don't forget these need to be deleted at round end
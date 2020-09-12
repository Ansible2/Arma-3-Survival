private _fn_setUpMarker = {
	params ["_loot","_index"];

	private _configAndType = [typeOf _loot] call CBAP_fnc_getItemConfig;
	private _config = _configAndType select 0;
	private _type = _configAndType select 1;
	
	private _marker = createMarker ["BLWK_lootMarker_" + str _index,getPos _loot];
	_marker setMarkerText ([_config] call BIS_fnc_displayName;);
	
	if (_type == "CfgWeapons") exitWith {
		_marker setMarkerColor "ColorPink";
	};
	if (_type == "CfgMagazines") exitWith {
		_marker setMarkerColor "ColorBlue";
	};
	if (_type == "CfgGlasses") exitWith {
		_marker setMarkerColor "ColorGreen";
	};
	if (_type == "isItem") exitWith {
		_marker setMarkerColor "ColorGreen";
	};
	if (_type == "isBackpack") exitWith {
		_marker setMarkerColor "ColorYellow";
	};

	// set red if nothing else
	_marker setMarkerColor "ColorRed";
};


{
	[_x,_forEachIndex] call _fn_setUpMarker;
	BLWK_lootMarkers pushBack _marker;
} forEach BLWK_spawnedLoot;

//CIPHER COMMENT: Don't forget these need to be deleted at round end
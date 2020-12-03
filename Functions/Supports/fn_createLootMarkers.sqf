/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createLootMarkers

Description:
	Creates the loot markers when a player finds the reveal loot box.
	Can now split up what loot to make markers for. 

	Executed from the action added in "BLWK_fnc_addRevealLootAction"

Parameters:
	0: _typesToShow : <ARRAY> - The types of loot to show in an array of strings
		Options: "all","weapon","magazine","headgear","item","backpack","uniform","vest"

Returns:
	NOTHING

Examples:
    (begin example)
		[["all"]] call BLWK_fnc_createLootMarkers;
    (end)

	(begin example)
		// show weapons & ammo
		[["magazine","weapon"]] call BLWK_fnc_createLootMarkers;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_typesToShow",["all"],[[]]]
];

/* ----------------------------------------------------------------------------
	Set marker variables (color,type,alpha) before creation 
---------------------------------------------------------------------------- */
private ["_markerType_temp","_markerColor_temp","_markerAlpha_temp"];
private _fn_setMarkerDetails = {
	_markerType_temp = "hd_dot"; // can change this in the future, but all are just dots for now
	_markerAlpha_temp = 0.60;

	if (_isUniqueItem_temp) exitWith {
		_markerColor_temp = "ColorBlack";
	};
	if (_category_temp == "weapon") exitWith {
		_markerColor_temp = "ColorPink";
	};
	if (_category_temp == "magazine") exitWith {
		_markerColor_temp = "ColorBlue";
	};
	if (_type_temp == "headgear") exitWith {
		_markerColor_temp = "ColorGreen";
	};
	if (_category_temp == "item") exitWith {
		_markerColor_temp = "ColorKhaki";
	};
	if (_type_temp == "backpack") exitWith {
		_markerColor_temp = "ColorYellow";
	};
	if (_type_temp == "uniform") exitWith {
		_markerColor_temp = "ColorBrown";
	};
	if (_type_temp == "vest") exitWith {
		_markerColor_temp = "ColorOrange";
	};

	_markerColor_temp = "ColorRed";
};


/* ----------------------------------------------------------------------------
	Create actual marker
---------------------------------------------------------------------------- */
private ["_marker_temp","_lootIndex_temp","_lootHolder_temp","_markerText_temp"];
private _fn_createMarker = {
	call _fn_setMarkerDetails;
	_marker_temp = createMarkerLocal ["BLWK_lootMarker_" + str _lootIndex_temp,getPos _lootHolder_temp];

	// in the future, may have more then one reveal box, this can be used to skip over things in main forEach
	//_lootHolder_temp setVariable ["BLWK_lootMarkerCreated",true]; // to make sure we don't create double markers

	_marker_temp setMarkerTextLocal _markerText_temp;
	_marker_temp setMarkerColorLocal _markerColor_temp; 
	_marker_temp setMarkerAlphaLocal _markerAlpha_temp;
	_marker_temp setMarkerType _markerType_temp;

	BLWK_lootMarkers pushBack _marker_temp;
};


/* ----------------------------------------------------------------------------
	Determines if the loot is a type to show or not
---------------------------------------------------------------------------- */
private ["_category_temp","_type_temp"];
private _fn_canLootBeShown = {
	if (_typesToShow isEqualTo ["all"]) exitWith {true};

	if (_category_temp in _typesToShow OR {_type_temp in _typesToShow}) then {
		true
	} else {
		false
	};
};


/* ----------------------------------------------------------------------------
	Sets the temp vars that are needed by everything else to determine what the current loot type is
---------------------------------------------------------------------------- */
private ["_lootClassName_temp","_config_temp","_categoryAndType_temp"];
private _fn_setLootInfoToCheck = {
	// handle unique items
	if (!BLWK_supportDishFound AND {_lootHolder_temp isEqualTo BLWK_supportDish}) exitWith {
		_markerText_temp = "Support Dish";
		true
	};
	if (!(isNil "BLWK_moneyPile") AND {_lootHolder_temp isEqualTo BLWK_moneyPile}) exitWith {
		_markerText_temp = "Money Pile";
		true
	};
	if (!BLWK_randomWeaponBoxFound AND {_lootHolder_temp isEqualTo BLWK_randomWeaponBox}) exitWith {
		_markerText_temp = "Random Weapon Box";
		true
	};


	// default loot start
	_lootClassName_temp = _lootHolder_temp getVariable ["BLWK_primaryLootClass",""];
	_category_temp = "";
	_type_temp = "";
	
	// get cfg info if loot class is defined
	if !(_lootClassName_temp isEqualTo "") then {
		_config_temp = ([_lootClassName_temp] call CBAP_fnc_getItemConfig) select 0;
		_markerText_temp = [_config_temp] call BIS_fnc_displayName;
		
		_categoryAndType_temp = [_lootClassName_temp] call BIS_fnc_itemType;
		_category_temp = toLowerANSI (_categoryAndType_temp select 0);
		_type_temp = toLowerANSI (_categoryAndType_temp select 1);
	} else {
		_markerText_temp = "unknown";
	};

	false
};


/* ----------------------------------------------------------------------------
	Main body
---------------------------------------------------------------------------- */
private "_isUniqueItem_temp";
{
	_lootHolder_temp = _x;
	_isUniqueItem_temp = call _fn_setLootInfoToCheck;
	if (_isUniqueItem_temp) then {
		_category_temp = "unique";
	};

	if (call _fn_canLootBeShown) then {
		_lootIndex_temp = _forEachIndex;
		call _fn_createMarker;
	};
} forEach BLWK_spawnedLoot;








/*
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
	private _lootClassName = _lootHolder getVariable ["BLWK_primaryLootClass",""];
	if (_lootClassName isEqualTo "") then {
		_marker setMarkerText "Unknown";
	} else {
		private _config = ([_lootClassName] call CBAP_fnc_getItemConfig) select 0;
		_marker setMarkerText ([_config] call BIS_fnc_displayName);
	};
	
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
		_marker setMarkerColor "ColorKhaki";
		_marker
	};
	if (_type == "backpack") exitWith {
		_marker setMarkerColor "ColorYellow";
		_marker
	};
	if (_type == "uniform") exitWith {
		_marker setMarkerColor "ColorBrown";
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

*/
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createLootMarkers

Description:
	Creates the loot markers when a player finds the reveal loot box.
	Can now split up what loot to make markers for.

	Executed from the action added in "BLWK_fnc_addRevealLootAction"

Parameters:
	0: _typesToShow : <ARRAY or STRING> - The types of loot to show in an array of strings
		Options: "all","weapon","magazine","headgear","item","backpack","uniform","vest"

Returns:
	NOTHING

Examples:
    (begin example)
		["all"] call BLWK_fnc_createLootMarkers;
    (end)

	(begin example)
		// show weapons & ammo
		[["magazine","weapon"]] call BLWK_fnc_createLootMarkers;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_createLootMarkers";

#define UNIQUE_ITEMS_COLOR "ColorBlack"
#define WEAPONS_COLOR "ColorPink"
#define MAGAZINES_COLOR "ColorBlue"
#define HEADGEAR_COLOR "ColorGreen"
#define ITEMS_COLOR "ColorKhaki"
#define BACKPACKS_COLOR "ColorYellow"
#define UNIFORMS_COLOR "ColorBrown"
#define VESTS_COLOR "ColorOrange"
#define UNKNOWN_COLOR "ColorRed"
#define UNIQUE_ITEMS_ARRAY\
	[\
		missionNamespace getVariable ["BLWK_moneyPile",objNull],\
		missionNamespace getVariable ["BLWK_randomWeaponBox",objNull],\
		missionNamespace getVariable ["BLWK_supportDish",objNull]\
	]

if (!isServer) exitWith {};

params [
	["_typesToShow",[],[[],""]]
];

if (_typesToShow isEqualTo [] OR {_typesToShow isEqualTo ""}) exitWith {
	["_typesToShow is empty",true] call KISKA_fnc_log;
	nil
};

if (_typesToShow isEqualType "") then {
	_typesToShow = [_typesToShow];
};

/* ----------------------------------------------------------------------------
	Set marker variables (color,type,alpha) before creation
---------------------------------------------------------------------------- */
private ["_markerType_temp","_markerColor_temp","_markerAlpha_temp"];
private _fn_setMarkerDetails = {
	_markerType_temp = "hd_dot"; // can change this in the future, but all are just dots for now
	_markerAlpha_temp = 0.60;

	if (_category_temp == "unique") exitWith {
		_markerColor_temp = UNIQUE_ITEMS_COLOR
	};
	if (_category_temp == "weapon") exitWith {
		_markerColor_temp = WEAPONS_COLOR;
	};
	if (_category_temp == "magazine") exitWith {
		_markerColor_temp = MAGAZINES_COLOR;
	};
	if (_type_temp == "headgear") exitWith {
		_markerColor_temp = HEADGEAR_COLOR;
	};
	if (_category_temp == "item") exitWith {
		_markerColor_temp = ITEMS_COLOR;
	};
	if (_type_temp == "backpack") exitWith {
		_markerColor_temp = BACKPACKS_COLOR;
	};
	if (_type_temp == "uniform") exitWith {
		_markerColor_temp = UNIFORMS_COLOR;
	};
	if (_type_temp == "vest") exitWith {
		_markerColor_temp = VESTS_COLOR;
	};

	_markerColor_temp = UNKNOWN_COLOR;
};


/* ----------------------------------------------------------------------------
	Create actual marker
---------------------------------------------------------------------------- */
private _markerText_temp = "";
private _lootHolder_temp = objNull;
private _marker_temp = "";
private _lootIndex_temp = 0;

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
private _category_temp = "";
private _type_temp = "";

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
private _lootClassName_temp = "";
private _config_temp = configNull;
private _categoryAndType_temp = [];

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
	if (_lootClassName_temp isNotEqualTo "") then {
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
if (_typesToShow isNotEqualTo ["unique"]) then {
	{

		_lootHolder_temp = _x;

		call _fn_setLootInfoToCheck;

		if (call _fn_canLootBeShown) then {
			_lootIndex_temp = _forEachIndex;
			call _fn_createMarker;
		};

	} forEach BLWK_lootHolders;
};

if ("unique" in _typesToShow OR {"all" in _typesToShow}) then {
	{
		if !(isNull _x) then {
			_lootHolder_temp = _x;
			_category_temp = "unique";
			call _fn_setLootInfoToCheck;

			if (call _fn_canLootBeShown) then {
				_lootIndex_temp = _lootIndex_temp + 1;
				call _fn_createMarker;
			};
		};
	} forEach UNIQUE_ITEMS_ARRAY;
};

nil

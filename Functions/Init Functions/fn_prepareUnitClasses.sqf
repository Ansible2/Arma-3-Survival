#include "..\..\Headers\Faction Map Ids.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareUnitClasses

Description:
	Gets the user selected unit class tables to used for each level
	 and returns them in several hash maps within a master array

	Executed from "BLWK_fnc_prepareGlobals"

Parameters:
	NONE

Returns:
	ARRAY - Formatted as:
		- friendly faction hash map
		- level 1 enemy faction hash map
		- level 2 enemy faction hash map
		- level 3 enemy faction hash map
		- level 4 enemy faction hash map
		- level 5 enemy faction hash map

Examples:
    (begin example)
		_classes = call BLWK_fnc_prepareUnitClasses;
    (end)

Author(s):
	Ansible2 // Cipher,
	Hilltop(Willtop) & omNomios
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_prepareUnitClasses";


private _fn_exitForUndefinedDefault = {
	[] spawn {
		["A default faction appears to be empty, the mission will now end to reconfigure parameters",true] remoteExecCall ["KISKA_fnc_log",0];
		sleep 20;
		["UnitClassesErrorEnd"] call BIS_fnc_endMissionServer;
	};
};


private [
	"_infantryClasses",
	"_lighCarClasses",
	"_heavyCarClasses",
	"_heavyArmorClasses",
	"_transportHelicopterClasses",
	"_cargoAircraftClasses",
	"_casAircraftClasses",
	"_attackHelicopterClasses",
	"_heavyGunshipClasses"
];
// Sort a faction's units based upon what DLC is excluded and whether or not a unit class exists
private _vehicleConfig = configFile >> "cfgVehicles";
private _fn_sortFactionClasses = {
	params ["_configToCheck"];

	private _factionClassesHashMap = createHashMap;

	private _fn_sortArray = {
		params ["_id","_sortArray"];

		private _availableClasses = [];
		if (_sortArray isNotEqualTo []) then {
			_sortArray apply {
				if (isClass (_vehicleConfig >> _x)) then {
					_availableClasses pushBack (toLowerANSI _x);

				};
			};
		};

		_factionClassesHashMap set [_id,_availableClasses];
	};


	[
		INFANTRY_FACTION_MAP_ID,
		[_configToCheck >> "infantry"] call BIS_fnc_getCfgDataArray
	] call _fn_sortArray;
	// exit if no infantry
	if ((_factionClassesHashMap get INFANTRY_FACTION_MAP_ID) isEqualTo []) exitWith {
		[["Found no infantry classes in config ",_configToCheck],true] call KISKA_fnc_log;
		[]
	};


	[
		[
			LIGHT_CAR_FACTION_MAP_ID,
			[_configToCheck >> "lightCars"] call BIS_fnc_getCfgDataArray
		],
		[
			HEAVY_CAR_FACTION_MAP_ID,
			[_configToCheck >> "heavyCars"] call BIS_fnc_getCfgDataArray
		],
		[
			LIGHT_ARMOR_FACTION_MAP_ID,
			[_configToCheck >> "lightArmor"] call BIS_fnc_getCfgDataArray
		],
		[
			HEAVY_ARMOR_FACTION_MAP_ID,
			[_configToCheck >> "heavyArmor"] call BIS_fnc_getCfgDataArray
		],
		[
			TRANSPORT_HELI_FACTION_MAP_ID,
			[_configToCheck >> "transportHelicopters"] call BIS_fnc_getCfgDataArray
		],
		[
			CARGO_ACFT_FACTION_MAP_ID,
			[_configToCheck >> "cargoAircraft"] call BIS_fnc_getCfgDataArray
		],
		[
			CAS_ACFT_FACTION_MAP_ID,
			[_configToCheck >> "casAircraft"] call BIS_fnc_getCfgDataArray
		],
		[
			ATTACK_HELI_FACTION_MAP_ID,
			[_configToCheck >> "attackHelicopters"] call BIS_fnc_getCfgDataArray
		],
		[
			HEAVY_GUNSHIP_FACTION_MAP_ID,
			[_configToCheck >> "heavyGunships"] call BIS_fnc_getCfgDataArray
		]
	] apply {
		_x call _fn_sortArray;
	};


	_factionClassesHashMap
};


private _factionNames = call BLWK_fnc_KISKAParams_populateFactionList;
private _everyFactionConfigHashMap = _factionNames createHashMapFromArray (localNamespace getVariable "BLWK_factionConfigs");


private _fn_getSelectedClasses = {
	params ["_factionString","_defaultFactionString"];

	private _factionMap = [];
	private _goToDefaultFaction = false;

	private _factionConfigPath = _everyFactionConfigHashMap getOrDefault [_factionString,configNull];
	// if a faction was found for the string
	if !(isNull _factionConfigPath) then {
		_factionMap = [_factionConfigPath] call _fn_sortFactionClasses;

		if (_factionMap isEqualTo []) then {
			[["Faction ",_factionString," returned empty array, going to faction ",_defaultFactionString],true] call KISKA_fnc_log;
			_goToDefaultFaction = true
		};

	} else {
		[["Faction ",_factionString," was not found, going to default faction ",_defaultFactionString],true] call KISKA_fnc_log;
		_goToDefaultFaction = true

	};


	// default fall through faction if the selected is unavailable
	if (_goToDefaultFaction) then {
		private _doExit = false;
		_factionConfigPath = _everyFactionConfigHashMap getOrDefault [_defaultFactionString,configNull];

		if !(isNull _factionConfigPath) then {
			_factionMap = [_factionConfigPath] call _fn_sortFactionClasses;

			// if faction still came up empty
			if (_factionMap isEqualTo []) then {
				_doExit = true;
			};

		} else {
			_doExit = true;

		};


		if (_doExit AND {isServer}) then {
			call _fn_exitForUndefinedDefault
		};
	};

	_factionMap
};


// get faction classes
private _friendlyFactionMap = [BLWK_friendlyFaction,"VANILLA - NATO"] call _fn_getSelectedClasses;
private _level_1_factionMap = [BLWK_level1Faction,"VANILLA - FIA"] call _fn_getSelectedClasses;
private _level_2_factionMap = [BLWK_level2Faction,"VANILLA - AAF"] call _fn_getSelectedClasses;
private _level_3_factionMap = [BLWK_level3Faction,"VANILLA - CSAT"] call _fn_getSelectedClasses;
private _level_4_factionMap = [BLWK_level4Faction,"VANILLA - CSAT URBAN"] call _fn_getSelectedClasses;
private _level_5_factionMap = [BLWK_level5Faction,"APEX - VIPER"] call _fn_getSelectedClasses;


// return for global var definition
[
	_friendlyFactionMap,
	_level_1_factionMap,
	_level_2_factionMap,
	_level_3_factionMap,
	_level_4_factionMap,
	_level_5_factionMap
]
